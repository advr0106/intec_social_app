import 'package:flutter/material.dart';
import '../../controllers/post_controller.dart';
import '../comments/comments_screen.dart';

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

  void _toggleLike(String postId) async {
    await _postController.toggleLike(postId);
    _loadPosts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Feed")),
      body: ListView.builder(
        itemCount: posts.length,
        itemBuilder: (context, index) {
          final post = posts[index];
          return Card(
            margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(post['userProfilePic'] ?? ''),
                  ),
                  title: Text(post['username']),
                  subtitle: Text(post['timestamp']),
                ),
                Image.network(post['mediaUrl']),
                ButtonBar(
                  children: [
                    IconButton(
                      icon: Icon(Icons.thumb_up),
                      onPressed: () => _toggleLike(post['postId']),
                    ),
                    IconButton(
                      icon: Icon(Icons.comment),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CommentsScreen(postData: post),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
