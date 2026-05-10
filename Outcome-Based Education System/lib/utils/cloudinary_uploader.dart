import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/foundation.dart'; // For kIsWeb
import 'package:http/http.dart' as http;

class CloudinaryUploader {
  /// Uploads an image to Cloudinary and returns the image URL
  static Future<String?> uploadImage(
      {Uint8List? imageBytes,
      File? imageFile,
      String? fileName,
      String foldername = 'default_folder',
      bool isRaw = false}) async {
    if ((kIsWeb && imageBytes == null) || (!kIsWeb && imageFile == null)) {
      return null; // Ensure valid input
    }

    try {
      Uri? url;
      if (isRaw) {
        url = Uri.parse('https://api.cloudinary.com/v1_1/dzen22zz1/raw/upload');
      } else {
        url =
            Uri.parse('https://api.cloudinary.com/v1_1/dzen22zz1/image/upload');
      }

      var request = http.MultipartRequest('POST', url)
        ..fields['upload_preset'] = 'OBE_Media'
        ..fields['folder'] = foldername;

      if (kIsWeb) {
        // Web: Upload image as bytes
        request.files.add(http.MultipartFile.fromBytes(
          'file',
          imageBytes!,
          filename: fileName ?? 'upload.jpg',
        ));
      } else {
        // Mobile: Upload image as file path
        request.files.add(await http.MultipartFile.fromPath(
          'file',
          imageFile!.path,
        ));
      }

      final response = await request.send();

      if (response.statusCode == 200) {
        final responseData = await http.Response.fromStream(response);
        final jsonResponse = json.decode(responseData.body);
        return jsonResponse['secure_url']; // Return Cloudinary URL
      } else {
        print('Image upload failed with status code: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error uploading to Cloudinary: $e');
      return null;
    }
  }
}
