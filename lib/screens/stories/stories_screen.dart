import 'package:flutter/material.dart';
import '../../controllers/stories_controller.dart';

class StoriesScreen extends StatefulWidget {
  @override
  _StoriesScreenState createState() => _StoriesScreenState();
}

class _StoriesScreenState extends State<StoriesScreen> {
  final StoriesController _storiesController = StoriesController();
  List<Map<String, dynamic>> stories = [];

  @override
  void initState() {
    super.initState();
    _loadStories();
  }

  void _loadStories() async {
    final fetchedStories = await _storiesController.getStories();
    setState(() {
      stories = fetchedStories;
    });
  }

  void _addStory() async {
    await _storiesController.createStory();
    _loadStories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Historias")),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: _addStory,
            child: Text("Agregar Historia"),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: stories.length,
              itemBuilder: (context, index) {
                final story = stories[index];
                return ListTile(
                  title: Text(story['username']),
                  subtitle: Text(story['timestamp']),
                  trailing: Icon(Icons.play_circle_outline),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
