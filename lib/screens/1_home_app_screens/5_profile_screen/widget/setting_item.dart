import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SettingItem extends StatelessWidget {
  SettingItem({
    required this.label,
    this.icon,
    this.awsomeIcon,
    required this.onTap,
  });
  final String label;
  final IconData? icon;
  final IconData? awsomeIcon;
  final void Function() onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Row(
          children: [
            (awsomeIcon == null)
                ? Icon(
                    this.icon,
                    size: 32,
                  )
                : FaIcon(
                    this.awsomeIcon,
                    size: 32,
                  ),
            SizedBox(width: 12),
            Expanded(
              child: Text(
                this.label,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
            ),
            Icon(Icons.arrow_forward_ios, size: 16),
          ],
        ),
      ),
    );
  }
}
