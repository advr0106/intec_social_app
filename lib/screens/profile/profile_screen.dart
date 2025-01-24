import 'package:flutter/material.dart';
import '../../controllers/auth_controller.dart';
import '../../controllers/profile_controller.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final ProfileController _profileController = ProfileController();
  Map<String, dynamic>? userData;

  @override
  void initState() {
    super.initState();
    _loadUserProfile();
  }

  void _loadUserProfile() async {
    final data = await _profileController.getUserProfile();
    setState(() {
      userData = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Perfil"),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () async {
              await AuthController().logoutUser();
              Navigator.pushReplacementNamed(context, '/login');
            },
          )
        ],
      ),
      body: userData == null
          ? Center(child: CircularProgressIndicator())
          : Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: userData!['profilePic'] != null
                  ? NetworkImage(userData!['profilePic'])
                  : AssetImage('assets/default_profile.png')
              as ImageProvider,
            ),
            SizedBox(height: 16),
            Text(
              userData!['username'] ?? 'Sin nombre',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(userData!['bio'] ?? 'Sin biografía'),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/editProfile');
              },
              child: Text("Editar Perfil"),
            ),
          ],
        ),
      ),
    );
  }
}