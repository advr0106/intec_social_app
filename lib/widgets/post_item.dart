import 'package:flutter/material.dart';

class PostItem extends StatelessWidget {
  final Map<String, dynamic> postData;

  const PostItem({required this.postData});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            leading: CircleAvatar(
              backgroundImage: postData['userProfilePic'] != null
                  ? NetworkImage(postData['userProfilePic'])
                  : AssetImage('assets/default_profile.png') as ImageProvider,
            ),
            title: Text(postData['username'] ?? 'Usuario'),
            subtitle: Text(postData['timestamp']),
          ),
          postData['mediaUrl'] != null
              ? Image.network(postData['mediaUrl'])
              : Container(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(postData['caption'] ?? ''),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: Icon(Icons.favorite_border),
                onPressed: () {
                  // Agregar funcionalidad para dar like
                },
              ),
              IconButton(
                icon: Icon(Icons.comment),
                onPressed: () {
                  Navigator.pushNamed(context, '/comments', arguments: postData);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
