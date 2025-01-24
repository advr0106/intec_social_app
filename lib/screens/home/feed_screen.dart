import 'package:flutter/material.dart';
import '../../controllers/post_controller.dart';
import '../../widgets/post_item.dart';

class FeedScreen extends StatefulWidget {
  @override
  _FeedScreenState createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  final PostController _postController = PostController();
  List<Map<String, dynamic>> posts = [];

  @override
  void initState() {
    super.initState();
    _loadPosts();
  }

  void _loadPosts() async {
    final fetchedPosts = await _postController.getPosts();
    setState(() {
      posts = fetchedPosts;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Inicio")),
      body: posts.isEmpty
          ? Center(child: Text("No hay publicaciones todavía."))
          : ListView.builder(
        itemCount: posts.length,
        itemBuilder: (context, index) {
          return PostItem(postData: posts[index]);
        },
      ),
    );
  }
}