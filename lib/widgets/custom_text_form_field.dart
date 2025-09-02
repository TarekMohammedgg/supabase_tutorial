import 'package:flutter/material.dart';
import 'package:supabase_tutorial/utils/utils/app_style.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    required this.controller,
    required this.hintText,
  });
  final TextEditingController controller;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return "Please Enter value in the field";
        } else {
          return null;
        }
      },

      decoration: InputDecoration(
        filled: true,
        enabledBorder: inputBorder(),

        focusedBorder: inputBorder(),
        hintText: hintText,
        hintStyle: AppStyle.styleRegular16,
      ),
    );
  }

  OutlineInputBorder inputBorder() {
    return OutlineInputBorder(
      borderSide: BorderSide(color: Colors.white),

      borderRadius: BorderRadius.circular(10),
    );
  }
}
