//ignore: unused_import
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import '../services/secure_storage.dart';

class PrefUtils {
  static SharedPreferences? _sharedPreferences;

  PrefUtils() {
    // init();
    SharedPreferences.getInstance().then((value) {
      _sharedPreferences = value;
    });
  }

  Future<void> init() async {
    _sharedPreferences ??= await SharedPreferences.getInstance();
    print('SharedPreference Initialized');
  }

  ///will clear all the data stored in preference
  void clearPreferencesData() async {
    if (null != _sharedPreferences) {
      _sharedPreferences?.clear();
    }
  }

  Future<void> setThemeData(String value) {
    return _sharedPreferences!.setString('themeData', value);
  }

  String getThemeData() {
    try {
      return _sharedPreferences!.getString('themeData')!;
    } catch (e) {
      print(e);
      return 'primary';
    }
  }

  Future<void> setOnBoard(bool value) {
    return _sharedPreferences!.setBool('ON_BOARD', value);
  }

  bool getOnBoard() {
    try {
      return _sharedPreferences!.getBool('ON_BOARD') ?? false;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<void> setName(String value) {
    return _sharedPreferences!.setString('NAME', value);
  }

  String getName() {
    try {
      return _sharedPreferences!.getString('NAME') ?? "";
    } catch (e) {
      print(e);
      return "";
    }
  }

  Future<void> setEmail(String value) {
    return _sharedPreferences!.setString('EMAIL', value);
  }

  String getEmail() {
    try {
      return _sharedPreferences!.getString('EMAIL') ?? "";
    } catch (e) {
      print(e);
      return "";
    }
  }

  Future<void> setVerses(String value) {
    return _sharedPreferences!.setString('dailyVerses', value);
  }

  String getVerses() {
    try {
      return _sharedPreferences!.getString('dailyVerses') ?? "";
    } catch (e) {
      return "";
    }
  }

  Future<void> setfamilyCode(String value) {
    return _sharedPreferences!.setString('familyCode', value);
  }

  String getfamilyode() {
    try {
      return _sharedPreferences!.getString('familyCode') ?? "";
    } catch (e) {
      print(e);
      return "";
    }
  }

  Future<void> setImage(String value) {
    return _sharedPreferences!.setString('image', value);
  }

  Future<void> setUserType(int value) {
    return _sharedPreferences!.setInt('userType', value);
  }

  int getUserType() {
    try {
      return _sharedPreferences!.getInt('userType') ?? 0;
    } catch (e) {
      print(e);
      return 0;
    }
  }

  String getImage() {
    try {
      return _sharedPreferences!.getString('image') ?? "";
    } catch (e) {
      print(e);
      return "";
    }
  }

  Future<void> setfamilyHeadName(String value) {
    return _sharedPreferences!.setString('familyHeadName', value);
  }

  String getfamilyHeadName() {
    try {
      return _sharedPreferences!.getString('familyHeadName') ?? "";
    } catch (e) {
      print(e);
      return "";
    }
  }

  Future<void> setToken(String value) {
    return _sharedPreferences!.setString('TOKEN', value);
  }

  Future<String> getToken() async {
    try {
      String token = await checkToken() ?? "";
      print("token${token}");
      return token;
    } catch (e) {
      print(e);
      return "";
    }
  }

  Future<void> clearToken() {
    SecureStorage.deleteAll();
    return _sharedPreferences!.clear();
  }
}
