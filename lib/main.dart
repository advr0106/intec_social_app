import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:intec_social_app/views/screens/auth/login_screen.dart';
import 'firebase_options.dart';
import 'screens/home/feed_screen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(IntecSocialApp());
}

class IntecSocialApp extends StatelessWidget {
  @override

  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Instagram Clone',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
      ),
      initialRoute: '/login',
      routes: {
        '/login': (context) => LoginScreen(),
        '/home': (context) => FeedScreen(),
      },
    );
  }
}