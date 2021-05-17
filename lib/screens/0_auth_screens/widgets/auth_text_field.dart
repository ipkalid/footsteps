import 'package:flutter/material.dart';
import 'package:footsteps/styles/app_colors.dart';

class AuthTextField extends StatelessWidget {
  const AuthTextField({
    Key? key,
    required this.controller,
    required this.label,
    this.keyboardType,
    this.icon,
    this.hint,
    this.isPassword = false,
  }) : super(key: key);

  final TextEditingController controller;
  final String label;
  final TextInputType? keyboardType;
  final IconData? icon;
  final String? hint;
  final bool isPassword;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              label,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: AppColor.darkGreen,
              ),
            ),
          ],
        ),
        TextField(
          cursorColor: AppColor.lightGreen,
          keyboardType: keyboardType,
          controller: controller,
          obscureText: isPassword,
          style: TextStyle(
            color: AppColor.darkGreen,
            fontSize: 22,
            fontWeight: FontWeight.w500,
          ),
          decoration: InputDecoration(
            hintText: hint,
            prefixIcon: Icon(
              icon,
              color: AppColor.lightGreen,
            ),
            prefix: Text("   "),
            prefixIconConstraints: BoxConstraints(
              minWidth: 0,
              minHeight: 0,
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: AppColor.lightGreen, width: 3),
            ),
          ),
        ),
      ],
    );
  }
}
