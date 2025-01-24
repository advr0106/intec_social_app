import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';

class StorageController {
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<String> uploadMedia(File file) async {
    try {
      final ref = _storage.ref().child('posts/${DateTime.now().toIso8601String()}');
      final uploadTask = ref.putFile(file);
      final snapshot = await uploadTask.whenComplete(() {});
      final downloadUrl = await snapshot.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      print("Error al subir archivo: $e");
      return '';
    }
  }
}