import 'package:flutter/material.dart';
import '../../controllers/profile_controller.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class EditProfileScreen extends StatefulWidget {
  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final ProfileController _profileController = ProfileController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  File? _profileImage;

  void _pickImage() async {
    final pickedFile =
    await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _profileImage = File(pickedFile.path);
      });
    }
  }

  void _saveProfile() async {
    String? profilePicUrl;
    if (_profileImage != null) {
      profilePicUrl = await _profileController.uploadProfileImage(_profileImage!);
    }

    await _profileController.updateUserProfile(
      username: _usernameController.text,
      bio: _bioController.text,
      phone: _phoneController.text,
      profilePic: profilePicUrl,
    );

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Editar Perfil")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            GestureDetector(
              onTap: _pickImage,
              child: CircleAvatar(
                radius: 50,
                backgroundImage: _profileImage != null
                    ? FileImage(_profileImage!)
                    : AssetImage('assets/default_profile.png') as ImageProvider,
                child: Icon(Icons.edit, size: 30),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(labelText: "Nombre de Usuario"),
            ),
            TextField(
              controller: _bioController,
              decoration: InputDecoration(labelText: "Biografía"),
            ),
            TextField(
              controller: _phoneController,
              decoration: InputDecoration(labelText: "Teléfono"),
              keyboardType: TextInputType.phone,
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _saveProfile,
              child: Text("Guardar Cambios"),
            ),
          ],
        ),
      ),
    );
  }
}