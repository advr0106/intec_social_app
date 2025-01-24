import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';

class FirebaseHelper {
  static Future<String> uploadFile(File file, String path) async {
    final storageRef = FirebaseStorage.instance.ref().child(path);
    final uploadTask = await storageRef.putFile(file);
    return await uploadTask.ref.getDownloadURL();
  }
}