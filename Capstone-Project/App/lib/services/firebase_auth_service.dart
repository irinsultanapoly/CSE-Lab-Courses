import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../core/logger/app_logger.dart';

class FirebaseAuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Get current user
  User? get currentUser => _auth.currentUser;

  // Get auth state changes stream
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  // Sign up with email and password
  Future<UserCredential> signUpWithEmailAndPassword({
    required String email,
    required String password,
    required String displayName,
  }) async {
    try {
      AppLogger.i('Attempting to sign up user: $email');

      final credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Update display name
      await credential.user?.updateDisplayName(displayName);

      // Create user profile in Firestore
      await _createUserProfile(credential.user!, displayName);

      AppLogger.i('User signed up successfully: ${credential.user?.uid}');
      return credential;
    } catch (e) {
      AppLogger.e('Sign up failed: $e');
      rethrow;
    }
  }

  // Sign in with email and password
  Future<UserCredential> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      AppLogger.i('Attempting to sign in user: $email');

      final credential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      AppLogger.i('User signed in successfully: ${credential.user?.uid}');
      return credential;
    } catch (e) {
      AppLogger.e('Sign in failed: $e');
      rethrow;
    }
  }

  // Sign out
  Future<void> signOut() async {
    try {
      AppLogger.i('Signing out user: ${currentUser?.uid}');
      await _auth.signOut();
      AppLogger.i('User signed out successfully');
    } catch (e) {
      AppLogger.e('Sign out failed: $e');
      rethrow;
    }
  }

  // Send password reset email
  Future<void> sendPasswordResetEmail(String email) async {
    try {
      AppLogger.i('Sending password reset email to: $email');
      await _auth.sendPasswordResetEmail(email: email);
      AppLogger.i('Password reset email sent successfully');
    } catch (e) {
      AppLogger.e('Password reset email failed: $e');
      rethrow;
    }
  }

  // Update user profile
  Future<void> updateUserProfile({
    String? displayName,
    String? photoURL,
  }) async {
    try {
      AppLogger.i('Updating user profile: ${currentUser?.uid}');

      if (displayName != null) {
        await currentUser?.updateDisplayName(displayName);
      }

      if (photoURL != null) {
        await currentUser?.updatePhotoURL(photoURL);
      }

      // Update Firestore profile
      await _updateUserProfileInFirestore(displayName, photoURL);

      AppLogger.i('User profile updated successfully');
    } catch (e) {
      AppLogger.e('Profile update failed: $e');
      rethrow;
    }
  }

  // Delete user account
  Future<void> deleteUserAccount() async {
    try {
      AppLogger.i('Deleting user account: ${currentUser?.uid}');

      // Delete from Firestore first
      await _deleteUserProfileFromFirestore();

      // Delete from Firebase Auth
      await currentUser?.delete();

      AppLogger.i('User account deleted successfully');
    } catch (e) {
      AppLogger.e('Account deletion failed: $e');
      rethrow;
    }
  }

  // Create user profile in Firestore
  Future<void> _createUserProfile(User user, String displayName) async {
    try {
      await _firestore.collection('users').doc(user.uid).set({
        'uid': user.uid,
        'email': user.email,
        'displayName': displayName,
        'photoURL': user.photoURL,
        'createdAt': FieldValue.serverTimestamp(),
        'lastLoginAt': FieldValue.serverTimestamp(),
        'detectionCount': 0,
        'healthyPlantCount': 0,
        'diseasedPlantCount': 0,
      });
      AppLogger.i('User profile created in Firestore: ${user.uid}');
    } catch (e) {
      AppLogger.e('Failed to create user profile in Firestore: $e');
      rethrow;
    }
  }

  // Update user profile in Firestore
  Future<void> _updateUserProfileInFirestore(
    String? displayName,
    String? photoURL,
  ) async {
    try {
      final updates = <String, dynamic>{};
      if (displayName != null) updates['displayName'] = displayName;
      if (photoURL != null) updates['photoURL'] = photoURL;
      updates['updatedAt'] = FieldValue.serverTimestamp();

      // Check if document exists, if not create it
      final docRef = _firestore.collection('users').doc(currentUser!.uid);
      final doc = await docRef.get();

      if (doc.exists) {
        // Update existing document
        await docRef.update(updates);
        AppLogger.i('User profile updated in Firestore: ${currentUser!.uid}');
      } else {
        // Create new document
        final userData = {
          'uid': currentUser!.uid,
          'email': currentUser!.email,
          'displayName': displayName ?? currentUser!.displayName ?? 'User',
          'photoURL': photoURL ?? currentUser!.photoURL,
          'createdAt': FieldValue.serverTimestamp(),
          'lastLoginAt': FieldValue.serverTimestamp(),
          'detectionCount': 0,
          'healthyPlantCount': 0,
          'diseasedPlantCount': 0,
          ...updates,
        };
        await docRef.set(userData);
        AppLogger.i('User profile created in Firestore: ${currentUser!.uid}');
      }
    } catch (e) {
      AppLogger.e('Failed to update user profile in Firestore: $e');
      rethrow;
    }
  }

  // Delete user profile from Firestore
  Future<void> _deleteUserProfileFromFirestore() async {
    try {
      await _firestore.collection('users').doc(currentUser!.uid).delete();
      AppLogger.i('User profile deleted from Firestore: ${currentUser!.uid}');
    } catch (e) {
      AppLogger.e('Failed to delete user profile from Firestore: $e');
      rethrow;
    }
  }

  // Get user profile from Firestore
  Future<Map<String, dynamic>?> getUserProfile() async {
    try {
      final doc = await _firestore
          .collection('users')
          .doc(currentUser!.uid)
          .get();
      if (doc.exists) {
        return doc.data();
      }
      return null;
    } catch (e) {
      AppLogger.e('Failed to get user profile from Firestore: $e');
      return null;
    }
  }

  // Update user stats in Firestore
  Future<void> updateUserStats({
    int? detectionCount,
    int? healthyPlantCount,
    int? diseasedPlantCount,
  }) async {
    try {
      final updates = <String, dynamic>{};
      if (detectionCount != null) updates['detectionCount'] = detectionCount;
      if (healthyPlantCount != null)
        updates['healthyPlantCount'] = healthyPlantCount;
      if (diseasedPlantCount != null)
        updates['diseasedPlantCount'] = diseasedPlantCount;
      updates['lastUpdatedAt'] = FieldValue.serverTimestamp();

      await _firestore
          .collection('users')
          .doc(currentUser!.uid)
          .update(updates);
      AppLogger.i('User stats updated in Firestore: ${currentUser!.uid}');
    } catch (e) {
      AppLogger.e('Failed to update user stats in Firestore: $e');
      rethrow;
    }
  }
}
