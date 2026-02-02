import 'dart:io';
import 'package:get/get.dart';
import 'package:notebook/model/note_model.dart';
import 'package:notebook/Services/database_service.dart';
import 'package:notebook/Services/session_service.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';


class AddNoteController extends GetxController {
  final TextEditingController noteController = TextEditingController();
  String? pdfPath;

  final ImagePicker picker = ImagePicker();
  var image = Rxn<File>();

  void setInitialNote(String? note) {
    noteController.text = note ?? "";
  }

  Future<void> pickImage() async {
    final XFile? picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      image.value = File(picked.path);
    }
  }


  Future<void> saveNote() async {
    if (noteController.text.trim().isEmpty) {
      Get.snackbar(
        "alert".tr,
        "write_note_before_save".tr,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.shade100,
      );
      return;
    }

    final userId = SessionService.currentUserId;
    if (userId == null) {
      Get.snackbar("error".tr, "user_not_logged_in".tr);
      return;
    }

    final now = DateTime.now().toIso8601String();
    final db = await DatabaseService.database;

    await db.insert('notes', {
      'title': "note_title".tr,
      'content': noteController.text.trim(),
      'created_at': now,
      'updated_at': now,
      'user_id': userId,
    });

    Get.back(result: true);
  }

  /// 🖼 حفظ صورة فقط
  Future<void> saveImage() async {
    if (image.value == null) {
      Get.snackbar(
        "alert".tr,
        "choose_image_first".tr,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.shade100,
      );
      return;
    }

    final userId = SessionService.currentUserId;
    if (userId == null) return;

    final now = DateTime.now().toIso8601String();
    final db = await DatabaseService.database;

    int noteId = await db.insert('notes', {
      'title': "image_title".tr,
      'created_at': now,
      'updated_at': now,
      'user_id': userId,
    });

    await db.insert('note_images', {
      'note_id': noteId,
      'image_path': image.value!.path,
    });

    Get.back(result: true);
  }

  /// 📝🖼 حفظ نص + صورة
  Future<void> saveNoteWithImage() async {
    if (noteController.text.trim().isEmpty && image.value == null) {
      Get.snackbar(
        "alert".tr,
        "enter_text_or_image".tr,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.shade100,
      );
      return;
    }

    final userId = SessionService.currentUserId;
    if (userId == null) return;

    final now = DateTime.now().toIso8601String();
    final db = await DatabaseService.database;

    int noteId = await db.insert('notes', {
      'title': "note_with_image_title".tr,
      'content': noteController.text.trim(),
      'created_at': now,
      'updated_at': now,
      'user_id': userId,
    });

    if (image.value != null) {
      await db.insert('note_images', {
        'note_id': noteId,
        'image_path': image.value!.path,
      });
    }

    Get.back(result: true);
  }

  @override
  void onClose() {
    noteController.dispose();
    super.onClose();
  }
}
