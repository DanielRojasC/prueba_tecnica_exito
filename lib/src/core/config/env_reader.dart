import 'package:flutter_dotenv/flutter_dotenv.dart';

class EnvReader {
  static final String baseUrl = _get("BASE_URL");

  static String _get(String key) => dotenv.get(key, fallback: "");
}
