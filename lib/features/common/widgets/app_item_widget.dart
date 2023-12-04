// ignore: duplicate_ignore
// ignore_for_, duplicate_ignore-file: public_member_api_docs
// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_template/assets/colors/app_colors.dart';
import 'package:flutter_template/assets/res/resources.dart';
import 'package:flutter_template/assets/text/text_style.dart';

// ignore: public_member_api_docs
class AppItemWidget extends StatelessWidget {
  final String title;
  final String textInfo;

  // ignore: public_member_api_docs
  const AppItemWidget({
    required this.title,
    required this.textInfo,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: AppColors.lightBlueItem,
          borderRadius: BorderRadius.circular(50),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 17),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: AppTextStyle.semiBold18.value.copyWith(
                        color: AppColors.black,
                      ),
                    ),
                    Text(
                      textInfo,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyle.medium14.value.copyWith(
                        color: AppColors.darkGray,
                      ),
                    ),
                  ],
                ),
              ),
              Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    width: 50,
                    height: 50,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: AppColors.blueItem,
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                  ),
                  SvgPicture.asset(
                    SvgIcons.iconList,
                    height: 24,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
