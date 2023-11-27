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
import 'package:shimmer/shimmer.dart';

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
  final bool isLoading = true;
  @override
  Widget build(IHomeScreenWidgetModel wm) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.backgroundColor,
        body: SingleChildScrollView(
            child: Column(
            children: [
            isLoading ? _LoadingProfileWidget() : _ProfileWidget(name:'Григорий Плювкин'),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 21, vertical: 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 50),
                    child:  _NotificationsWidget(
                      ///???
                      isShimer: isLoading,
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
                          padding: const EdgeInsets.only(top: 50, bottom: 20),
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
                          ?  const AppItemLoadingWidget()
                          : const AppItemWidget(
                              title: 'Терапевт',
                              textInfo: '10 Июня 2023',
                            );
                    },
                    separatorBuilder: (context, index) => const SizedBox(
                      height: 16,
                    ),
                  ),
                ],
              ),
            ),
          ],
        )),
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
  final bool isShimer;

  const _NotificationsWidget({
    required this.doctor,
    required this.notice,
    required this.textFirst,
    required this.textSecond,
    required this.textThird,
    required this.isShimer,
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
                isShimer ? '' : notice,
                style: AppTextStyle.semiBold16.value.copyWith(
                  color: AppColors.darkGray,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 14),
                child: Text(
                  isShimer ? '' : doctor,
                  style: AppTextStyle.semiBold18.value,
                ),
              ),
              IntrinsicHeight(
                child: Row(
                  children: [
                    Container(
                      width: 5,
                      color: isShimer ? Colors.transparent : AppColors.gray,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            isShimer ? '' : 'textFirst',
                            style: AppTextStyle.semiBold12.value,
                          ),
                          Text(
                            isShimer ? '' : textSecond,
                            style: AppTextStyle.medium12.value,
                          ),
                          Text(
                            isShimer ? '' : textThird,
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
   _ProfileWidget({required this.name});

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
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
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 22),
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
    return Stack(children: [
      Shimmer.fromColors(
        baseColor: AppColors.darkBlue,
        highlightColor: AppColors.darkBlue.withOpacity(0.8),
        child: DecoratedBox(
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
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 22),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '',
                  style: AppTextStyle.bold24.value.copyWith(
                    color: Colors.transparent,
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
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
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    ]);
  }
}

class _LastVisits extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 25),
      child: SizedBox(
        child: Shimmer.fromColors(
          baseColor: AppColors.lightBlueItem,
          highlightColor: AppColors.lightBlueItem.withOpacity(0.4),
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: AppColors.lightBlueItem,
              borderRadius: BorderRadius.circular(50),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              child: Text(
                'Последние посещения',
                style: AppTextStyle.semiBold18.value.copyWith(color: Colors.transparent),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
