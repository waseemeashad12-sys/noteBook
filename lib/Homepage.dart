
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notebook/controller/notes_controller.dart';
import 'add.dart';

class NotesPage extends StatelessWidget {
  final NotesController controller = Get.put(NotesController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('app_title'.tr),
        backgroundColor: Colors.blue,
        // 1. زر القائمة المخصص
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () => controller.toggleDrawer(),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.language),
            onPressed: () => controller.changeLanguage(),
          ),
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          ),
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'about') {
                Get.defaultDialog(
                  title: 'about'.tr,
                  middleText: 'Adler Notes App',
                  textConfirm: 'ok'.tr,
                  confirmTextColor: Colors.white,
                  onConfirm: () => Get.back(),
                );
              }
            },
            itemBuilder: (context) => [
              PopupMenuItem(value: 'settings', child: Text('settings'.tr)),
              PopupMenuItem(value: 'about', child: Text('about'.tr)),
            ],
          ),
        ],
      ),

      // لا نستخدم drawer: هنا، بل نبنيها يدوياً في الأسفل

      body: Stack(
        children: [
          // === الطبقة الأولى: محتوى الملاحظات (الأساس) ===
          Obx(() {
            if (controller.notes.isEmpty) {
              return Center(child: Text('no_notes'.tr));
            }
            return ListView.builder(
              itemCount: controller.notes.length,
              itemBuilder: (context, index) {
                final item = controller.notes[index];
                if (item['type'] == 'note_image') {
                  return _buildImageNoteCard(item, index);
                } else if (item['type'] == 'image') {
                  return _buildImageOnlyCard(item, index);
                } else {
                  return _buildTextNoteCard(item, index);
                }
              },
            );
          }),

          // === الطبقة الثانية: خلفية شفافة (عند فتح القائمة) ===
          // وظيفتها: عند الضغط خارج القائمة، يتم إغلاقها
          Obx(() => controller.isDrawerOpen.value
              ? GestureDetector(
            onTap: () => controller.toggleDrawer(),
            child: Container(
              color: Colors.black.withOpacity(0.5), // تعتيم الخلفية
              width: double.infinity,
              height: double.infinity,
            ),
          )
              : const SizedBox()),

          // === الطبقة الثالثة: القائمة الجانبية نفسها ===
          Obx(() => Visibility(
            visible: controller.isDrawerOpen.value,
            child: Align(
              // AlignmentDirectional يتعامل تلقائياً مع اليمين واليسار (عربي/إنجليزي)
              alignment: AlignmentDirectional.centerStart,
              child: Container(
                width: 250, // عرض القائمة
                height: double.infinity, // الطول (تحت الهيدر لأننا داخل body)
                color: Colors.white,
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(20),
                      color: Colors.blue,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(Icons.note, color: Colors.white, size: 40),
                          const SizedBox(height: 10),
                          Text(
                            'drawer_title'.tr,
                            style: const TextStyle(color: Colors.white, fontSize: 24),
                          ),
                          Text(
                            'memory_usage'.tr,
                            style: const TextStyle(color: Colors.white70),
                          ),
                        ],
                      ),
                    ),
                    ListTile(
                      leading: const Icon(Icons.home, color: Colors.blue),
                      title: Text('all_notes'.tr),
                      onTap: () => controller.toggleDrawer(),
                    ),
                    ListTile(
                      leading: const Icon(Icons.star, color: Colors.blue),
                      title: Text('favorites'.tr),
                      onTap: () => controller.toggleDrawer(),
                    ),
                    ListTile(
                      leading: const Icon(Icons.access_alarm, color: Colors.blue),
                      title: Text('reminders'.tr),
                      onTap: () => controller.toggleDrawer(),
                    ),
                    const Divider(),
                    ListTile(
                      leading: const Icon(Icons.delete, color: Colors.red),
                      title: Text('trash'.tr),
                      onTap: () {
                        controller.toggleDrawer();
                        Get.defaultDialog(
                          title: 'delete_all'.tr,
                          middleText: 'delete_all_confirm'.tr,
                          textCancel: 'cancel'.tr,
                          textConfirm: 'delete'.tr,
                          confirmTextColor: Colors.white,
                          buttonColor: Colors.red,
                          onConfirm: () {
                            controller.deleteAllNotes();
                            Get.back();
                          },
                        );
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.settings, color: Colors.blue),
                      title: Text('settings'.tr),
                      onTap: () => controller.toggleDrawer(),
                    ),
                  ],
                ),
              ),
            ),
          )),
        ],
      ),

      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () async {
          final result = await Get.to(() => AddNotePage());
          if (result != null) {
            controller.addNote(result);
          }
        },
      ),
    );
  }

  // --- Widgets البطاقات (نفس السابقة) ---
  Widget _buildTextNoteCard(Map<String, dynamic> item, int index) {
    return ListTile(
      leading: IconButton(
        icon: const Icon(Icons.delete, color: Colors.red),
        onPressed: () => controller.deleteNote(index),
      ),
      title: Text(item['data'] ?? '', style: const TextStyle(fontSize: 18)),
      trailing: IconButton(
        icon: const Icon(Icons.edit, color: Colors.blue),
        onPressed: () async {
          final edited = await Get.to(() => AddNotePage(initialNote: item['data']));
          if (edited != null && edited['type'] == 'note') {
            controller.updateNote(index, edited);
          }
        },
      ),
    );
  }

  Widget _buildImageNoteCard(Map<String, dynamic> item, int index) {
    return Card(
      margin: const EdgeInsets.all(10),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Text(item['note'] ?? '', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 10),
            if (item['image'] != null)
              Image.file(item['image'] as File, height: 200, fit: BoxFit.cover),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () => controller.deleteNote(index),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildImageOnlyCard(Map<String, dynamic> item, int index) {
    return Card(
      margin: const EdgeInsets.all(10),
      child: Column(
        children: [
          if (item['data'] != null)
            Image.file(item['data'] as File, height: 200, width: double.infinity, fit: BoxFit.cover),
          IconButton(
            icon: const Icon(Icons.delete, color: Colors.red),
            onPressed: () => controller.deleteNote(index),
          ),
        ],
      ),
    );
  }
}