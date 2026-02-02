import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter/material.dart';

class ThemeController extends GetxController {
  final GetStorage _box = GetStorage();

  final String _key = 'darkMode';

  var isDark = false.obs;

  @override
  void onInit() {
    super.onInit();

    isDark.value = _box.read(_key) ?? false;

    Get.changeThemeMode(isDark.value ? ThemeMode.dark : ThemeMode.light);
  }

  void toggleTheme() {
    isDark.value = !isDark.value;


    _box.write(_key, isDark.value);

    Get.changeThemeMode(isDark.value ? ThemeMode.dark : ThemeMode.light);
  }
}
