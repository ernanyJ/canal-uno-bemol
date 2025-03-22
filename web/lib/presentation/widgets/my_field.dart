import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyField extends StatelessWidget {
  final TextEditingController inputController;
  final String? hint;
  final Widget? icon;
  final String? Function(String?)? validator;
  final bool obscureText;
  final List<TextInputFormatter>? inputFormatters;
  final void Function(String)? onChanged;

  const MyField({
    super.key,
    required this.inputController,
    this.hint,
    this.icon,
    this.validator,
    this.obscureText = false,
    this.inputFormatters,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
          offset: const Offset(12, 26),
          blurRadius: 50,
          spreadRadius: 0,
          color: Colors.grey.withOpacity(.1),
        ),
      ]),
      child: TextFormField(
        validator: validator,
        obscureText: obscureText,
        inputFormatters: inputFormatters,
        controller: inputController,
        onChanged: onChanged,
        style: const TextStyle(fontSize: 14, color: Colors.black),
        decoration: InputDecoration(
          prefixIcon: icon,
          filled: true,
          hintText: hint,
          hintStyle: TextStyle(color: Colors.grey.withOpacity(.75)),
          contentPadding: const EdgeInsets.symmetric(
            vertical: 10.0, // Adjusted for better spacing
            horizontal: 20.0,
          ),
          border: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue, width: 1.0),
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue, width: 1.0),
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
          ),
          errorBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red, width: 1.0),
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue, width: 1.0),
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
          ),
          // Optional: Limit error message lines
          errorMaxLines: 2,
        ),
      ),
    );
  }
}
