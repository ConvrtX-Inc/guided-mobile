import 'package:flutter_secure_storage/flutter_secure_storage.dart';

// ignore: avoid_classes_with_only_static_members
/// Class of SecureStorage
class SecureStorage {
  static const FlutterSecureStorage _secureStorage = FlutterSecureStorage();

  ///Returns user_token key;
  static const String userTokenKey = 'user_token';

  ///Returns user_id key;
  static const String userIdKey = 'user_id';

  /// For saving secure string
  static Future<void> saveValue(
      {required String key, required String value}) async {
    await _secureStorage.write(
      key: key,
      value: value,
      aOptions: const AndroidOptions(encryptedSharedPreferences: true),
    );
  }

  /// For reading secure string
  static Future<String> readValue({required String key}) async {
    String? value;
    value = await _secureStorage.read(
      key: key,
      aOptions: const AndroidOptions(encryptedSharedPreferences: true),
    );

    return value!;
  }
  /// Clear storage
  static Future<void> clearAll() async {
    await _secureStorage.deleteAll();
  }
}
