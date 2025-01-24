import 'package:cloud_firestore/cloud_firestore.dart';

class PostController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> createPost({
    required String userId,
    required String mediaUrl,
    required String caption,
  }) async {
    try {
      await _firestore.collection('posts').add({
        'userId': userId,
        'mediaUrl': mediaUrl,
        'caption': caption,
        'timestamp': DateTime.now().toIso8601String(),
        'likes': 0,
      });
    } catch (e) {
      print("Error al crear publicación: $e");
    }
  }

  Future<List<Map<String, dynamic>>> getPosts() async {
    try {
      final querySnapshot = await _firestore.collection('posts').get();
      return querySnapshot.docs.map((doc) => doc.data()).toList();
    } catch (e) {
      print("Error al obtener publicaciones: $e");
      return [];
    }
  }

  Future<void> toggleLike(String postId) async {
    try {
      final postRef = _firestore.collection('posts').doc(postId);
      final postDoc = await postRef.get();
      if (postDoc.exists) {
        int newLikes = postDoc['likes'] + 1;
        await postRef.update({'likes': newLikes});
      }
    } catch (e) {
      print("Error al dar like: $e");
    }
  }
}
