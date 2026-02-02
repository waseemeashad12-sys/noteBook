import 'package:notebook/views/users_page.dart';
import 'package:notebook/Services/session_service.dart';
import 'package:notebook/widgets/note_cards.dart';
import 'package:notebook/controller/notes_controller.dart';
import 'package:notebook/views/add_note_page.dart';
import 'package:notebook/views/settings_page.dart';
import 'package:notebook/views/trash_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotesPage extends StatelessWidget {
  NotesPage({super.key});

  final NotesController controller = Get.put(NotesController());

  @override
  Widget build(BuildContext context) {
    final isDark = Get.isDarkMode;

    return Scaffold(
      appBar: AppBar(
        elevation: 4,
        backgroundColor: isDark ? null : Colors.blue,
        foregroundColor: Colors.white,

        title: Obx(() => Text(
          controller.showFavoritesOnly.value
              ? 'favorites_notes'.tr
              : 'all_notes_title'.tr,
        )),

        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: controller.toggleDrawer,
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate: NotesSearchDelegate(controller),
              );
            },
          ),
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'about') {
                Get.defaultDialog(
                  title: 'about'.tr,
                  middleText: 'about_app_name'.tr,
                  textConfirm: 'ok'.tr,
                  confirmTextColor: Colors.white,
                  onConfirm: () => Get.back(),
                );
              }
            },
            itemBuilder: (context) => [
              PopupMenuItem(value: 'about', child: Text('about'.tr)),
            ],
          )
        ],
      ),

      body: Stack(
        children: [

          Obx(() {
            final visibleNotes = controller.filteredNotes;

            if (visibleNotes.isEmpty) {
              return Center(
                child: Text(
                  controller.searchQuery.value.isNotEmpty
                      ? 'no_search_results'.tr
                      : controller.showFavoritesOnly.value
                      ? 'no_favorite_notes'.tr
                      : 'no_notes'.tr,
                ),
              );
            }

            return ListView.builder(
              padding: const EdgeInsets.only(bottom: 80),
              itemCount: visibleNotes.length,
              itemBuilder: (context, index) {
                final note = visibleNotes[index];

                if (note.imagePath != null &&
                    note.content != null &&
                    note.content!.isNotEmpty) {
                  return NoteCards.imageNote(note, index, controller);
                } else if (note.imagePath != null) {
                  return NoteCards.imageOnly(note, index, controller);
                } else {
                  return NoteCards.text(note, index, controller);
                }
              },
            );
          }),


          Obx(() => controller.isDrawerOpen.value
              ? GestureDetector(
            onTap: controller.toggleDrawer,
            child: Container(
              color: Colors.black.withOpacity(0.4),
              width: double.infinity,
              height: double.infinity,
            ),
          )
              : const SizedBox()),

          _buildDrawer(context, isDark),
        ],
      ),

      floatingActionButton: FloatingActionButton.extended(
        backgroundColor:
        isDark ? Theme.of(context).colorScheme.secondary : Colors.blue,
        icon: const Icon(Icons.add),
        label: Text('add_note'.tr),
        onPressed: () async {
          final result = await Get.to(() => AddNotePage());

          if (result == true) {
            controller.showFavoritesOnly.value = false;
            controller.searchQuery.value = '';
            await controller.loadNotes();
          }
        },
      ),
    );
  }

  Widget _buildDrawer(BuildContext context, bool isDark) {
    return Obx(() => Visibility(
      visible: controller.isDrawerOpen.value,
      child: Align(
        alignment: AlignmentDirectional.centerStart,
        child: Container(
          width: 240,
          height: double.infinity,
          decoration: BoxDecoration(
            color: Theme.of(context).drawerTheme.backgroundColor ??
                Theme.of(context).scaffoldBackgroundColor,
            boxShadow: const [
              BoxShadow(color: Colors.black26, blurRadius: 10, offset: Offset(3, 0))
            ],
          ),
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              Container(
                padding: const EdgeInsets.fromLTRB(20, 50, 20, 20),
                decoration: BoxDecoration(
                  color: isDark
                      ? Theme.of(context).colorScheme.surfaceVariant
                      : Colors.blue,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundColor: Colors.white,
                      child: Icon(Icons.person,
                          size: 52,
                          color: isDark ? Colors.black : Colors.blue),
                    ),
                    const SizedBox(height: 12),
                    Obx(() => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          SessionService.currentUserName.value ?? '',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          SessionService.currentUserEmail.value ?? '',
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    )),
                    const SizedBox(height: 6),
                    Text(
                      'drawer_title'.tr,
                      style: const TextStyle(color: Colors.white70),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 10),

              _drawerItem(context, Icons.home, 'all_notes'.tr, () {
                controller.toggleDrawer();
                controller.showFavoritesOnly.value = false;
              }),

              _drawerItem(context, Icons.star, 'favorites'.tr, () {
                controller.toggleDrawer();
                controller.showFavoritesOnly.value = true;
              }),

              const Divider(height: 30),

              _drawerItem(context, Icons.delete, 'trash'.tr, () {
                controller.toggleDrawer();
                Get.to(() => TrashPage());
              }, color: Colors.red),

              _drawerItem(context, Icons.settings, 'settings'.tr, () {
                controller.toggleDrawer();
                Get.to(() => SettingsPage());
              }),

              _drawerItem(context, Icons.people, 'users'.tr, () {
                controller.toggleDrawer();
                Get.to(() => const UsersPage());
              }),

              const Divider(height: 30),

              _drawerItem(context, Icons.logout, 'logout'.tr, () {
                controller.toggleDrawer();
                Get.defaultDialog(
                  title: 'logout'.tr,
                  middleText: 'confirm_logout'.tr,
                  textCancel: 'cancel'.tr,
                  textConfirm: 'ok'.tr,
                  onConfirm: () {
                    Get.back();
                    controller.logout();
                  },
                );
              }, color: Colors.orange),

              _drawerItem(context, Icons.person_remove, 'delete_account'.tr, () {
                controller.toggleDrawer();
                Get.defaultDialog(
                  title: 'delete_account'.tr,
                  middleText: 'confirm_delete_account'.tr,
                  textCancel: 'cancel'.tr,
                  textConfirm: 'delete'.tr,
                  confirmTextColor: Colors.white,
                  buttonColor: Colors.red,
                  onConfirm: () {
                    Get.back();
                    controller.deleteAccount();
                  },
                );
              }, color: Colors.red),
            ],
          ),
        ),
      ),
    ));
  }

  Widget _drawerItem(BuildContext context, IconData icon, String title, VoidCallback onTap,
      {Color color = Colors.blue}) {
    return ListTile(
      leading: Icon(icon,
          color: color == Colors.blue
              ? Theme.of(context).colorScheme.primary
              : color),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
      onTap: onTap,
    );
  }
}
class NotesSearchDelegate extends SearchDelegate {
  final NotesController controller;

  NotesSearchDelegate(this.controller);

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
          controller.updateSearch('');
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        controller.updateSearch('');
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    Future.microtask(() => controller.updateSearch(query));
    return _buildSearchResults();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    Future.microtask(() => controller.updateSearch(query));
    return _buildSearchResults();
  }

  Widget _buildSearchResults() {
    return Obx(() {
      final results = controller.filteredNotes;

      if (results.isEmpty) {
        return const Center(child: Text('لا توجد نتائج'));
      }

      return ListView.builder(
        itemCount: results.length,
        itemBuilder: (context, index) {
          final note = results[index];

          if (note.imagePath != null &&
              note.content != null &&
              note.content!.isNotEmpty) {
            return NoteCards.imageNote(note, index, controller);
          } else if (note.imagePath != null) {
            return NoteCards.imageOnly(note, index, controller);
          } else {
            return NoteCards.text(note, index, controller);
          }
        },
      );
    });
  }
}

