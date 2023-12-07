import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/features/login_screen/login_screen.dart';
import 'package:flutter_template/features/login_screen/login_screen_widget_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:mocktail/mocktail.dart';

class MockLoginWM extends Mock implements ILoginScreenWidgetModel {}

void main() {
  const loginScreen = LoginScreen();
  final loginWm = MockLoginWM();

  setUp(() {
    when(() => loginWm.themeState).thenAnswer(
          (_) => StateNotifier(initValue: ThemeMode.light),
    );
    when(() => loginWm.textEmailController).thenAnswer(
          (_) => TextEditingController(),
    );
    when(() => loginWm.textPasswordController).thenAnswer(
          (_) => TextEditingController(),
    );
    when(() => loginWm.wrongValue).thenAnswer(
          (_) =>  ValueNotifier(false),
    );
  });

  testGoldens('Login screen default golden test', (tester) async {
    await tester.pumpWidgetBuilder(loginScreen.build(loginWm));
    await multiScreenGolden(tester, 'login_screen');
  });

  testGoldens('Login screen with data golden test', (tester) async {
    when(() => loginWm.themeState).thenAnswer(
          (_) => StateNotifier(initValue: ThemeMode.dark),
    );
    when(() => loginWm.textEmailController).thenAnswer(
          (_) => TextEditingController(text: 'email@aaa.com'),
    );
    when(() => loginWm.textPasswordController).thenAnswer(
          (_) => TextEditingController(text: '123'),
    );
    when(() => loginWm.wrongValue).thenAnswer(
          (_) =>  ValueNotifier(true),
    );
    await tester.pumpWidgetBuilder(loginScreen.build(loginWm));
    await multiScreenGolden(tester, 'login_screen_data');
  });
}
