// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_template/assets/colors/app_colors.dart';
import 'package:flutter_template/assets/res/resources.dart';
import 'package:flutter_template/assets/text/text_style.dart';

class AppDoctorWidget extends StatelessWidget {
  final String doctor;
  final String doctorName;

  const AppDoctorWidget({
    required this.doctor,
    required this.doctorName,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: AppColors.white,
          border: Border.all(
            color: AppColors.turquoise,
            width: 2,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 22),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  SvgPicture.asset(SvgIcons.iconDoctorPhoto),
                  Text(
                    doctorName,
                    style: AppTextStyle.bold22.value,
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Text(
                  doctor,
                  style: AppTextStyle.bold14.value,
                ),
              ),
              Text(
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                'Опыт работы более 15 лет в области Опыт работы более 15 лет в области',
                style: AppTextStyle.semiBold12.value,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
