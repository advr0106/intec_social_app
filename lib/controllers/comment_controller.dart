import 'package:cloud_firestore/cloud_firestore.dart';

class CommentController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addComment({required String postId, required String comment}) async {
    try {
      await _firestore.collection('comments').add({
        'postId': postId,
        'comment': comment,
        'userId': 'user123', // Cambiar por el ID del usuario actual
        'timestamp': DateTime.now().toIso8601String(),
      });
    } catch (e) {
      print("Error al agregar comentario: $e");
    }
  }

  Future<List<Map<String, dynamic>>> getComments(String postId) async {
    try {
      final querySnapshot = await _firestore
          .collection('comments')
          .where('postId', isEqualTo: postId)
          .get();
      return querySnapshot.docs.map((doc) => doc.data()).toList();
    } catch (e) {
      print("Error al obtener comentarios: $e");
      return [];
    }
  }
}