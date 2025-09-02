import 'package:flutter/material.dart';
// import 'package:resturant_app/core/utils/app_style.dart';

class CustomTextButton extends StatelessWidget {
  const CustomTextButton({super.key, this.onPressed , required this.widgt});
  final Function()? onPressed;
  // final String text;
  final Widget widgt ;
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: AspectRatio(
        aspectRatio: 3.6 / 0.7,
        child: Container(
          decoration: BoxDecoration(
            color: Color(0xffE82933),
            borderRadius: BorderRadius.circular(70),
          ),
          child: Center(
            child: widgt
          ),
        ),
      ),
    );
  }
}
