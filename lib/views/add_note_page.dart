import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notebook/controller/add_note_controller.dart';

class AddNotePage extends StatelessWidget {
  final String? initialNote;

  AddNotePage({super.key, this.initialNote});

  final AddNoteController controller = Get.put(AddNoteController());

  @override
  Widget build(BuildContext context) {
    controller.setInitialNote(initialNote);

    final theme = Theme.of(context);
    final isDark = Get.isDarkMode;

    return Scaffold(
      appBar: AppBar(
        title: Text(initialNote == null ? 'add_note'.tr : 'edit_note'.tr),
        centerTitle: true,
        backgroundColor: isDark ? null : Colors.blue,
        foregroundColor: Colors.white,
        elevation: 2,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [


            GestureDetector(
              onTap: controller.pickImage,
              child: Obx(() => AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                height: 180,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: theme.cardColor,
                  border: Border.all(
                    color: theme.dividerColor.withOpacity(0.25),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(isDark ? 0.35 : 0.08),
                      blurRadius: 12,
                      offset: const Offset(0, 6),
                    )
                  ],
                ),
                child: controller.image.value == null
                    ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.add_a_photo,
                        size: 42,
                        color: theme.colorScheme.primary),
                    const SizedBox(height: 10),
                    Text(
                      'add_image'.tr,
                      style: TextStyle(
                        color: theme.hintColor,
                        fontSize: 15,
                      ),
                    ),
                  ],
                )
                    : ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.file(
                    controller.image.value!,
                    fit: BoxFit.cover,
                  ),
                ),
              )),
            ),

            const SizedBox(height: 24),


            TextField(
              controller: controller.noteController,
              maxLines: 6,
              style: TextStyle(
                color: theme.textTheme.bodyLarge?.color,
                fontSize: 16,
              ),
              decoration: InputDecoration(
                labelText: 'note'.tr,
                hintText: 'write_note'.tr,
                filled: true,
                fillColor: theme.cardColor,
                contentPadding: const EdgeInsets.all(16),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18),
                  borderSide: BorderSide.none,
                ),
              ),
            ),

            const SizedBox(height: 28),


            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.note_alt_outlined),
                    label: Text('save_note'.tr),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      backgroundColor: theme.colorScheme.primary,
                      foregroundColor: theme.colorScheme.onPrimary,
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    onPressed: controller.saveNote,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.image_outlined),
                    label: Text('save_image'.tr),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      backgroundColor: theme.colorScheme.secondaryContainer,
                      foregroundColor: theme.colorScheme.onSecondaryContainer,
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    onPressed: controller.saveImage,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 14),


            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                icon: const Icon(Icons.save),
                label: Text('save_all'.tr),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  backgroundColor: theme.colorScheme.tertiaryContainer,
                  foregroundColor: theme.colorScheme.onTertiaryContainer,
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                onPressed: controller.saveNoteWithImage,
              ),

            ),
          ],
        ),
      ),
    );
  }
}
