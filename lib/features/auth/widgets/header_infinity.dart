import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/constant/color_constant.dart';

Widget headerLogo() {
  return Stack(
    alignment: Alignment.center,
    children: [
      Positioned(
        child: Image.asset(
          'assets/icon/logo.png',
          width: double.infinity,
          height: 200,
        ),
      ),
      Positioned(
        bottom: 20,
        child: Text(
          'Loop of Knowledge',
          style: GoogleFonts.lacquer(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: ColorConstant().second,
          ),
        ),
      ),
    ],
  );
}
