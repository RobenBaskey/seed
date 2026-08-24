/// App-wide static strings. Extract to localization (.arb) files once
/// multi-language support is required.
class AppStrings {
  const AppStrings._();

  static const String appName = 'Seed';
  static const String genericErrorMessage =
      'Something went wrong. Please try again.';
  static const String noInternetMessage =
      'No internet connection. Please check your network.';
  static const String requestTimeoutMessage =
      'The request timed out. Please try again.';
}
