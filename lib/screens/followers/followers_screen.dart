import 'package:flutter/material.dart';
import '../../controllers/follow_controller.dart';

class FollowersScreen extends StatefulWidget {
  @override
  _FollowersScreenState createState() => _FollowersScreenState();
}

class _FollowersScreenState extends State<FollowersScreen> {
  final FollowController _followController = FollowController();
  List<Map<String, dynamic>> followers = [];

  @override
  void initState() {
    super.initState();
    _loadFollowers();
  }

  void _loadFollowers() async {
    final fetchedFollowers = await _followController.getFollowers('user123');
    setState(() {
      followers = fetchedFollowers;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Seguidores")),
      body: ListView.builder(
        itemCount: followers.length,
        itemBuilder: (context, index) {
          final follower = followers[index];
          return ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(follower['profilePic'] ?? ''),
            ),
            title: Text(follower['username']),
          );
        },
      ),
    );
  }
}
