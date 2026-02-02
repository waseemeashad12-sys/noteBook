// app_lang.dart
import 'package:get/get.dart';

class AppTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {

    // ================= ARABIC =================
    'ar': {

      // ===== عامة =====
      'favorites_notes': 'الملاحظات المفضلة',
      'all_notes_title': 'كل الملاحظات',
      'no_search_results': 'لا توجد نتائج للبحث',
      'no_favorite_notes': 'لا توجد ملاحظات مفضلة',
      'no_notes': 'لا توجد ملاحظات',
      'about': 'حول التطبيق',
      'about_app_name': 'Adler Notes App',

      'ok': 'حسناً',
      'cancel': 'إلغاء',
      'delete': 'حذف',
      'change_lang': 'English',
      'users': 'المستخدمون',
      // ===== Drawer =====
      'drawer_title': 'تطبيق مفكرة',
      'all_notes': 'كل الملاحظات',
      'favorites': 'المفضلة',
      'reminders': 'التذكيرات',
      'trash': 'سلة المحذوفات',
      'settings': 'الإعدادات',
      'users': 'المستخدمون',
      'logout': 'تسجيل الخروج',
      'delete_account': 'حذف الحساب',
      // ===== تسجيل الدخول =====
      'login': 'تسجيل الدخول',
      'username': 'اسم المستخدم',
      'password': 'كلمة المرور',
      'enter_username': 'أدخل اسم المستخدم',
      'enter_password': 'أدخل كلمة المرور',
      'login_error': 'بيانات الدخول غير صحيحة',

      // ===== إنشاء حساب =====
      'create_account': 'إنشاء حساب جديد',
      'have_account': 'لديك حساب بالفعل؟ تسجيل الدخول',
      'email': 'البريد الإلكتروني',
      'enter_email': 'أدخل البريد الإلكتروني',
      'register_success': 'تم إنشاء الحساب بنجاح',
      'user_exists': 'اسم المستخدم أو البريد مستخدم مسبقًا',

      // ===== إضافة ملاحظة =====
      'add_note': 'إضافة ملاحظة',
      'edit_note': 'تعديل الملاحظة',
      'add_image': 'إضافة صورة',
      'note': 'ملاحظة',
      'write_note': 'اكتب الملاحظة',
      'save_note': 'حفظ الملاحظة',
      'save_image': 'حفظ الصورة',
      'save_all': 'حفظ الكل',

      // ===== الوضع الليلي =====
      'dark_mode': 'الوضع الليلي',

      // ===== سلة المحذوفات =====
      'trash_empty': 'السلة فارغة',
      'restore': 'استرجاع',
      'delete_forever': 'حذف نهائي',
      'empty_trash': 'حذف كل السلة',
      'empty_trash_confirm': 'سيتم حذف جميع العناصر من السلة نهائياً',

      // ===== رسائل العمليات =====
      'moved_to_trash': 'تم نقل الملاحظة إلى سلة المحذوفات',
      'note_restored': 'تم استرجاع الملاحظة',
      'trash_emptied': 'تم حذف جميع عناصر سلة المهملات نهائياً',
      'note_deleted_forever': 'تم حذف الملاحظة نهائياً',
      'added_to_favorites': 'تمت الإضافة إلى المفضلة',
      'removed_from_favorites': 'تمت الإزالة من المفضلة',
      'note_updated': 'تم تحديث الملاحظة',
      'all_notes_moved_to_trash': 'تم نقل جميع الملاحظات إلى سلة المحذوفات',
      'logout_success': 'تم تسجيل الخروج بنجاح',
      'account_deleted': 'تم حذف الحساب نهائياً',

      // ===== الحوارات =====
      'delete_all': 'حذف كل الملاحظات',
      'delete_all_confirm': 'هل أنت متأكد أنك تريد حذف جميع الملاحظات؟',
      'delete_note_confirm': 'هل تريد حذف هذه الملاحظة؟',
      'confirm_logout': 'هل تريد تسجيل الخروج؟',
      'confirm_delete_account': 'سيتم حذف الحساب نهائياً، هل أنت متأكد؟',
    },

    // ================= ENGLISH =================
    'en': {

      // ===== General =====
      'favorites_notes': 'Favorite Notes',
      'all_notes_title': 'All Notes',
      'no_search_results': 'No search results',
      'no_favorite_notes': 'No favorite notes',
      'no_notes': 'No notes',
      'about': 'About',
      'about_app_name': 'Adler Notes App',

      'ok': 'OK',
      'cancel': 'Cancel',
      'delete': 'Delete',
      'change_lang': 'العربية',

      // ===== Drawer =====
      'drawer_title': 'Notes App',
      'all_notes': 'All Notes',
      'favorites': 'Favorites',
      'reminders': 'Reminders',
      'trash': 'Trash',
      'settings': 'Settings',
      'users': 'Users',
      'logout': 'Logout',
      'delete_account': 'Delete_account',
      // ===== Login =====
      'login': 'Login',
      'username': 'Username',
      'password': 'Password',
      'enter_username': 'Enter username',
      'enter_password': 'Enter password',
      'login_error': 'Invalid login data',

      // ===== Register =====
      'create_account': 'Create new account',
      'have_account': 'Already have an account? Login',
      'email': 'Email',
      'enter_email': 'Enter email',
      'register_success': 'Account created successfully',
      'user_exists': 'Username or email already exists',

      // ===== Add Note =====
      'add_note': 'Add Note',
      'edit_note': 'Edit Note',
      'add_image': 'Add Image',
      'note': 'Note',
      'write_note': 'Write note',
      'save_note': 'Save Note',
      'save_image': 'Save Image',
      'save_all': 'Save All',

      // ===== Dark Mode =====
      'dark_mode': 'Dark Mode',

      // ===== Trash =====
      'trash_empty': 'Trash is empty',
      'restore': 'Restore',
      'delete_forever': 'Delete Forever',
      'empty_trash': 'Empty Trash',
      'empty_trash_confirm': 'All items in trash will be permanently deleted',

      // ===== Operation Messages =====
      'moved_to_trash': 'Note moved to trash',
      'note_restored': 'Note restored successfully',
      'trash_emptied': 'Trash emptied permanently',
      'note_deleted_forever': 'Note permanently deleted',
      'added_to_favorites': 'Added to favorites',
      'removed_from_favorites': 'Removed from favorites',
      'note_updated': 'Note updated successfully',
      'all_notes_moved_to_trash': 'All notes moved to trash',
      'logout_success': 'Logged out successfully',
      'account_deleted': 'Account deleted permanently',

      // ===== Dialogs =====
      'delete_all': 'Delete all notes',
      'delete_all_confirm': 'Are you sure you want to delete all notes?',
      'delete_note_confirm': 'Do you want to delete this note?',
      'confirm_logout': 'Do you want to logout?',
      'confirm_delete_account': 'Account will be permanently deleted. Are you sure?',

      'users': 'Users',
    },
  };
}
