// ignore: duplicate_ignore
// ignore_for_, duplicate_ignore-file: public_member_api_docs
// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:flutter_template/assets/colors/app_colors.dart';
import 'package:shimmer/shimmer.dart';

// ignore: public_member_api_docs
class AppDoctorLoadingWidget extends StatelessWidget {
  // ignore: public_member_api_docs
  const AppDoctorLoadingWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Shimmer.fromColors(
        baseColor: AppColors.lightBlueItem,
        highlightColor: AppColors.lightBlueItem.withOpacity(0.4),
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: AppColors.lightBlueItem,
            borderRadius: BorderRadius.circular(50),

          ),
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 35),
          ),
        ),
      ),
    );
  }
}
