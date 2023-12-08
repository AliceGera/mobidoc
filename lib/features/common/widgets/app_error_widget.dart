// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_template/assets/res/resources.dart';
import 'package:flutter_template/assets/text/text_style.dart';
import 'package:flutter_template/features/common/widgets/app_button_widget.dart';

class AppErrorWidget extends StatelessWidget {
  final String wrongText;
  final bool? isLogin;

  const AppErrorWidget({
    required this.wrongText,
    this.isLogin,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 58),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 36),
            child: SvgPicture.asset(SvgIcons.iconWrongPasswordEmail),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 15),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text(
                  wrongText,
                  style: AppTextStyle.semiBold18.value,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
          //isLogin == true ? SizedBox() : AppButtonWidget(title: 'Повторить'),
        ],
      ),
    );
  }
}
