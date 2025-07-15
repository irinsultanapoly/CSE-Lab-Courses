import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../core/logger/app_logger.dart';

class FirebaseStorageService {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Upload profile image
  Future<String> uploadProfileImage(File imageFile) async {
    try {
      final user = _auth.currentUser;
      if (user == null) {
        throw Exception('User not authenticated');
      }

      // Create a unique filename
      final fileName =
          'profile_${user.uid}_${DateTime.now().millisecondsSinceEpoch}.jpg';

      // Use a simpler path structure
      final storageRef = _storage.ref('profile_images/$fileName');

      // Upload the file
      AppLogger.i('Uploading profile image: $fileName');
      AppLogger.i('Storage bucket: ${_storage.app.name}');
      final uploadTask = storageRef.putFile(imageFile);

      // Wait for upload to complete
      final snapshot = await uploadTask;

      // Get download URL
      final downloadUrl = await snapshot.ref.getDownloadURL();

      AppLogger.i('Profile image uploaded successfully: $downloadUrl');
      return downloadUrl;
    } catch (e) {
      AppLogger.e('Failed to upload profile image: $e');
      rethrow;
    }
  }

  // Delete profile image
  Future<void> deleteProfileImage(String imageUrl) async {
    try {
      if (imageUrl.isEmpty) return;

      // Extract the file path from the URL
      final ref = _storage.refFromURL(imageUrl);
      await ref.delete();

      AppLogger.i('Profile image deleted successfully');
    } catch (e) {
      AppLogger.e('Failed to delete profile image: $e');
      rethrow;
    }
  }

  // Compress image before upload (optional)
  Future<File> compressImage(File imageFile) async {
    // For now, return the original file
    // You can add image compression logic here if needed
    return imageFile;
  }
}
