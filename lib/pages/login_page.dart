import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:project5/pages/Chat_page.dart';
import 'package:project5/pages/Register_page.dart';
import 'package:project5/widget/Botton.dart';
import 'package:project5/widget/TextFeild.dart';

// ignore: must_be_immutable
class LoginPage extends StatefulWidget {
  LoginPage({super.key});
  static String id = 'LoginPage';

  @override
  State<LoginPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<LoginPage> {
  String? email;

  String? password;

  GlobalKey<FormState> formkey = GlobalKey();

  bool hud = false;

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: hud,
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 68, 214, 129),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: formkey,
            child: ListView(
              children: [
                const SizedBox(height: 50),
                Image.asset(
                  'assets/images/scholar.png',
                  width: 100,
                  height: 100,
                ),
                const Center(
                  child: Text(
                    'School Chat',
                    style: TextStyle(
                      fontSize: 28,
                      color: Colors.white,
                      fontFamily: 'Pacifico-Regular.ttf',
                    ),
                  ),
                ),
                const SizedBox(height: 100),
                const Row(
                  children: [
                    Text(
                      'Login',
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                Textfeild(
                  text_hind: 'Email',
                  text: 'Enter Your Email',
                  isPassword: false,
                  onChange: (data) {
                    email = data;
                  },
                ),
                const SizedBox(height: 10),
                Textfeild(
                  text_hind: 'Password',
                  text: 'Enter Your Password',
                  isPassword: true, // إضافة خاصية إخفاء كلمة المرور
                  onChange: (data) {
                    password = data;
                  },
                ),
                const SizedBox(height: 15),
                Botton(
                  nameBotton: 'Login',
                  onTap: () async {
                    if (formkey.currentState!.validate()) {
                      hud = true;
                      setState(() {});
                      try {
                        await Login_User();
                        Navigator.pushNamed(context, ChatPage.id);
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'weak-password') {
                          ShowThnakBar(context, 'weak password');
                        } else if (e.code == 'emali-already-in-use') {
                          ShowThnakBar(context, 'email already exists');
                        }
                      } catch (e) {
                        ShowThnakBar(context, 'there was a errors');
                      }
                      hud = false;
                      setState(() {});
                    }
                  },
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Don\'t have an account?',
                      style: TextStyle(color: Colors.white),
                    ),
                    GestureDetector(
                      onTap: () {
                        // Navigator.pushNamed(context, RegisterPage.id);
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return RegisterPage();
                        }));
                      },
                      child: const Text(
                        'Register',
                        style: TextStyle(color: Colors.white),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

// function for print errors
  void ShowThnakBar(BuildContext context, String text_error) {
    String? text_error;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$text_error '),
      ),
    );
  }

// function for get emial and password
  Future<void> Login_User() async {
    var auth = FirebaseAuth.instance;
    UserCredential user = await auth.createUserWithEmailAndPassword(
      email: email!,
      password: password!,
    );
    print(user.user!.displayName);
  }
}
