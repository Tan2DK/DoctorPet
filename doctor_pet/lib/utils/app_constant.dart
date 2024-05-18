class StringConstant {
  static const appName = 'Doctor Pet';
  static const googleMapKey = 'AIzaSyB97rGEUTzYIsnwmCvdVDxik4d-fM40_yw';
}

class LocaleKey {
  static const String en = "en";
  static const String vi = "vi";
}

class CountryKey {
  static const String en = "EN";
  static const String vn = "VN";
}

class IntConstant {
  static const int maxDay = 3;
}

class ResponseStatusCode {
  static const ok = 200;
  static const created = 201;
  static const accepted = 202;
  static const noContent = 204;
  static const badRequest = 400;
  static const unauthorized = 401;
  static const forbidden = 403;
  static const notFound = 404;
  static const methodNotAllowed = 405;
  static const internalServerError = 500;
}

class SharePrefKeys {
  final String authToken = 'authToken';
}

class AppConstant {
  static SharePrefKeys sharePrefKeys = SharePrefKeys();
}

class AppHeaderApiConstant {
  static Map<String, String> baseHeader = {
    "Access-Control-Allow-Origin": "*",
    'Content-Type': 'application/json',
    'Accept': '*/*',
    "ngrok-skip-browser-warning": "69420",
  };
}
