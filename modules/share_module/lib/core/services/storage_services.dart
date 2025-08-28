import 'package:hive/hive.dart';

class DoHiveUtils {
  //In Hive, openBox() is both:
  //Create a box (if it does not exist yet)
  //Open an existing box (if it’s already created)
  //Hive lifecycle diagram showing openBox → put → get → close → reopen
  static Future<void> openHiveBox({required String hiveBoxName}) async {
    if (hiveBoxName.isNotEmpty) {
      if (!Hive.isBoxOpen(hiveBoxName)) {
        await Hive.openBox(hiveBoxName);
      }
    }
  }

  static Future<bool> isContainsKey(
      {required String hiveBoxName, required String keyName}) async {
    if (hiveBoxName.isNotEmpty && keyName.isNotEmpty) {
      return Hive.box(hiveBoxName).containsKey(keyName);
    } else {
      return false;
    }
  }

  static Future<void> clearHiveBox({required String hiveBoxName}) async {
    if (hiveBoxName.isNotEmpty) {
      await Hive.box(hiveBoxName).clear();
    }
  }

  static Future<dynamic> insertValuesToBox(
      {required String hiveBoxName,
      required String keyName,
      dynamic value}) async {
    if (hiveBoxName.isNotEmpty && keyName.isNotEmpty) {
      await Hive.box(hiveBoxName).put(keyName, value);
    }
  }

  static Future<dynamic> getHiveBox(
      {required String hiveBoxName,
      required String keyName,
      dynamic value}) async {
    if (hiveBoxName.isNotEmpty && keyName.isNotEmpty) {
      return Hive.box(hiveBoxName).get(keyName, defaultValue: value);
    }
  }

  static Future<void> deleteHiveBox(
      {String hiveBoxName = "", String keyName = ""}) async {
    if (hiveBoxName.isNotEmpty && keyName.isNotEmpty) {
      await Hive.box(hiveBoxName).delete(keyName);
    }
  }
}
