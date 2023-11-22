/// List of all the paths that are used to navigate in temp feature.
///
/// Have to been filled with the entries like this:
/// ```dart
/// /// Path description.
/// static const String screenPath = 'screenPath';
/// ```
abstract class AppRoutePaths {
  /// Path to temp screen.
  static const String doctorsPath = 'doctors';

  /// Path to debug screen.
  static const String homePath = 'home';

  /// Path to ui kit screen.
  static const String mainPath = '/main';

  /// Path to dash screen.
  static const String medicalCardPath = 'medicalCard';

  /// Path to info screen.
  static const String onboardingPath = '/onboarding';

  /// Path to logs history screen.
  static const String servicesPath = 'services';
}
