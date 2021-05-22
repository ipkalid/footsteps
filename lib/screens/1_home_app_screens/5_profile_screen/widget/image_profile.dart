import 'package:flutter/material.dart';
import 'package:footsteps/styles/app_colors.dart';

class ProfileImageView extends StatelessWidget {
  const ProfileImageView({
    Key? key,
    required this.src,
  }) : super(key: key);
  final String src;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64,
      width: 64,
      margin: EdgeInsets.only(top: 8, bottom: 8, left: 0, right: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(16),
        ),
        boxShadow: [
          BoxShadow(
              blurRadius: 8,
              color: AppColor.black.withOpacity(.3),
              offset: Offset(0, 8))
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.all(
          Radius.circular(16),
        ),
        child: Image.network(
          src,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
