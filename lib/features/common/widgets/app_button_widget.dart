// ignore: duplicate_ignore
// ignore_for_, duplicate_ignore-file: public_member_api_docs
// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:flutter_template/assets/colors/app_colors.dart';

// ignore: public_member_api_docs
class AppButtonWidget extends StatelessWidget {
  final String title;
  final bool isEnable;
  final VoidCallback? onPressed;
  final int? index;
  final String? image;

  // ignore: public_member_api_docs
  const AppButtonWidget({
    required this.title,
    super.key,
    this.isEnable = true,
    this.onPressed,
    this.index,
    this.image,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(AppColors.darkBlue),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
        ),
      ),
      onPressed: onPressed,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 14,
          horizontal: 16,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
            ),
          ],
        ),
      ),
    );
  }
}
