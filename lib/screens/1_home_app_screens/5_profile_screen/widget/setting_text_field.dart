import 'package:flutter/material.dart';
import 'package:footsteps/styles/app_colors.dart';

class SettingTextField extends StatelessWidget {
  const SettingTextField({
    Key? key,
    required this.controller,
    required this.label,
    this.keyboardType,
    this.icon,
    this.hint,
    this.isPassword = false,
    this.suffix,
  }) : super(key: key);

  final TextEditingController controller;
  final String label;
  final TextInputType? keyboardType;
  final IconData? icon;
  final String? hint;
  final bool isPassword;
  final String? suffix;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: AppColor.black,
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
            prefixIcon: icon == null
                ? null
                : Icon(
                    icon,
                    color: AppColor.lightGreen,
                  ),
            prefix: icon == null ? null : Text("   "),
            prefixIconConstraints: icon == null
                ? null
                : BoxConstraints(
                    minWidth: 0,
                    minHeight: 0,
                  ),
            suffixText: suffix == null ? null : suffix,
            suffixStyle: TextStyle(
              color: AppColor.darkGreen,
              fontSize: 22,
              fontWeight: FontWeight.w500,
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
