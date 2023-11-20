// ignore_for_file: public_member_api_docs

import 'package:auto_route/auto_route.dart';
import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/assets/colors/app_colors.dart';
import 'package:flutter_template/assets/text/text_style.dart';
import 'package:flutter_template/features/common/widgets/app_button_widget.dart';
import 'package:flutter_template/features/medical_card/screens/login_screen/login_screen_widget_model.dart';
import 'package:flutter_template/features/medical_card/screens/login_screen/widgets/text_field_widget.dart';
import 'package:flutter_template/features/navigation/domain/entity/app_route_names.dart';

extension EmailValidator on String {
  bool isValidEmail() {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(this);
  }
}

/// Login screen.
@RoutePage(name: AppRouteNames.loginScreen)
class LoginScreen extends ElementaryWidget<ILoginScreenWidgetModel> {
  /// Create an instance [LoginScreen].
  const LoginScreen({
    Key? key,
    WidgetModelFactory wmFactory = loginScreenWidgetModelFactory,
  }) : super(wmFactory, key: key);

  @override
  Widget build(ILoginScreenWidgetModel wm) {
    return Scaffold(
      body: _Body(
        textEmailController: wm.textEmailController,
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
  final TextEditingController textEmailController;
  final VoidCallback openOnboarding;
  final VoidCallback openLogin;

  const _Body({
    required this.themeState,
    required this.setThemeMode,
    required this.openOnboarding,
    required this.textEmailController,
    required this.openLogin,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.white,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.transparent,
          title: Padding(
            padding: const EdgeInsets.only(top: 25),
            child: Text(
              'Войти',
              style: AppTextStyle.bold22.value.copyWith(
                color: AppColors.black,
              ),
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 96, bottom: 10),
                child: Text(
                  'Логин',
                  style: AppTextStyle.regular16.value.copyWith(
                    color: AppColors.black,
                  ),
                ),
              ),
              TextFieldWidget(
                textController: textEmailController,
                hintText: 'example@1.com',
                color: AppColors.black,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Заполните логин';
                  }
                  if (value?.isValidEmail() ?? false) {
                    return null;
                  } else {
                    return 'example@1.com';
                  }
                },
                focusedColor: AppColors.darkBlue,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 30, bottom: 10),
                child: Text(
                  'Пароль',
                  style: AppTextStyle.regular16.value.copyWith(
                    color: AppColors.black,
                  ),
                ),
              ),
              TextFieldWidget(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Заполните поле';
                  }
                },
                obscureText: true,
                hintText: '**********',
                color: AppColors.black,
                focusedColor: AppColors.darkBlue,
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.only(bottom: 21, top: 30),
                child: AppButtonWidget(
                  title: 'Войти',
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
