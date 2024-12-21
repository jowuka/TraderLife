import 'dart:async';
import 'dart:math';
import 'package:device_screen_size/device_screen_size.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:trader_life/data/data_currency.dart';

class LeverageMenu extends StatefulWidget {
  const LeverageMenu({Key? key}) : super(key: key);

  @override
  _LeverageMenuState createState() => _LeverageMenuState();
}

class _LeverageMenuState extends State<LeverageMenu> {
  String selectedCoin = CoinData.coins.keys.first;
  double amount = 0;
  int leverage = 1;
  List<Position> positions = [];

  List<CandleData> candles = [];
  late StreamController<List<CandleData>> _candleDataStreamController;
  final Random random = Random();
  late Timer _timer;
  late CandleData _currentCandle;
  final int _candleInterval = 5; // 5 dakikalık mumlar

  @override
  void initState() {
    super.initState();
    _candleDataStreamController = StreamController<List<CandleData>>();
    _initializeCandles();
    _updateCandleData();
  }

  @override
  void dispose() {
    _timer.cancel();
    _candleDataStreamController.close();
    super.dispose();
  }

  void _initializeCandles() {
    DateTime now = DateTime.now();
    DateTime startTime = now.subtract(Duration(minutes: 100 * _candleInterval));
    candles = List.generate(100, (index) {
      return _generateCandleData(startTime.add(Duration(minutes: index * _candleInterval)));
    });
    _currentCandle = candles.last;
    _candleDataStreamController.add(candles);
  }

  void _updateCandleData() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!_candleDataStreamController.isClosed) {
        setState(() {
          DateTime now = DateTime.now();
          if (now.difference(_currentCandle.date).inMinutes >= _candleInterval) {
            // Yeni mum oluştur
            candles = [...candles.sublist(1), _currentCandle];
            _currentCandle = _generateCandleData(now);
          } else {
            // Mevcut mumu güncelle
            _updateCurrentCandle();
          }
          _candleDataStreamController.add([...candles, _currentCandle]);
        });
      } else {
        timer.cancel();
      }
    });
  }

  void _updateCurrentCandle() {
    double lastClose = _currentCandle.close;
    double basePrice = CoinData.coins[selectedCoin]!.currentPrice;
    double change = (basePrice - lastClose) * 0.1; // Daha yumuşak değişimler için %10'unu al
    
    double newClose = lastClose + change;
    double newHigh = max(_currentCandle.high, newClose);
    double newLow = min(_currentCandle.low, newClose);
    
    _currentCandle = CandleData(
      _currentCandle.date,
      _currentCandle.open,
      newHigh,
      newLow,
      newClose,
      _currentCandle.volume + Random().nextInt(1000)
    );
  }

  CandleData _generateCandleData(DateTime date) {
    double basePrice = CoinData.coins[selectedCoin]!.currentPrice;
    double range = basePrice * 0.02; // %2'lik bir aralık
    
    double open = basePrice + (random.nextDouble() - 0.5) * range;
    double close = basePrice + (random.nextDouble() - 0.5) * range;
    double high = max(open, close) + random.nextDouble() * (range / 2);
    double low = min(open, close) - random.nextDouble() * (range / 2);
    
    return CandleData(date, open, high, low, close, random.nextInt(1000000));
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = DeviceScreenSize.screenHeightInPercentage(context, percentage: 0.83);
    double screenWidth = DeviceScreenSize.screenWidthInPercentage(context, percentage: 0.84);

    return Dialog(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          color: const Color.fromARGB(255, 33, 33, 33),
        ),
        padding: const EdgeInsets.all(16.0),
        height: screenHeight,
        width: screenWidth,
        child: Column(
          children: [
            _buildHeader(),
            Expanded(
              child: Column(
                children: [
                  _buildCoinSelector(),
                  Expanded(child: _buildChart()),
                  _buildTradingControls(),
                  Expanded(child: _buildPositionsTab()),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        color: const Color.fromARGB(255, 104, 104, 104),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
      child: Row(
        children: [
          const Text(
            'Leverage Trading',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const Spacer(),
          Text('Positions', style: TextStyle(fontSize: 14)),
        ],
      ),
    );
  }

  Widget _buildCoinSelector() {
    return DropdownButton<String>(
      value: selectedCoin,
      onChanged: (String? newValue) {
        if (newValue != null) {
          setState(() {
            selectedCoin = newValue;
            _initializeCandles();
          });
        }
      },
      items: CoinData.coins.keys.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }

  Widget _buildChart() {
    return StreamBuilder<List<CandleData>>(
      stream: _candleDataStreamController.stream,
      builder: (context, snapshot) {
        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }

        List<CandleData> data = snapshot.data!;
        double minY = data.map((e) => e.low).reduce(min);
        double maxY = data.map((e) => e.high).reduce(max);
        double padding = (maxY - minY) * 0.1;

        return SizedBox(
          height: 400,
          child: SfCartesianChart(
            margin: EdgeInsets.zero,
            plotAreaBorderWidth: 0,
            zoomPanBehavior: ZoomPanBehavior(
              enablePinching: true,
              enablePanning: true,
              enableDoubleTapZooming: true,
              enableMouseWheelZooming: true,
            ),
            primaryXAxis: DateTimeAxis(
              majorGridLines: const MajorGridLines(width: 0),
              axisLine: const AxisLine(width: 1),
              labelStyle: const TextStyle(color: Colors.white),
              dateFormat: DateFormat.Hm(),
              intervalType: DateTimeIntervalType.minutes,
              interval: 15,
            ),
            primaryYAxis: NumericAxis(
              majorGridLines: const MajorGridLines(width: 0.5, color: Colors.grey),
              axisLine: const AxisLine(width: 0),
              labelStyle: const TextStyle(color: Colors.white),
              numberFormat: NumberFormat.currency(symbol: '\$', decimalDigits: 2),
              minimum: minY - padding,
              maximum: maxY + padding,
            ),
            series: <ChartSeries>[
              CandleSeries<CandleData, DateTime>(
                dataSource: data,
                xValueMapper: (CandleData data, _) => data.date,
                lowValueMapper: (CandleData data, _) => data.low,
                highValueMapper: (CandleData data, _) => data.high,
                openValueMapper: (CandleData data, _) => data.open,
                closeValueMapper: (CandleData data, _) => data.close,
                bearColor: Colors.red,
                bullColor: Colors.green,
                enableSolidCandles: true,
              ),
            ],
            tooltipBehavior: TooltipBehavior(enable: true),
            backgroundColor: Colors.transparent,
            plotAreaBackgroundColor: Colors.transparent,
          ),
        );
      },
    );
  }

  Widget _buildTradingControls() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildButton('Long', Colors.green),
            DropdownButton<int>(
              value: leverage,
              onChanged: (int? newValue) {
                if (newValue != null) {
                  setState(() {
                    leverage = newValue;
                  });
                }
              },
              items: [1, 2, 3, 5, 10, 25, 50, 100].map<DropdownMenuItem<int>>((int value) {
                return DropdownMenuItem<int>(
                  value: value,
                  child: Text('${value}x'),
                );
              }).toList(),
            ),
            _buildButton('Short', Colors.red),
          ],
        ),
        _buildSliderAndTextField(),
      ],
    );
  }

  Widget _buildButton(String text, Color color) {
    return ElevatedButton(
      onPressed: () {
        // Implement trading logic here
      },
      style: ElevatedButton.styleFrom(backgroundColor: color),
      child: Text(text),
    );
  }

  Widget _buildSliderAndTextField() {
    return Row(
      children: [
        Expanded(
          child: Slider(
            value: amount,
            min: 0,
            max: 1000,
            divisions: 100,
            onChanged: (double value) {
              setState(() {
                amount = value;
              });
            },
          ),
        ),
        SizedBox(
          width: 100,
          child: TextField(
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: 'Amount',
              border: OutlineInputBorder(),
            ),
            onChanged: (String value) {
              setState(() {
                amount = double.tryParse(value) ?? 0;
              });
            },
          ),
        ),
      ],
    );
  }

   Widget _buildPositionsTab() {
    return ListView.builder(
      itemCount: positions.length,
      itemBuilder: (context, index) {
        Position position = positions[index];
        return ListTile(
          title: Text('${position.coin} ${position.isLong ? 'Long' : 'Short'}'),
          subtitle: Text('Amount: ${position.amount}, Leverage: ${position.leverage}x'),
          trailing: Text('PNL: ${position.pnl.toStringAsFixed(2)}'),
          onTap: () {
            // Implement position details or close position functionality
          },
        );
      },
    );
  }
}

class Position {
  final String coin;
  final bool isLong;
  final double amount;
  final int leverage;
  final double entryPrice;
  double currentPrice;

  Position({
    required this.coin,
    required this.isLong,
    required this.amount,
    required this.leverage,
    required this.entryPrice,
    required this.currentPrice,
  });

  double get pnl {
    double difference = currentPrice - entryPrice;
    if (!isLong) difference = -difference;
    return difference * amount * leverage;
  }
}

class CandleData {
  final DateTime date;
  final double open;
  final double high;
  final double low;
  final double close;
  final int volume;

  CandleData(this.date, this.open, this.high, this.low, this.close, this.volume);
}