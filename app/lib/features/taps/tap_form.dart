import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:latlong2/latlong.dart';
import 'package:path_provider/path_provider.dart';

import 'tap.dart';

class TapForm extends StatefulWidget {
  final LatLng initialPosition;
  final void Function(Tap tap) onSave;

  const TapForm({
    super.key,
    required this.initialPosition,
    required this.onSave,
  });

  @override
  State<TapForm> createState() => _TapFormState();
}

class _TapFormState extends State<TapForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  File? _image;

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source, imageQuality: 80);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  Future<String?> _saveImageLocally(File image) async {
    final dir = await getApplicationDocumentsDirectory();
    final filename = DateTime.now().millisecondsSinceEpoch.toString() + ".jpg";
    final newPath = '${dir.path}/$filename';
    final savedImage = await image.copy(newPath);
    return savedImage.path;
  }

  void _handleSave() async {
    if (!_formKey.currentState!.validate()) return;

    String? imagePath;
    if (_image != null) {
      imagePath = await _saveImageLocally(_image!);
    }

    final tap = Tap(
      name: _nameController.text.trim(),
      description: _descriptionController.text.trim(),
      lat: widget.initialPosition.latitude,
      lon: widget.initialPosition.longitude,
      imagePath: imagePath,
    );

    widget.onSave(tap);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: "Name",
                  border: OutlineInputBorder(),
                ),
                validator: (value) => value == null || value.trim().isEmpty
                    ? "Bitte einen Namen eingeben"
                    : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(
                  labelText: "Beschreibung",
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
              ),
              const SizedBox(height: 16),
              if (_image != null) ...[
                Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.file(
                      _image!,
                      height: 180,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
              ],
              Wrap(
                spacing: 8,
                runSpacing: 8,
                alignment: WrapAlignment.end,
                children: [
                  TextButton.icon(
                    onPressed: () => _pickImage(ImageSource.camera),
                    icon: const Icon(Icons.camera_alt),
                    label: const Text('Foto aufnehmen'),
                  ),
                  TextButton.icon(
                    onPressed: () => _pickImage(ImageSource.gallery),
                    icon: const Icon(Icons.photo_library),
                    label: const Text('Galerie'),
                  ),
                  ElevatedButton(
                    onPressed: _handleSave,
                    child: const Text('Speichern'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
