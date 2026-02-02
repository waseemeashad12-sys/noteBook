import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notebook/controller/notes_controller.dart';
import 'package:notebook/model/note_model.dart';
import 'package:notebook/views/add_note_page.dart';

class NoteCards {

  static Widget text(NoteModel note, int index, NotesController controller) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),

        leading: IconButton(
          icon: const Icon(Icons.delete, color: Colors.red),
          onPressed: () {
            if (note.id != null) {
              Get.defaultDialog(
                title: 'delete'.tr,
                middleText: 'delete_note_confirm'.tr,
                textCancel: 'cancel'.tr,
                textConfirm: 'delete'.tr,
                confirmTextColor: Colors.white,
                buttonColor: Colors.red,
                onConfirm: () {
                  controller.deleteNoteById(note.id!);
                  Get.back();
                },
              );
            }
          },
        ),

        title: Text(
          note.content ?? '',
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w500,
            color: Get.isDarkMode ? Colors.white : Colors.black87,
          ),
        ),

        subtitle: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            IconButton(
              icon: Icon(
                note.isFavorite == 1 ? Icons.star : Icons.star_border,
                color: Colors.amber,
              ),
              onPressed: () {
                if (note.id != null) {
                  controller.toggleFavoriteById(note.id!);
                }
              },
            ),
          ],
        ),

        trailing: IconButton(
          icon: Icon(Icons.edit, color: Theme.of(Get.context!).colorScheme.primary),
          onPressed: () async {
            final result =
            await Get.to(() => AddNotePage(initialNote: note.content));

            if (result == true) {
              controller.searchQuery.value = '';
              controller.showFavoritesOnly.value = false;
              await controller.loadNotes();
            }
          },
        ),
      ),
    );
  }

  /// 📝 صورة + نص
  static Widget imageNote(NoteModel note, int index, NotesController controller) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (note.imagePath != null)
            Image.file(
              File(note.imagePath!),
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
            ),

          Padding(
            padding: const EdgeInsets.all(12),
            child: Text(
              note.content ?? '',
              style: TextStyle(
                fontSize: 16,
                height: 1.4,
                fontWeight: FontWeight.w500,
                color: Get.isDarkMode ? Colors.white : Colors.black87,
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: Icon(
                    note.isFavorite == 1 ? Icons.star : Icons.star_border,
                    color: Colors.amber,
                  ),
                  onPressed: () {
                    if (note.id != null) {
                      controller.toggleFavoriteById(note.id!);
                    }
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () {
                    if (note.id != null) {
                      Get.defaultDialog(
                        title: 'delete'.tr,
                        middleText: 'delete_note_confirm'.tr,
                        textCancel: 'cancel'.tr,
                        textConfirm: 'delete'.tr,
                        confirmTextColor: Colors.white,
                        buttonColor: Colors.red,
                        onConfirm: () {
                          controller.deleteNoteById(note.id!);
                          Get.back();
                        },
                      );
                    }
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  /// 🖼 صورة فقط
  static Widget imageOnly(NoteModel note, int index, NotesController controller) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          if (note.imagePath != null)
            Image.file(
              File(note.imagePath!),
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
            ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: Icon(
                  note.isFavorite == 1 ? Icons.star : Icons.star_border,
                  color: Colors.amber,
                ),
                onPressed: () {
                  if (note.id != null) {
                    controller.toggleFavoriteById(note.id!);
                  }
                },
              ),
              IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                onPressed: () {
                  if (note.id != null) {
                    Get.defaultDialog(
                      title: 'delete'.tr,
                      middleText: 'delete_note_confirm'.tr,
                      textCancel: 'cancel'.tr,
                      textConfirm: 'delete'.tr,
                      confirmTextColor: Colors.white,
                      buttonColor: Colors.red,
                      onConfirm: () {
                        controller.deleteNoteById(note.id!);
                        Get.back();
                      },
                    );
                  }
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
