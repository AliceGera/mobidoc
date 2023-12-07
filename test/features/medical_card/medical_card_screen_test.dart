import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/features/common/domain/data/medical_card/medical_cards_data.dart';
import 'package:flutter_template/features/common/domain/data/medical_card/medical_cards_member_data.dart';
import 'package:flutter_template/features/medical_card/screens/medical_card_screen/medical_card_screen.dart';
import 'package:flutter_template/features/medical_card/screens/medical_card_screen/medical_card_screen_widget_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:mocktail/mocktail.dart';
import 'package:union_state/union_state.dart';

class MockMedicalCardWM extends Mock implements IMedicalCardScreenWidgetModel {}

void main() {
  const medicalCardScreen = MedicalCardScreen();
  final medicalCardWm = MockMedicalCardWM();

  setUp(
    () {
      when(() => medicalCardWm.themeState).thenAnswer(
        (_) => StateNotifier(initValue: ThemeMode.light),
      );
      when(() => medicalCardWm.isFindQr).thenAnswer(
        (_) => StateNotifier(),
      );
      when(() => medicalCardWm.isShow).thenAnswer(
        (_) => StateNotifier(),
      );
      when(() => medicalCardWm.isFirstTime).thenAnswer(
        (_) => StateNotifier(),
      );
      when(() => medicalCardWm.qrControllerValue).thenAnswer(
        (_) => ValueNotifier(null),
      );
      when(() => medicalCardWm.medicalCardsState).thenAnswer(
        (_) => UnionStateNotifier<MedicalCards>(MedicalCards.init()),
      );
    },
  );

  testGoldens(
    'Medical card screen default golden test',
    (tester) async {
      await tester.pumpWidgetBuilder(medicalCardScreen.build(medicalCardWm));
      await multiScreenGolden(tester, 'medical_card_screen');
    },
  );

  testGoldens(
    'Medical card screen with data golden test',
    (tester) async {
      when(() => medicalCardWm.themeState).thenAnswer(
        (_) => StateNotifier(initValue: ThemeMode.dark),
      );
      when(() => medicalCardWm.isFindQr).thenAnswer(
        (_) => StateNotifier(initValue: true),
      );
      when(() => medicalCardWm.isShow).thenAnswer(
        (_) => StateNotifier(initValue: true),
      );
      when(() => medicalCardWm.isFirstTime).thenAnswer(
        (_) => StateNotifier(initValue: true),
      );
      when(() => medicalCardWm.medicalCardsState).thenAnswer(
        (_) => UnionStateNotifier<MedicalCards>(
          MedicalCards(
            member: [
              MedicalCardsMember(
                id: 1,
                name: 'name',
                description: 'description',
                number: 14,
              )
            ],
          ),
        ),
      );

      await tester.pumpWidgetBuilder(medicalCardScreen.build(medicalCardWm));
      await multiScreenGolden(tester, 'medical_card_screen_data');
    },
  );
}
