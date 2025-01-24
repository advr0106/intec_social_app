import 'package:flutter/material.dart';
import '../../controllers/comment_controller.dart';

class CommentsScreen extends StatefulWidget {
  final Map<String, dynamic> postData;

  const CommentsScreen({required this.postData});

  @override
  _CommentsScreenState createState() => _CommentsScreenState();
}

class _CommentsScreenState extends State<CommentsScreen> {
  final TextEditingController _commentController = TextEditingController();
  final CommentController _commentController = CommentController();
  List<Map<String, dynamic>> comments = [];

  @override
  void initState() {
    super.initState();
    _loadComments();
  }

  void _loadComments() async {
    final fetchedComments = await _commentController.getComments(widget.postData['postId']);
    setState(() {
      comments = fetchedComments;
    });
  }

  void _addComment() async {
    if (_commentController.value.trim().isEmpty) return;

    await _commentController.addComment(
      postId: widget.postData['postId'],
      comment: _commentController.text.trim(),
    );

    _commentController.clear();
    _loadComments();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Comentarios")),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: comments.length,
              itemBuilder: (context, index) {
                final comment = comments[index];
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(comment['userProfilePic'] ?? ''),
                  ),
                  title: Text(comment['username']),
                  subtitle: Text(comment['text']),
                  trailing: IconButton(
                    icon: Icon(Icons.thumb_up_alt),
                    onPressed: () {
                      // Funcionalidad para dar like a los comentarios
                    },
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _commentController,
              decoration: InputDecoration(
                hintText: 'Escribe un comentario...',
                suffixIcon: IconButton(
                  icon: Icon(Icons.send),
                  onPressed: _addComment,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
