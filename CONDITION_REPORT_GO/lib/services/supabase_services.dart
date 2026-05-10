import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseServices {
  File? imageFile;
  final SupabaseClient _supabaseClient = Supabase.instance.client;
  ValueNotifier<double> uploadProgress = ValueNotifier<double>(0.0);

  // Pick an image using ImagePicker
  Future<void> pickImage(ImageSource source) async {
    final ImagePicker picker = ImagePicker();
    final image = await picker.pickImage(source: source);

    if (image != null) {
      imageFile = File(image.path);
    }
  }

  Future<String?> uploadImageToSupabase(
      BuildContext context, String imagePath) async {
    final file = File(imagePath);
    final fileBytes = await file.readAsBytes();
    final fileName = DateTime.now().millisecondsSinceEpoch.toString();
    final path = 'images/$fileName.jpg';

    await _supabaseClient.storage.from('Images').uploadBinary(
          path,
          fileBytes,
          fileOptions: const FileOptions(upsert: false),
        );

    final publicUrl = _supabaseClient.storage.from('Images').getPublicUrl(path);
    return publicUrl;
  }

  // Upload multiple images to Supabase with progress tracking
  Future<void> uploadListImagesToSupabase(
      BuildContext context, List<String> images) async {
    if (images.isEmpty) return;

    try {
      uploadProgress.value = 0.0;

      // Upload all images in parallel
      final totalImages = images.length;
      final results = await Future.wait(
        images.map((imagePath) async {
          // await uploadImageToSupabase(context, imagePath);
          uploadProgress.value += 1 / totalImages; // Update progress
        }),
      );

      // Check if all uploads were successful
      if (results.every((result) => result == null)) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("All images uploaded successfully!")),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to upload some images: $e")),
      );
    }
  }
}
