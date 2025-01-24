import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intec_social_app/views/screens/auth/login_screen.dart';

class HomeScreen extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Método para cerrar sesión
  Future<void> signOut(BuildContext context) async {
    await _auth.signOut();
    Fluttertoast.showToast(msg: "Has cerrado sesión");
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    User? user = _auth.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: Text("Bienvenido ${user?.email ?? 'Usuario'}"),
        actions: [
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () => signOut(context),
          ),
        ],
      ),
      body: Center(
        child: Text(
          '¡Bienvenido a tu inicio de sesión, ${user?.email ?? 'Usuario'}!',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
