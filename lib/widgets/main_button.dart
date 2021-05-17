import 'package:flutter/material.dart';
import 'package:footsteps/styles/app_colors.dart';
import 'package:footsteps/styles/text_theme.dart';

class MainButton extends StatelessWidget {
  const MainButton({
    Key? key,
    required this.onPressed,
    required this.label,
  }) : super(key: key);

  final void Function() onPressed;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: EdgeInsets.symmetric(horizontal: 16),
      width: double.infinity,
      height: 48,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: AppColor.lightGreen,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6.0),
          ),
        ),
        child: Text(
          label,
          style: AppTextStyle.headline6,
        ),
        onPressed: onPressed,
        //onPressed: () => _goToSignUpPage(context),
        //hideShadow: true,
      ),
    );
  }
}
