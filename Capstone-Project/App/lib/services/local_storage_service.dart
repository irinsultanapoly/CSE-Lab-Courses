import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
import 'package:firebase_auth/firebase_auth.dart';
import '../core/logger/app_logger.dart';

class LocalStorageService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Get the app documents directory
  Future<Directory> get _appDocumentsDir async {
    return await getApplicationDocumentsDirectory();
  }

  // Get the profile images directory
  Future<Directory> get _profileImagesDir async {
    final appDir = await _appDocumentsDir;
    final profileDir = Directory(path.join(appDir.path, 'profile_images'));

    // Create directory if it doesn't exist
    if (!await profileDir.exists()) {
      await profileDir.create(recursive: true);
    }

    return profileDir;
  }

  // Save profile image locally
  Future<String> saveProfileImage(File imageFile) async {
    try {
      final user = _auth.currentUser;
      if (user == null) {
        throw Exception('User not authenticated');
      }

      final profileDir = await _profileImagesDir;

      // Create unique filename
      final fileName =
          'profile_${user.uid}_${DateTime.now().millisecondsSinceEpoch}.jpg';
      final savedImagePath = path.join(profileDir.path, fileName);

      // Copy the image to local storage
      final savedImage = await imageFile.copy(savedImagePath);

      AppLogger.i('Profile image saved locally: ${savedImage.path}');
      return savedImage.path;
    } catch (e) {
      AppLogger.e('Failed to save profile image locally: $e');
      rethrow;
    }
  }

  // Get profile image file
  Future<File?> getProfileImage(String imagePath) async {
    try {
      final file = File(imagePath);
      if (await file.exists()) {
        return file;
      }
      return null;
    } catch (e) {
      AppLogger.e('Failed to get profile image: $e');
      return null;
    }
  }

  // Delete profile image
  Future<void> deleteProfileImage(String imagePath) async {
    try {
      final file = File(imagePath);
      if (await file.exists()) {
        await file.delete();
        AppLogger.i('Profile image deleted locally: $imagePath');
      }
    } catch (e) {
      AppLogger.e('Failed to delete profile image: $e');
      rethrow;
    }
  }

  // Clean up old profile images for the current user
  Future<void> cleanupOldProfileImages() async {
    try {
      final user = _auth.currentUser;
      if (user == null) return;

      final profileDir = await _profileImagesDir;
      final files = await profileDir.list().toList();

      for (final file in files) {
        if (file is File &&
            path.basename(file.path).startsWith('profile_${user.uid}_')) {
          // Keep only the most recent image
          final fileTime = await file.lastModified();
          final currentTime = DateTime.now();

          // Delete files older than 1 day
          if (currentTime.difference(fileTime).inDays > 1) {
            await file.delete();
            AppLogger.i('Cleaned up old profile image: ${file.path}');
          }
        }
      }
    } catch (e) {
      AppLogger.e('Failed to cleanup old profile images: $e');
    }
  }
}
