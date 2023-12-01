/// List of all the paths that are used to navigate in temp feature.
///
/// Have to been filled with the entries like this:
/// ```dart
/// /// Path description.
/// static const String screenPath = 'screenPath';
/// ```
abstract class AppRoutePaths {
  /// Path to doctors screen.
  static const String doctorsPath = 'doctors';

  /// Path to home screen.
  static const String homePath = 'home';

  /// Path to main screen.
  static const String mainPath = '/main';

  /// Path to medical card screen.
  static const String medicalCardPath = 'medicalCard';

  /// Path to onboarding screen.
  static const String onboardingPath = '/onboarding';

  /// Path to login screen.
  static const String loginPath = '/login';

  /// Path to services screen.
  static const String servicesPath = 'services';

  /// Path to onboarding screen.
  static const String splashPath = '/splash';

  /// Path to onboarding screen.
  static const String infoAboutMedicalCardPath = '/infoAboutMedicalCard';
}
