import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:project5/firebase_options.dart';
import 'package:project5/pages/Chat_page.dart';
import 'package:project5/pages/Register_page.dart';
import 'package:project5/pages/login_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(HomePage());
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        LoginPage.id: (context) => LoginPage(),
        RegisterPage.id: (context) => RegisterPage(),
        ChatPage.id: (context) => ChatPage(),
      },
      home: LoginPage(),
      initialRoute: LoginPage.id,
    );
  }
}
