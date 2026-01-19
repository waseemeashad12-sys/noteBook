import 'package:flutter/material.dart';
import 'package:get/get.dart'; // استدعاء مكتبة GetX
import 'app_lang.dart';        // استدعاء ملف الترجمة (تأكد أن الملف موجود بنفس الاسم)
import 'splashScreen.dart';    // استدعاء صفحة البداية

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // نستخدم GetMaterialApp بدلاً من MaterialApp
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,

      // العنوان لم يعد يحتاج إلى ترجمة يدوية هنا، يمكن وضعه نصاً عادياً أو استخدام مفتاح الترجمة
      title: 'Notes App',

      // --- إعدادات الترجمة ---
      // هنا نستدعي الكلاس الذي أنشأناه في ملف app_lang.dart
      translations: AppTranslations(),

      // اللغة الافتراضية عند فتح التطبيق (العربية)
      locale: Locale('ar'),

      // اللغة البديلة في حال حدوث خطأ
      fallbackLocale: Locale('en'),

      // الصفحة الأولى
      home: Splashscreen(),
    );
  }
}