import 'package:cloud_firestore/cloud_firestore.dart';

class ChatController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> sendMessage({required String chatId, required String message}) async {
    try {
      await _firestore.collection('chats').doc(chatId).collection('messages').add({
        'text': message,
        'timestamp': DateTime.now().toIso8601String(),
        'userId': 'user123', // Cambiar por el ID del usuario actual
      });
    } catch (e) {
      print("Error al enviar mensaje: $e");
    }
  }

  Future<List<Map<String, dynamic>>> getMessages(String chatId) async {
    try {
      final querySnapshot = await _firestore
          .collection('chats')
          .doc(chatId)
          .collection('messages')
          .orderBy('timestamp')
          .get();
      return querySnapshot.docs.map((doc) => doc.data()).toList();
    } catch (e) {
      print("Error al obtener mensajes: $e");
      return [];
    }
  }
}