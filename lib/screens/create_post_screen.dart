import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../controllers/post_controller.dart';

class CreatePostScreen extends StatefulWidget {
  @override
  _CreatePostScreenState createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  final TextEditingController _captionController = TextEditingController();
  final PostController _postController = PostController();
  XFile? _mediaFile;

  void _pickMedia() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _mediaFile = pickedFile;
      });
    }
  }

  void _createPost() async {
    if (_mediaFile == null || _captionController.text.trim().isEmpty) {
      // Mostrar un mensaje de error si faltan datos
      return;
    }

    // Aquí deberías subir el archivo a Firebase Storage y luego obtener su URL
    final mediaUrl = 'https://example.com/media.jpg'; // Cambiar por la URL real

    await _postController.createPost(
      userId: 'user123',  // Cambiar por el ID del usuario actual
      mediaUrl: mediaUrl,
      caption: _captionController.text.trim(),
    );

    // Navegar de vuelta al feed
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
            TextField(
              controller: _captionController,
              decoration: InputDecoration(hintText: "Escribe un pie de foto..."),
            ),
            SizedBox(height: 16),
            _mediaFile == null
                ? ElevatedButton(
              onPressed: _pickMedia,
              child: Text("Seleccionar Imagen o Video"),
            )
                : Image.file(File(_mediaFile!.path)),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _createPost,
              child: Text("Publicar"),
            ),
          ],
        ),
      ),
    );
  }
}
