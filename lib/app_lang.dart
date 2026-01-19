//app_lang.dart
import 'package:get/get.dart';

class AppTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
    'ar': {
      // عامة
      'app_title': 'كل الملاحظات',
      'ok': 'حسناً',
      'cancel': 'إلغاء',
      'delete': 'حذف',
      'change_lang': 'English', // زر تبديل اللغة

      // Drawer
      'drawer_title': 'مفكرة',
      'memory_usage': 'استخدام الذاكرة: 0.0 كيلوبايت',
      'all_notes': 'كل الملاحظات',
      'favorites': 'المفضلة',
      'reminders': 'التذكيرات',
      'trash': 'سلة المحذوفات',
      'settings': 'الإعدادات',

      // Dialog حذف
      'delete_all': 'حذف كل الملاحظات',
      'delete_all_confirm': 'هل أنت متأكد أنك تريد حذف جميع الملاحظات؟',

      // أخرى
      'no_notes': 'لا توجد ملاحظات',
      'about': 'حول التطبيق',

      // صفحة الاضافة
      'add_note': 'إضافة ملاحظة',
      'edit_note': 'تعديل الملاحظة',
      'add_image': 'إضافة صورة',
      'note': 'ملاحظة',
      'write_note': 'اكتب الملاحظة',
      'save_note': 'حفظ الملاحظة',
      'save_image': 'حفظ الصورة',
      'save_all': 'حفظ الكل',
    },

    'en': {
      // General
      'app_title': 'All Notes',
      'ok': 'OK',
      'cancel': 'Cancel',
      'delete': 'Delete',
      'change_lang': 'العربية', // Lang Switch button

      // Drawer
      'drawer_title': 'Notes',
      'memory_usage': 'Memory usage: 0.0 KB',
      'all_notes': 'All Notes',
      'favorites': 'Favorites',
      'reminders': 'Reminders',
      'trash': 'Trash',
      'settings': 'Settings',

      // Delete dialog
      'delete_all': 'Delete all notes',
      'delete_all_confirm': 'Are you sure you want to delete all notes?',

      // Other
      'no_notes': 'No notes',
      'about': 'About',

      'add_note': 'Add Note',
      'edit_note': 'Edit Note',
      'add_image': 'Add Image',
      'note': 'Note',
      'write_note': 'Write note',

      'save_note': 'Save Note',
      'save_image': 'Save Image',
      'save_all': 'Save All'
    },
  };
}