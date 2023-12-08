// ignore_for_file: public_member_api_docs

import 'package:auto_route/auto_route.dart';
import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/assets/colors/app_colors.dart';
import 'package:flutter_template/assets/text/text_style.dart';
import 'package:flutter_template/features/common/widgets/app_button_widget.dart';
import 'package:flutter_template/features/common/widgets/app_error_widget.dart';
import 'package:flutter_template/features/login_screen/login_screen_widget_model.dart';
import 'package:flutter_template/features/login_screen/widgets/text_field_widget.dart';
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
        textPasswordController: wm.textPasswordController,
        textEmailController: wm.textEmailController,
        wrongValue: wm.wrongValue,
        themeState: wm.themeState,
        openNextScreen: wm.openNextScreen,
        setThemeMode: wm.setThemeMode,
      ),
    );
  }
}

class _Body extends StatelessWidget {
  final ListenableState<ThemeMode> themeState;
  final void Function(ThemeMode?) setThemeMode;
  final TextEditingController textEmailController;
  final ValueNotifier<bool> wrongValue;
  final TextEditingController textPasswordController;
  final VoidCallback openNextScreen;

  const _Body({
    required this.wrongValue,
    required this.themeState,
    required this.setThemeMode,
    required this.openNextScreen,
    required this.textEmailController,
    required this.textPasswordController,
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
        body: LayoutBuilder(
          builder: (context, viewportConstraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: viewportConstraints.maxHeight,
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: IntrinsicHeight(
                    child: Column(
                      children: [
                        Expanded(
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
                                    return 'Заполните поле';
                                  }
                                  if (value?.isValidEmail() ?? false) {
                                    textEmailController.value = textEmailController.value.copyWith(text: value);
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
                                textController: textPasswordController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Заполните поле';
                                  }
                                  textPasswordController.value = textPasswordController.value.copyWith(text: value);
                                },
                                obscureText: true,
                                hintText: '**********',
                                color: AppColors.black,
                                focusedColor: AppColors.darkBlue,
                              ),
                              ValueListenableBuilder<bool>(
                                builder: (
                                  context,
                                  value,
                                  child,
                                ) {
                                  return value
                                      ? const AppErrorWidget(
                                          wrongText: 'Неверный логин/\nпароль',
                                          isLogin: true,
                                        )
                                      : const SizedBox();
                                },
                                valueListenable: wrongValue,
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 21, top: 30),
                          child: AppButtonWidget(
                            title: 'Войти',
                            onPressed: openNextScreen,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
