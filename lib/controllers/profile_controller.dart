import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfileController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<Map<String, dynamic>?> getUserProfile() async {
    try {
      final userDoc = await _firestore.collection('users').doc('userId').get();
      return userDoc.data();
    } catch (e) {
      print("Error al obtener el perfil: $e");
      return null;
    }
  }

  Future<void> updateUserProfile({
    required String username,
    required String bio,
    required String phone,
    String? profilePic,
  }) async {
    try {
      await _firestore.collection('users').doc('userId').update({
        'username': username,
        'bio': bio,
        'phone': phone,
        if (profilePic != null) 'profilePic': profilePic,
      });
    } catch (e) {
      print("Error al actualizar perfil: $e");
    }
  }

  Future<String?> uploadProfileImage(File imageFile) async {
    try {
      final ref = FirebaseStorage.instance
          .ref()
          .child('profile_pics/${DateTime.now().millisecondsSinceEpoch}.jpg');
      await ref.putFile(imageFile);
      return await ref.getDownloadURL();
    } catch (e) {
      print("Error al subir imagen: $e");
      return null;
    }
  }
}