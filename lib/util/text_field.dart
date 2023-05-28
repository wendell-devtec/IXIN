import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Widget textField({
  required String hintText,
  required IconData icon,
  required TextInputType inputType,
  int? maxLines,
  TextEditingController? controller,
  String? Function(dynamic value)? validator,
  int? maxLength,
  TextStyle? style,
}) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 25, left: 10 , right: 10),
    child: TextFormField(
      cursorColor: Colors.orange,
      controller: controller,
      keyboardType: inputType,
      validator: validator,
      maxLines: maxLines,
      maxLength: maxLength,
      style: style,
      inputFormatters: [
        FilteringTextInputFormatter.deny(
          RegExp(
            r'[\u{1F3FB}-\u{1F3FF}|\u{1F1E6}-\u{1F1FF}|[\u{1F170}-\u{1F9FF}]'
            r'[\u{1F600}-\u{1F64F}'
            r'|\u{1F300}-\u{1F5FF}'
            r'|\u{1F680}-\u{1F6FF}'
            r'|\u{2600}-\u{26FF}\u{2700}-\u{27BF}]',
            unicode: true,
            dotAll: true,
          ),
        ),
      ],

      decoration: InputDecoration(
        prefixIcon: Container(
          margin: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Colors.black,
          ),
          child: Icon(
            icon,
            size: 20,
            color: Colors.white,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
            color: Colors.transparent,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
            color: Colors.transparent,
          ),
        ),
        hintText: hintText,
        alignLabelWithHint: true,
        border: InputBorder.none,
        fillColor: Colors.purple.shade50,
        filled: true,
      ),
    ),
  );
}