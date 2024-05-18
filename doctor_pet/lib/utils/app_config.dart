class AppEnvironment {
  AppEnvironment._({
    required this.apiBaseUrl,
  });

  final String apiBaseUrl;

  factory AppEnvironment.live({
    required apiBaseUrl,
  }) {
    return AppEnvironment._(
      apiBaseUrl: apiBaseUrl,
    );
  }
}
