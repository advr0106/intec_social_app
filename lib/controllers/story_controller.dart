import 'package:cloud_firestore/cloud_firestore.dart';

class StoriesController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> createStory() async {
    try {
      await _firestore.collection('stories').add({
        'userId': 'user123', // Cambiar por el ID del usuario actual
        'timestamp': DateTime.now().toIso8601String(),
        'mediaUrl': 'https://example.com/story.jpg', // Enlace de la imagen de la historia
      });
    } catch (e) {
      print("Error al crear historia: $e");
    }
  }

  Future<List<Map<String, dynamic>>> getStories() async {
    try {
      final querySnapshot = await _firestore.collection('stories').get();
      return querySnapshot.docs.map((doc) => doc.data()).toList();
    } catch (e) {
      print("Error al obtener historias: $e");
      return [];
    }
  }
}
