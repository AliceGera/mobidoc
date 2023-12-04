// ignore_for_file: public_member_api_docs

/*
*/

import 'package:auto_route/auto_route.dart';
import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/assets/colors/app_colors.dart';
import 'package:flutter_template/assets/text/text_style.dart';
import 'package:flutter_template/features/common/widgets/app_button_widget.dart';
import 'package:flutter_template/features/common/widgets/app_doctor_widget.dart';
import 'package:flutter_template/features/common/widgets/app_item_loading_widget.dart';
import 'package:flutter_template/features/common/widgets/app_item_widget.dart';
// ignore_for_file: avoid_field_initializers_in_const_classes

import 'package:flutter_template/features/medical_card/screens/info_about_medical_card/info_about_medical_card_screen_widget_model.dart';
import 'package:flutter_template/features/navigation/domain/entity/app_route_names.dart';

/// info about medical card screens.
@RoutePage(
  name: AppRouteNames.infoAboutMedicalCardScreen,
)
class InfoAboutMedicalCardScreen extends ElementaryWidget<IInfoAboutMedicalCardScreenWidgetModel> {
  /// Create an instance [InfoAboutMedicalCardScreen].
  final String description;
  final String name;

  const InfoAboutMedicalCardScreen(
      this.name,
      this.description, {
    Key? key,
    WidgetModelFactory wmFactory = infoAboutMedicalCardScreenWidgetModelFactory,
  }) : super(wmFactory, key: key);

  @override
  Widget build(IInfoAboutMedicalCardScreenWidgetModel wm) {
    return Scaffold(
      body: _Body(
        name: name,
        description: description,
        themeState: wm.themeState,
        setThemeMode: wm.setThemeMode,
        openNextScreen: wm.openNextScreen,
      ),
    );
  }
}

class _Body extends StatelessWidget {
  final String name;
  final String description;
  final ListenableState<ThemeMode> themeState;
  final void Function(ThemeMode?) setThemeMode;
  final bool isLoading = false;
  final bool isEmpty = false;
  final VoidCallback openNextScreen;

  const _Body({
    required this.name,
    required this.description,
    required this.themeState,
    required this.setThemeMode,
    required this.openNextScreen,
  });

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const _LoadingStateWidget()
        : Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: AppColors.backgroundColor,
            title: Text(
              'Медицинская карта ',
              style: AppTextStyle.bold30.value.copyWith(color: AppColors.black),
            ),
          ),
          backgroundColor: AppColors.backgroundColor,
          body: isEmpty
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 90, vertical: 25),
                      child: Text(
                        'Медицинские карты отсутствуют',
                        textAlign: TextAlign.center,
                        style: AppTextStyle.semiBold16.value,
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 50),
                      child: AppButtonWidget(
                        title: 'Добавить карту',
                      ),
                    ),
                  ],
                )
              : SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: Text(
                            name,
                            style: AppTextStyle.bold22.value,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: Text(
                            'Анамнез:',
                            style: AppTextStyle.bold16.value,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: Text(
                              description,
                              style: AppTextStyle.regular16.value),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 31),
                          child: Text(
                            'Мои врачи',
                            style: AppTextStyle.bold22.value,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 31),
                          child: ListView.separated(
                            physics: const BouncingScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: 2,
                            itemBuilder: (context, index) {
                              return const AppDoctorWidget(
                                doctor: 'Тепапевт',
                                doctorName: 'Доктор Курпатов',
                                bio: '',
                              );
                            },
                            separatorBuilder: (context, index) => const SizedBox(
                              height: 16,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 22),
                          child: Text(
                            'Последние посещения',
                            style: AppTextStyle.bold22.value,
                          ),
                        ),
                        ListView.separated(
                          physics: const BouncingScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: 5,
                          itemBuilder: (context, index) {
                            return const AppItemWidget(
                              title: 'Терапевт',
                              textInfo: '20 Июня 2023',
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
  }
}

class _LoadingStateWidget extends StatelessWidget {
  const _LoadingStateWidget();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.backgroundColor,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Text(
                    'Медицинская карта ',
                    style: AppTextStyle.bold30.value,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(bottom: 8),
                  child: AppItemLoadingWidget(height: 60, width: 320),
                ),
                const Padding(
                  padding: EdgeInsets.only(bottom: 8),
                  child: AppItemLoadingWidget(height: 40, width: 100),
                ),
                const Padding(
                  padding: EdgeInsets.only(bottom: 26),
                  child: AppItemLoadingWidget(height: 80),
                ),
                const Padding(
                  padding: EdgeInsets.only(bottom: 20),
                  child: AppItemLoadingWidget(height: 40, width: 160),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 40),
                  child: ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: 2,
                    itemBuilder: (context, index) {
                      return const AppItemLoadingWidget();
                    },
                    separatorBuilder: (context, index) => const SizedBox(
                      height: 16,
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(bottom: 25),
                  child: AppItemLoadingWidget(height: 40, width: 220),
                ),
                ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return const AppItemLoadingWidget(
                      height: 80,
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
      ),
    );
  }
}
