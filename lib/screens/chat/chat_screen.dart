import 'package:flutter/material.dart';
import '../../controllers/chat_controller.dart';

class ChatScreen extends StatefulWidget {
  final String chatId;

  const ChatScreen({required this.chatId});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final ChatController _chatController = ChatController();
  final TextEditingController _messageController = TextEditingController();
  List<Map<String, dynamic>> messages = [];

  @override
  void initState() {
    super.initState();
    _loadMessages();
  }

  void _loadMessages() async {
    final fetchedMessages = await _chatController.getMessages(widget.chatId);
    setState(() {
      messages = fetchedMessages;
    });
  }

  void _sendMessage() async {
    if (_messageController.text.trim().isEmpty) return;

    await _chatController.sendMessage(
      chatId: widget.chatId,
      message: _messageController.text.trim(),
    );

    _messageController.clear();
    _loadMessages();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Chat")),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final message = messages[index];
                return ListTile(
                  title: Text(message['text']),
                  subtitle: Text(message['username']),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _messageController,
              decoration: InputDecoration(
                hintText: 'Escribe un mensaje...',
                suffixIcon: IconButton(
                  icon: Icon(Icons.send),
                  onPressed: _sendMessage,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}