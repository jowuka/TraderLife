import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ConfiguredText extends StatelessWidget {
  const ConfiguredText({super.key, required this.text});
  final String text;
  @override
  Widget build(BuildContext context) {
    return Text(text,
    style: GoogleFonts.lato(
      textStyle: const TextStyle(
          color: Color.fromARGB(255, 186, 186, 186),
          fontWeight: FontWeight.bold),
    )
    );
  }
}
