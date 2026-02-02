import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notebook/controller/notes_controller.dart';
import 'package:notebook/model/note_model.dart';
import 'dart:io';
import 'package:notebook/Services/database_service.dart';
import 'package:notebook/Services/session_service.dart';

class TrashPage extends StatefulWidget {
  TrashPage({super.key});

  @override
  State<TrashPage> createState() => _TrashPageState();
}

class _TrashPageState extends State<TrashPage> {
  final NotesController controller = Get.find<NotesController>();

  @override
  Widget build(BuildContext context) {
    final isDark = Get.isDarkMode;

    return Scaffold(
      appBar: AppBar(
        title: Text("trash".tr),
        backgroundColor: isDark ? null : Colors.blue,
        foregroundColor: Colors.white,

        actions: [
          IconButton(
            icon: const Icon(Icons.delete_forever),
            onPressed: () {
              Get.defaultDialog(
                title: "permanent_delete".tr,
                middleText: "delete_trash_confirm".tr,
                textCancel: "cancel".tr,
                textConfirm: "delete_all".tr,
                confirmTextColor: Colors.white,
                buttonColor: Colors.red,
                onConfirm: () async {
                  await controller.emptyTrash();

                  Get.back();

                  Get.snackbar(
                    "deleted".tr,
                    "trash_emptied".tr,
                    snackPosition: SnackPosition.BOTTOM,
                    backgroundColor: Colors.red,
                    colorText: Colors.white,
                  );

                  (context as Element).markNeedsBuild();
                },
              );
            },
          )
        ],
      ),

      body: FutureBuilder<List<NoteModel>>(
        future: _loadDeletedNotes(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final notes = snapshot.data!;

          if (notes.isEmpty) {
            return Center(child: Text("trash_empty".tr));
          }

          return ListView.builder(
            itemCount: notes.length,
            itemBuilder: (context, index) {
              final note = notes[index];

              return Card(
                margin: const EdgeInsets.all(10),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (note.content != null)
                        Text(
                          note.content!,
                          style: const TextStyle(fontSize: 16),
                        ),

                      if (note.imagePath != null) ...[
                        const SizedBox(height: 10),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.file(
                            File(note.imagePath!),
                            height: 180,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ],

                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [

                          IconButton(
                            icon: const Icon(Icons.restore, color: Colors.green),
                            onPressed: () async {
                              await controller.restoreNote(note.id!);

                              Get.snackbar(
                                "restored".tr,
                                "note_restored".tr,
                                snackPosition: SnackPosition.BOTTOM,
                                backgroundColor: Colors.green,
                                colorText: Colors.white,
                              );

                              controller.loadNotes();
                              setState(() {});
                            },
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  Future<List<NoteModel>> _loadDeletedNotes() async {
    final db = await DatabaseService.database;
    final userId = SessionService.currentUserId;
    if (userId == null) return [];

    final result = await db.rawQuery('''
    SELECT notes.*, note_images.image_path
    FROM notes
    LEFT JOIN note_images ON notes.id = note_images.note_id
    WHERE notes.user_id = ? AND notes.is_deleted = 1
    ORDER BY notes.created_at DESC
  ''', [userId]);

    return result.map((e) => NoteModel.fromMap(e)).toList();
  }
}
