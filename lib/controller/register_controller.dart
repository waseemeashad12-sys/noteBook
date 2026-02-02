import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notebook/model/user_model.dart';
import 'package:notebook/Services/database_service.dart';
import 'package:notebook/Services/session_service.dart';
import 'package:notebook/views/notes_page.dart';

class RegisterController extends GetxController {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  Future<void> register() async {
    print("REGISTER FUNCTION STARTED");

    try {
      if (nameController.text.isEmpty ||
          emailController.text.isEmpty ||
          passwordController.text.isEmpty) {
        Get.snackbar('خطأ', 'جميع الحقول مطلوبة');
        return;
      }

      final db = await DatabaseService.database;
      print("DATABASE OPENED");

      // 🔍 التحقق إذا الاسم أو الإيميل مستخدم مسبقًا
      final existing = await db.query(
        'users',
        where: 'email = ? OR name = ?',
        whereArgs: [
          emailController.text.trim(),
          nameController.text.trim(),
        ],
      );

      if (existing.isNotEmpty) {
        final existingUser = existing.first;

        if (existingUser['email'] == emailController.text.trim()) {
          Get.snackbar('خطأ', 'البريد الإلكتروني مستخدم مسبقًا');
        } else if (existingUser['name'] == nameController.text.trim()) {
          Get.snackbar('خطأ', 'اسم المستخدم مستخدم مسبقًا');
        } else {
          Get.snackbar('خطأ', 'الحساب موجود مسبقًا');
        }
        return;
      }

      int id = await db.insert('users', {
        'name': nameController.text.trim(),
        'email': emailController.text.trim(),
        'password': passwordController.text.trim(),
      });

      print("USER INSERTED ID: $id");

      // ✅ حفظ الجلسة
      SessionService.currentUserId = id;
      SessionService.currentUserName.value = nameController.text.trim();

      Get.snackbar('نجاح', 'تم إنشاء الحساب');
      Get.offAll(() => NotesPage());

    } catch (e, s) {
      print("❌ ERROR DURING REGISTER: $e");
      print("STACKTRACE: $s");
      Get.snackbar('خطأ', 'حدث خطأ أثناء إنشاء الحساب');
    }
  }
}
