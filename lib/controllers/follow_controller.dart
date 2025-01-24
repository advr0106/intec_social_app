import 'package:cloud_firestore/cloud_firestore.dart';

class FollowController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<Map<String, dynamic>>> getFollowers(String userId) async {
    try {
      final querySnapshot = await _firestore
          .collection('followers')
          .where('followedUserId', isEqualTo: userId)
          .get();
      return querySnapshot.docs.map((doc) => doc.data()).toList();
    } catch (e) {
      print("Error al obtener seguidores: $e");
      return [];
    }
  }
}