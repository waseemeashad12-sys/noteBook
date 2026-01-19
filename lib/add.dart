import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:get/get.dart'; // استيراد GetX

class AddNotePage extends StatefulWidget {
  final String? initialNote;

  AddNotePage({this.initialNote});

  @override
  State<AddNotePage> createState() => _AddNotePageState();
}

class _AddNotePageState extends State<AddNotePage> {
  late TextEditingController noteController;
  File? _image;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    noteController = TextEditingController(text: widget.initialNote ?? "");
  }

  Future<void> _pickImage() async {
    final XFile? picked = await _picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() {
        _image = File(picked.path);
      });
    }
  }

  void _saveNote() {
    if (noteController.text.isEmpty) return;
    // استخدام Get.back لإرجاع البيانات
    Get.back(result: {
      'type': 'note',
      'data': noteController.text,
    });
  }

  void _saveImage() {
    if (_image == null) return;
    Get.back(result: {
      'type': 'image',
      'data': _image,
    });
  }

  void _saveNoteWithImage() {
    if (noteController.text.isEmpty && _image == null) return;
    Get.back(result: {
      'type': 'note_image',
      'note': noteController.text,
      'image': _image,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.initialNote == null ? 'add_note'.tr : 'edit_note'.tr),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            GestureDetector(
              onTap: _pickImage,
              child: Container(
                height: 150,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.grey[200],
                ),
                child: _image == null
                    ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.add_a_photo, size: 40),
                    const SizedBox(height: 8),
                    Text('add_image'.tr),
                  ],
                )
                    : ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.file(_image!, fit: BoxFit.cover),
                ),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: noteController,
              maxLines: 5,
              decoration: InputDecoration(
                labelText: 'note'.tr,
                hintText: 'write_note'.tr,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.note),
                    label: Text('save_note'.tr),
                    onPressed: _saveNote,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.image),
                    label: Text('save_image'.tr),
                    onPressed: _saveImage,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                icon: const Icon(Icons.save),
                label: Text('save_all'.tr),
                onPressed: _saveNoteWithImage,
              ),
            ),
          ],
        ),
      ),
    );
  }
}