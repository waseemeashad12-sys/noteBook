import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notebook/controller/theme_controller.dart';

class SettingsPage extends StatelessWidget {
  SettingsPage({super.key});

  final ThemeController themeController = Get.find<ThemeController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("الإعدادات"),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const SizedBox(height: 10),


          Obx(() => Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 3,
            child: SwitchListTile(
              secondary: Icon(
                themeController.isDark
                    .value
                    ? Icons.dark_mode
                    : Icons.light_mode,
                color: Theme.of(context).colorScheme.primary,
              ),
              title: const Text(
                "الوضع الليلي",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              subtitle: const Text("تفعيل المظهر الداكن للتطبيق"),
              value: themeController.isDark
                  .value,
              onChanged: (value) {
                themeController.toggleTheme();
              },
            ),
          )),
        ],
      ),
    );
  }
}
