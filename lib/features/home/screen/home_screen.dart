// ignore_for_file: public_member_api_docs, avoid_field_initializers_in_const_classes

import 'package:auto_route/auto_route.dart';
import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_template/assets/colors/app_colors.dart';
import 'package:flutter_template/assets/res/resources.dart';
import 'package:flutter_template/assets/text/text_style.dart';
import 'package:flutter_template/features/common/widgets/app_item_loading_widget.dart';
import 'package:flutter_template/features/common/widgets/app_item_widget.dart';
import 'package:flutter_template/features/home/screen/home_screen_widget_model.dart';
import 'package:flutter_template/features/navigation/domain/entity/app_route_names.dart';

/// Main widget for HomeScreen feature.
@RoutePage(
  name: AppRouteNames.homeScreen,
)
class HomeScreen extends ElementaryWidget<IHomeScreenWidgetModel> {
  /// Create an instance [HomeScreen].
  const HomeScreen({
    Key? key,
    WidgetModelFactory wmFactory = homeScreenWmFactory,
  }) : super(wmFactory, key: key);
  final bool isLoading = false;

  @override
  Widget build(IHomeScreenWidgetModel wm) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            isLoading ? _LoadingProfileWidget() : _ProfileWidget(name: 'Григорий Плювкин'),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 21, vertical: 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 40),
                    child: _NotificationsWidget(
                      isShimmer: isLoading,
                      notice: 'Уведомления',
                      doctor: 'Терапевт',
                      textFirst: 'Autoestima 2/5',
                      textSecond: 'Sin asignar',
                      textThird: 'Sin hora',
                    ),
                  ),
                  isLoading
                      ? Padding(
                          padding: const EdgeInsets.only(bottom: 25),
                          child: AppItemLoadingWidget(text: 'Последние посещения'),
                        )
                      : Padding(
                          padding: const EdgeInsets.only( bottom: 0),
                          child: Text(
                            'Последние посещения',
                            style: AppTextStyle.bold20.value,
                          ),
                        ),
                  ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: 4,
                    itemBuilder: (context, index) {
                      return isLoading
                          ? const AppItemLoadingWidget()
                          : const AppItemWidget(
                              title: 'Терапевт',
                              textInfo: '10 Июня 2023',
                            );
                    },
                    separatorBuilder: (context, index) => const SizedBox(
                      height: 16,
                    ),
                    padding: EdgeInsets.symmetric(vertical: 20),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _NotificationsWidget extends StatelessWidget {
  final String doctor;
  final String notice;
  final String textFirst;
  final String textSecond;
  final String textThird;
  final bool isShimmer;

  const _NotificationsWidget({
    required this.doctor,
    required this.notice,
    required this.textFirst,
    required this.textSecond,
    required this.textThird,
    required this.isShimmer,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: AppColors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 22),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                isShimmer ? '' : notice,
                style: AppTextStyle.semiBold16.value.copyWith(
                  color: AppColors.darkGray,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 14),
                child: Text(
                  isShimmer ? '' : doctor,
                  style: AppTextStyle.semiBold18.value,
                ),
              ),
              IntrinsicHeight(
                child: Row(
                  children: [
                    Container(
                      width: 5,
                      color: isShimmer ? Colors.transparent : AppColors.gray,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            isShimmer ? '' : 'textFirst',
                            style: AppTextStyle.semiBold12.value,
                          ),
                          Text(
                            isShimmer ? '' : textSecond,
                            style: AppTextStyle.medium12.value,
                          ),
                          Text(
                            isShimmer ? '' : textThird,
                            style: AppTextStyle.medium12.value.copyWith(
                              color: AppColors.black.withOpacity(.5),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ProfileWidget extends StatelessWidget {
  final String name;

  const _ProfileWidget({required this.name});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(bottomRight: Radius.circular(40)),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment(0.8, 1),
          colors: <Color>[
            AppColors.darkBlue,
            AppColors.lightBlue,
          ],
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(right: 16, bottom: 32,left: 16,top:62),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name,
              style: AppTextStyle.bold24.value.copyWith(
                color: AppColors.white,
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                      child: Row(
                        children: [
                          Text(
                            'Настройки',
                            style: AppTextStyle.semiBold14.value,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8),
                            child: SvgPicture.asset(SvgIcons.iconArrow),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                        color: AppColors.lightBlueProfile,
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                    Container(
                      height: 60,
                      width: 60,
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        border: Border.all(color: AppColors.darkBlue),
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    const ClipRect(
                      child: Align(
                        alignment: Alignment.topCenter,
                        heightFactor: 0.5,
                        //child: SvgPicture.ass,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _LoadingProfileWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 250,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(bottomRight: Radius.circular(40)),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment(0.8, 1),
              colors: <Color>[
                AppColors.darkBlue,
                AppColors.lightBlue,
              ],
            ),
          ),
        ),
        SizedBox(
          height: 250,
          child: Padding(
            padding: const EdgeInsets.only(right: 16,left: 16, top: 62),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 40,
                  width: 262,
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 52, bottom: 10),
                      child: Container(
                        height: 32,
                        width: 135,
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                    ),
                    CustomPaint(
                      size: const Size(100, 100),
                      painter: CirclePainter(),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class CirclePainter extends CustomPainter {
  final _paint = Paint()
    ..color = AppColors.lightBlueProfile
    ..strokeWidth = 20
    ..style = PaintingStyle.stroke;

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawOval(
      Rect.fromLTWH(0, 0, size.width, size.height),
      _paint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
