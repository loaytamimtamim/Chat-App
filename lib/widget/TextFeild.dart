import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Textfeild extends StatelessWidget {
  // ignore: non_constant_identifier_names
  Textfeild(
      {super.key,
      required this.text,
      required this.text_hind,
      this.onChange,
      required bool isPassword});
  String? text_hind;
  String? text;
  Function(String)? onChange;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (data) {
        if (data!.isEmpty) {
          return 'not fount data';
        }
        return null;
      },
      onChanged: onChange,
      decoration: InputDecoration(
          hintText: text_hind,
          hintStyle: const TextStyle(color: Colors.white),
          label: Text(
            text!,
            style: const TextStyle(color: Colors.white),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.white,
            ),
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.white,
            ),
          ),
          border: const OutlineInputBorder(
              borderSide: BorderSide(
            color: Colors.white,
          ))),
    );
  }
}
