import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import '../../controllers/post_controller.dart';

class PostScreen extends StatefulWidget {
  @override
  _PostScreenState createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  final TextEditingController _captionController = TextEditingController();
  final PostController _postController = PostController();
  File? _mediaFile;

  void _pickMedia() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _mediaFile = File(pickedFile.path);
      });
    }
  }

  void _uploadPost() async {
    if (_mediaFile == null || _captionController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Selecciona un archivo y escribe un título")),
      );
      return;
    }

    await _postController.createPost(
      mediaFile: _mediaFile!,
      caption: _captionController.text.trim(),
    );

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("¡Publicación subida!")),
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Crear Publicación")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            GestureDetector(
              onTap: _pickMedia,
              child: Container(
                width: double.infinity,
                height: 200,
                color: Colors.grey[300],
                child: _mediaFile != null
                    ? Image.file(_mediaFile!, fit: BoxFit.cover)
                    : Icon(Icons.add_a_photo, size: 50),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _captionController,
              decoration: InputDecoration(labelText: "Título o descripción"),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _uploadPost,
              child: Text("Subir Publicación"),
            ),
          ],
        ),
      ),
    );
  }
}