import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notebook/Services/database_service.dart';
import 'package:notebook/Services/session_service.dart';
import 'package:notebook/views/notes_page.dart';

class LoginController extends GetxController {
  final nameController = TextEditingController();
  final passwordController = TextEditingController();

  Future<void> login() async {
    if (nameController.text.isEmpty || passwordController.text.isEmpty) {
      Get.snackbar(
          'login'.tr, 'enter_username'.tr + ' / ' + 'enter_password'.tr);
      return;
    }

    final db = await DatabaseService.database;

    final result = await db.query(
      'users',
      where: 'name = ? AND password = ?',
      whereArgs: [
        nameController.text.trim(),
        passwordController.text.trim()
      ],
    );

    if (result.isNotEmpty) {

      /// ✅ استخدام الدالة الرسمية لتحديث الجلسة
      SessionService.setSession(
        result.first['id'] as int,
        result.first['name'] as String,
        result.first['email'] as String,
      );

      Get.snackbar(
          'login'.tr, 'مرحباً ${SessionService.currentUserName.value}');
      Get.offAll(() => NotesPage());
    } else {
      Get.snackbar('login'.tr, 'login_error'.tr);
    }
  }

  @override
  void onClose() {
    nameController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
