import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotesController extends GetxController {
  // قائمة الملاحظات (RxList) لتتحدث الشاشة تلقائياً عند تغييرها
  var notes = <Map<String, dynamic>>[].obs;
  // أضف هذا المتغير
  var isDrawerOpen = false.obs;

// ودالة للتبديل
  void toggleDrawer() {
    isDrawerOpen.value = !isDrawerOpen.value;
  }

  // إضافة ملاحظة
  void addNote(Map<String, dynamic> note) {
    notes.add(note);
  }

  // حذف ملاحظة
  void deleteNote(int index) {
    notes.removeAt(index);
  }

  // تعديل ملاحظة
  void updateNote(int index, Map<String, dynamic> updatedNote) {
    notes[index] = updatedNote;
  }

  // حذف الكل
  void deleteAllNotes() {
    notes.clear();
  }

  // تغيير اللغة
  void changeLanguage() {
    if (Get.locale?.languageCode == 'ar') {
      Get.updateLocale(const Locale('en'));
    } else {
      Get.updateLocale(const Locale('ar'));
    }
  }
}