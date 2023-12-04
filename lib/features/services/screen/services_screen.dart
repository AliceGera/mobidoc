// ignore_for_file: use_if_null_to_convert_nulls_to_bools
import 'package:auto_route/auto_route.dart';
import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/assets/colors/app_colors.dart';
import 'package:flutter_template/assets/text/text_style.dart';
import 'package:flutter_template/features/common/domain/data/services/services_data.dart';
import 'package:flutter_template/features/common/widgets/app_error_widget.dart';
import 'package:flutter_template/features/common/widgets/app_item_loading_widget.dart';
import 'package:flutter_template/features/common/widgets/app_item_widget.dart';
import 'package:flutter_template/features/navigation/domain/entity/app_route_names.dart';
import 'package:flutter_template/features/services/screen/services_screen_widget_model.dart';
import 'package:union_state/union_state.dart';

/// Main widget for ServicesScreen feature.
@RoutePage(
  name: AppRouteNames.servicesScreen,
)
class ServicesScreen extends ElementaryWidget<IServicesScreenWidgetModel> {
  /// Create an instance [ServicesScreen].
  const ServicesScreen({
    Key? key,
    WidgetModelFactory wmFactory = servicesScreenWmFactory,
  }) : super(wmFactory, key: key);

  @override
  Widget build(IServicesScreenWidgetModel wm) {
    return UnionStateListenableBuilder<Services>(
      unionStateListenable: wm.ServicesState,
      builder: (_, services) {
        return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: AppColors.backgroundColor,
            centerTitle: false,
            title: Text(
              'Услуги',
              style: AppTextStyle.bold30.value.copyWith(color: AppColors.black),
            ),
          ),
          backgroundColor: AppColors.backgroundColor,
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      return AppItemWidget(
                        title: services?.member[index].title ?? '0',
                        textInfo: services?.member[index].title ?? '0',
                      );
                    },
                    separatorBuilder: (context, index) => const SizedBox(
                      height: 16,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
      loadingBuilder: (_, services) => SafeArea(
        child: Scaffold(
          backgroundColor: AppColors.backgroundColor,
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: Text('Услуги', style: AppTextStyle.bold30.value),
                ),
                ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return const AppItemLoadingWidget();
                  },
                  separatorBuilder: (context, index) => const SizedBox(
                    height: 16,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      failureBuilder: (_, exception, services) => const AppErrorWidget(
        wrongText: 'Что-то пошло не так!\nПовторите попытку.',
      ),
    );
  }
}
