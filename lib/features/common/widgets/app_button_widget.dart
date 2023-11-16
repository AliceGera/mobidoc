import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

// ignore: public_member_api_docs
class AppButtonWidget extends StatelessWidget {
  final String title;
  final bool isEnable;
  final VoidCallback? onPressed;
  final int? index;
  final String? image;

  const AppButtonWidget({
    super.key,
    required this.title,
    this.isEnable = true,
    this.onPressed,
    this.index,
    this.image,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(Color(0xff007AFE)), /*MaterialStateProperty.all<Color>(
          isEnable ? AppColor.green : AppColor.background,
        ),*/
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
            //SvgPicture.asset(image ?? ''),
            Text(
              title,
              /*style: AppTextStyle.button.copyWith(
                color: isEnable ? AppColor.white : AppColor.inactiveBlack,
              ),*/
            ),
          ],
        ),
      ),
    );
  }
}
