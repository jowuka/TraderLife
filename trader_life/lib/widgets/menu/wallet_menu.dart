import 'package:flutter/material.dart';
import 'package:device_screen_size/device_screen_size.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trader_life/data/data_currency.dart';
import 'package:trader_life/models/user_model.dart';
import 'package:trader_life/utility/timer_mining.dart';

class WalletMenu extends StatefulWidget {
  const WalletMenu({super.key});

  @override
  _WalletMenuState createState() => _WalletMenuState();
}

class _WalletMenuState extends State<WalletMenu> {
  late Stream<Map<String, double>> _coinStream;
  Map<String, double> _coinTotals = {};
  String _fromCoin = 'BTC';
  String _toCoin = 'ETH';
  double _fromAmount = 0.0;
  double _toAmount = 0.0;

  final Map<String, double> _coinPrices = {
    'BTC': CoinData.coins['BTC']!.currentPrice,
    'ETH': CoinData.coins['ETH']!.currentPrice,
    'SOL': CoinData.coins['SOL']!.currentPrice,
    'USD': CoinData.coins['USD']!.currentPrice,
  };

  @override
  void initState() {
    super.initState();
    _coinStream = TimerService().totalCoinStream; // Stream'i dinliyoruz
    _loadCoinTotals();
  }

  Future<void> _loadCoinTotals() async {

    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _coinTotals = {
        'BTC': prefs.getDouble('userBTC') ?? 0.0,
        'ETH': prefs.getDouble('userETH') ?? 0.0,
        'SOL': prefs.getDouble('userSOL') ?? 0.0,
        'USD': prefs.getDouble('userCash')?? 0.0,
      };
      _fromAmount = _coinTotals[_fromCoin] ?? 0.0;
      _toAmount = _calculateToAmount();
    });
  }

  double _calculateToAmount() {
    if (_coinPrices[_fromCoin] != null && _coinPrices[_toCoin] != null) {
      return (_fromAmount * _coinPrices[_fromCoin]!) / _coinPrices[_toCoin]!;
    }
    return 0.0;
  }

Future<void> _handleExchange(UserModel userModel) async {
  TimerService().stopTimer();
  TimerService().startTimer();
  double supFrom = _fromAmount;
  double supTo = _toAmount;
  if (_fromAmount > 0 && _fromAmount <= (_coinTotals[_fromCoin] ?? 0.0)) {
    setState(() {
      _coinTotals[_fromCoin] = (_coinTotals[_fromCoin] ?? 0.0) - _fromAmount;
      _coinTotals[_toCoin] = (_coinTotals[_toCoin] ?? 0.0) + _toAmount;
      _fromAmount = 0.0;
      _toAmount = 0.0;
    });

    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('user$_fromCoin', _coinTotals[_fromCoin] ?? 0.0);
    await prefs.setDouble('user$_toCoin', _coinTotals[_toCoin] ?? 0.0);

    if (_fromCoin == 'USD') {
      userModel.spendCash(supFrom);
    } else if (_toCoin == 'USD') {
      userModel.addCash(supTo);
    } else {
      userModel.updateCoin(_fromCoin, _coinTotals[_fromCoin]!);
      userModel.updateCoin(_toCoin, _coinTotals[_toCoin]!);
    }
  }

}

  @override
  Widget build(BuildContext context) {
    final userModel = Provider.of<UserModel>(context);
    double screenHeight = DeviceScreenSize.screenHeightInPercentage(context, percentage: 0.83);
    double screenWidth = DeviceScreenSize.screenWidthInPercentage(context, percentage: 0.84);

    return Dialog(
      child: StreamBuilder<Map<String, double>>(
        stream: _coinStream,
        builder: (context, snapshot) {

          if (snapshot.hasData) {
            _coinTotals = snapshot.data!;
          }

          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              color: const Color.fromARGB(255, 33, 33, 33),
            ),
            padding: const EdgeInsets.all(16.0),
            height: screenHeight,
            width: screenWidth,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Başlık
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    color: const Color.fromARGB(255, 104, 104, 104),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Row(
                      children: [
                        const Text(
                          'Exchange Coins',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        const Spacer(),
                        GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: const Icon(Icons.close),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Takas arayüzü
                Row(
                  children: [
                    // Soldaki dropdown ve miktar
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          DropdownButton<String>(
                            value: _fromCoin,
                            dropdownColor: const Color.fromARGB(255, 33, 33, 33),
                            items: _coinTotals.keys.map((coin) {
                              return DropdownMenuItem(
                                value: coin,
                                child: Text(
                                      '$coin - ${coin == 'USD' ? (_coinTotals[coin]?.toStringAsFixed(2) ?? 0.0) : (_coinTotals[coin]?.toStringAsFixed(12) ?? 0.0)}',
                                  style: TextStyle(color: Colors.grey.shade400),
                                ),
                              );
                            }).toList(),
                            onChanged: (newValue) {
                              if (newValue != null) {
                                setState(() {
                                  _fromCoin = newValue;
                                  _fromAmount = _coinTotals[newValue] ?? 0.0;
                                  _toAmount = _calculateToAmount();
                                  if (_fromCoin == _toCoin) {
                                    _toCoin = _coinTotals.keys.firstWhere((key) => key != _fromCoin);
                                  }
                                });
                              }
                            },
                          ),
                          Slider(
                            value: (_fromAmount / (_coinTotals[_fromCoin] ?? 1.0)).clamp(0.0, 1.0),
                            min: 0,
                            max: 1,
                            onChanged: (normalizedValue) {
                              double newValue = normalizedValue * (_coinTotals[_fromCoin] ?? 1.0);
                              setState(() {
                                _fromAmount = newValue;
                                _toAmount = _calculateToAmount();
                              });
                            },
                          ),
                          TextField(
                            controller: TextEditingController(
                                text: _fromAmount.toStringAsFixed(14)),
                            style: const TextStyle(color: Color.fromARGB(255, 187, 187, 187)),
                            readOnly: true,
                            decoration: const InputDecoration(
                              labelText: 'Amount',
                            ),
                          ),
                          Text(
                            'Balance: ${_coinTotals[_fromCoin]?.toStringAsFixed(12) ?? 0.0} $_fromCoin',
                            style: const TextStyle(color: Color.fromARGB(255, 187, 187, 187)),
                          ),
                        ],
                      ),
                    ),

                    // Aradaki ok
                    const Icon(Icons.arrow_forward, color: Colors.white, size: 32),

                    // Sağdaki dropdown ve miktar
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          DropdownButton<String>(
                            value: _toCoin,
                            dropdownColor: const Color.fromARGB(255, 33, 33, 33),
                            items: _coinTotals.keys
                                .where((coin) => coin != _fromCoin)
                                .map((coin) {
                              return DropdownMenuItem(
                                value: coin,
                                child: Text(
                                  '$coin - ${_coinTotals[coin]?.toStringAsFixed(12) ?? 0.0}',
                                  style: TextStyle(color: Colors.grey.shade400),
                                ),
                              );
                            }).toList(),
                            onChanged: (newValue) {
                              if (newValue != null) {
                                setState(() {
                                  _toCoin = newValue;
                                  _toAmount = _calculateToAmount();
                                });
                              }
                            },
                          ),
                          Text(
                            'Receive: ${_toAmount.toStringAsFixed(14)} $_toCoin',
                            style: const TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                // Exchange butonu
                Center(
                  child: ElevatedButton(
                    onPressed: () => _handleExchange(userModel),
                    child: const Text('Exchange'),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
