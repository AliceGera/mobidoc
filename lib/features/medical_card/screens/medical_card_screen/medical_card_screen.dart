import 'package:auto_route/auto_route.dart';
import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/assets/colors/app_colors.dart';
import 'package:flutter_template/assets/text/text_style.dart';
import 'package:flutter_template/features/common/widgets/app_doctor_widget.dart';
import 'package:flutter_template/features/common/widgets/app_item_widget.dart';
import 'package:flutter_template/features/medical_card/screens/medical_card_screen/medical_card_screen_widget_model.dart';
import 'package:flutter_template/features/navigation/domain/entity/app_route_names.dart';

/// medical card screens.
@RoutePage(
  name: AppRouteNames.medicalCardScreen,
)
class MedicalCardScreen extends ElementaryWidget<IMedicalCardScreenWidgetModel> {
  /// Create an instance [MedicalCardScreen].
  const MedicalCardScreen({
    Key? key,
    WidgetModelFactory wmFactory = medicalCardScreenWidgetModelFactory,
  }) : super(wmFactory, key: key);

  @override
  Widget build(IMedicalCardScreenWidgetModel wm) {
    return Scaffold(
      body: _Body(
        themeState: wm.themeState,
        openOnboarding: wm.openOnboarding,
        openLogin: wm.openLogin,
        setThemeMode: wm.setThemeMode,
      ),
    );
  }
}

class _Body extends StatelessWidget {
  final ListenableState<ThemeMode> themeState;
  final void Function(ThemeMode?) setThemeMode;
  final VoidCallback openOnboarding;
  final VoidCallback openLogin;
  const _Body({
    required this.themeState,
    required this.setThemeMode,
    required this.openOnboarding,
    required this.openLogin,
  });

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
                    'Медицинская карта',
                    style: AppTextStyle.bold30.value,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Text(
                    'Спосокукоцкий Вячеслав Владимирович',
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
                  child: Text('Считает себя больным с осени 2011 г., когда впервые после еды по-явились ноющие боли в эпигастральной области, изжога.',
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
                      textInfo: '10 Июня 2023',
                    );
                  },
                  separatorBuilder: (context, index) => const SizedBox(
                    height: 16,
                  ),
                ),
                Card(
                  child: ListTile(
                    onTap: openOnboarding,
                    title: const Text('To onboarding screen'),
                  ),
                ),
                Card(
                  child: ListTile(
                    onTap: openLogin,
                    title: const Text('To login screen'),
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
