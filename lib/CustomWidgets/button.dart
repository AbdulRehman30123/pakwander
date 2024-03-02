import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pakwanderer/Constants/constants.dart';

roundedButton(Function()? onTap, String buttonTitle) {
  return GestureDetector(
    onTap: onTap,
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        alignment: Alignment.center,
        height: 50,
        width: double.infinity,
        decoration: BoxDecoration(
          color: secondaryColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          buttonTitle,
          style: GoogleFonts.plusJakartaSans(
              fontSize: 20,
              color: Colors.white,
              fontWeight: FontWeight.w700,
              fontStyle: FontStyle.italic),
        ),
      ),
    ),
  );
}
