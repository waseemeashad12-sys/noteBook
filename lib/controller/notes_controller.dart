import 'dart:io';
import 'package:get/get.dart';
import 'package:notebook/model/note_model.dart';
import 'package:notebook/Services/database_service.dart';
import 'package:notebook/Services/session_service.dart';
import 'package:notebook/views/login_view.dart';
import 'package:flutter/material.dart';

class NotesController extends GetxController {
  var showFavoritesOnly = false.obs;
  var searchQuery = ''.obs;

  var notes = <NoteModel>[].obs;
  var isDrawerOpen = false.obs;

  void toggleFavoritesView() {
    showFavoritesOnly.value = !showFavoritesOnly.value;
  }

  void toggleDrawer() {
    isDrawerOpen.value = !isDrawerOpen.value;
  }

  void updateSearch(String value) {
    searchQuery.value = value;
  }

  List<NoteModel> get filteredNotes {
    List<NoteModel> list = notes;

    if (showFavoritesOnly.value) {
      list = list.where((n) => n.isFavorite == 1).toList();
    }

    if (searchQuery.value.isNotEmpty) {
      list = list.where((n) =>
          (n.content ?? '').toLowerCase().contains(searchQuery.value.toLowerCase())).toList();
    }

    return list;
  }

  @override
  void onInit() {
    super.onInit();
    loadNotes();
  }

  Future<void> loadNotes() async {
    final userId = SessionService.currentUserId;
    if (userId == null) return;

    final db = await DatabaseService.database;

    final result = await db.rawQuery('''
      SELECT notes.*, note_images.image_path
      FROM notes
      LEFT JOIN note_images ON notes.id = note_images.note_id
      WHERE notes.user_id = ? AND notes.is_deleted = 0
      ORDER BY notes.created_at DESC
    ''', [userId]);

    notes.value = result.map((e) => NoteModel.fromMap(e)).toList();
  }

  Future<void> deleteNoteById(int noteId) async {
    final db = await DatabaseService.database;

    await db.update(
      'notes',
      {'is_deleted': 1},
      where: 'id = ?',
      whereArgs: [noteId],
    );

    notes.removeWhere((n) => n.id == noteId);

    Get.snackbar(
      'moved_to_trash'.tr,
      'note_moved_to_trash'.tr,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.orange.shade100,
    );
  }

  Future<void> restoreNote(int noteId) async {
    final db = await DatabaseService.database;

    await db.update(
      'notes',
      {'is_deleted': 0},
      where: 'id = ?',
      whereArgs: [noteId],
    );

    await loadNotes();

    Get.snackbar(
      'restored'.tr,
      'note_restored'.tr,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green.shade100,
    );
  }

  Future<void> permanentlyDeleteNote(int noteId) async {
    final db = await DatabaseService.database;

    await db.delete('note_images', where: 'note_id = ?', whereArgs: [noteId]);
    await db.delete('notes', where: 'id = ?', whereArgs: [noteId]);

    Get.snackbar(
      'deleted_forever'.tr,
      'note_deleted_forever'.tr,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.red.shade100,
    );
  }

  Future<void> emptyTrash() async {
    final userId = SessionService.currentUserId;
    if (userId == null) return;

    final db = await DatabaseService.database;

    await db.delete(
      'note_images',
      where: 'note_id IN (SELECT id FROM notes WHERE user_id = ? AND is_deleted = 1)',
      whereArgs: [userId],
    );

    await db.delete(
      'notes',
      where: 'user_id = ? AND is_deleted = 1',
      whereArgs: [userId],
    );

    Get.snackbar(
      'trash_emptied'.tr,
      'trash_emptied_success'.tr,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.red.shade100,
    );
  }

  Future<void> toggleFavoriteById(int noteId) async {
    final db = await DatabaseService.database;

    final index = notes.indexWhere((n) => n.id == noteId);
    if (index == -1) return;

    final note = notes[index];
    final newValue = note.isFavorite == 1 ? 0 : 1;

    await db.update(
      'notes',
      {'is_favorite': newValue},
      where: 'id = ?',
      whereArgs: [noteId],
    );

    notes[index] = NoteModel(
      id: note.id,
      title: note.title,
      content: note.content,
      createdAt: note.createdAt,
      updatedAt: note.updatedAt,
      userId: note.userId,
      isFavorite: newValue,
      categoryId: note.categoryId,
      imagePath: note.imagePath,
    );

    Get.snackbar(
      newValue == 1 ? 'added_to_favorites'.tr : 'removed_from_favorites'.tr,
      newValue == 1 ? 'note_added_favorites'.tr : 'note_removed_favorites'.tr,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.amber.shade100,
    );
  }

  Future<void> updateNoteById(int noteId, Map<String, dynamic> updatedData) async {
    final db = await DatabaseService.database;

    final index = notes.indexWhere((n) => n.id == noteId);
    if (index == -1) return;

    final oldNote = notes[index];

    final updatedNote = NoteModel(
      id: oldNote.id,
      title: oldNote.title,
      content: updatedData['data'],
      createdAt: oldNote.createdAt,
      updatedAt: DateTime.now().toIso8601String(),
      userId: oldNote.userId,
      isFavorite: oldNote.isFavorite,
      categoryId: oldNote.categoryId,
      imagePath: oldNote.imagePath,
    );

    await db.update(
      'notes',
      updatedNote.toMap(),
      where: 'id = ?',
      whereArgs: [noteId],
    );

    notes[index] = updatedNote;

    Get.snackbar(
      'updated'.tr,
      'note_updated'.tr,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.blue.shade100,
    );
  }

  Future<void> deleteAllNotes() async {
    final userId = SessionService.currentUserId;
    if (userId == null) return;

    final db = await DatabaseService.database;

    await db.update(
      'notes',
      {'is_deleted': 1},
      where: 'user_id = ?',
      whereArgs: [userId],
    );

    notes.clear();

    Get.snackbar(
      'all_moved_to_trash'.tr,
      'all_notes_moved_to_trash'.tr,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.orange.shade100,
    );
  }

  void logout() {
    SessionService.clearSession();
    Get.offAll(() => Login());
  }

  Future<void> deleteAccount() async {
    final userId = SessionService.currentUserId;
    if (userId == null) return;

    await DatabaseService.deleteUserCompletely(userId);
    logout();
  }
}
