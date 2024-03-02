import 'package:flutter/material.dart';
import 'package:pakwanderer/Constants/constants.dart';

passwordTextField(TextEditingController controller, String hintText,
    bool obsecure, Function()? onTap) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: TextField(
      obscureText: obsecure,
      controller: controller,
      decoration: InputDecoration(
        suffixIcon: IconButton(
          onPressed: onTap,
          icon: obsecure
              ? Icon(
                  Icons.visibility,
                  color: secondaryColor,
                )
              : Icon(
                  Icons.visibility_off,
                  color: secondaryColor,
                ),
        ),
        hintText: hintText,
        hintStyle: const TextStyle(color: Colors.grey),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(color: secondaryColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(color: secondaryColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(color: secondaryColor),
        ),
      ),
    ),
  );
}
