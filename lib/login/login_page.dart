// ignore_for_file: unused_local_variable, unused_field

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart ';
import 'package:wato/adminlogin.dart';
import 'package:wato/home/explore.dart';
import 'package:wato/register/register_Page.dart';
import 'package:wato/lecturer_register/login.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(children: [
          Container(
            width: size.width,
            height: size.height * 0.4,
            decoration: const BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(50),
                  bottomRight: Radius.circular(50)),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircleAvatar(
                      foregroundImage: AssetImage("assets/logo.jpg"),
                      maxRadius: 40,
                      minRadius: 40,
                    ),
                    SizedBox(width: 10),
                    Text(
                      'Wato',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 70,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: size.height * 0.02,
                ),
                const Text("if you don’t have an account yet",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    )),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const RegisterPage(),
                      ),
                    );
                  },
                  child: const Text('Sign Up As A Student'),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Login(),
                      ),
                    );
                  },
                  child: const Text('Lecturer Page'),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Adminlogin(),
                      ),
                    );
                  },
                  child: const Text('ADMIN'),
                ),
              ],
            ),
          ),
          SizedBox(
            height: size.height * 0.05,
          ),
          const Text("Already have an account?",
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              )),
          SizedBox(
            height: size.height * 0.02,
          ),
          TextFormField(
            controller: _emailController,
            decoration: const InputDecoration(
              hintText: 'Email',
              prefixIcon: Icon(Icons.email),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
            ),
          ),
          SizedBox(
            height: size.height * 0.02,
          ),
          TextFormField(
            controller: _passwordController,
            decoration: const InputDecoration(
              hintText: 'Password',
              prefixIcon: Icon(Icons.lock),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
            ),
          ),
          SizedBox(
            height: size.height * 0.04,
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              maximumSize: Size(size.width * 0.5, size.height * 0.07),
              minimumSize: Size(size.width * 0.5, size.height * 0.07),
              backgroundColor: Colors.green,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
            ),
            onPressed: () {
              login(context, _emailController.text, _passwordController.text);
            },
            child: const Text('Login'),
          ),

        ],
        ),
      ) // Column
          ), // SafeArea
    );
  }

  Future<void> login(
      BuildContext context, String email, String password) async {
    try {
      // Show circular progress indicator while logging in
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return const Center(child: CircularProgressIndicator());
        },
      );
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('email', isEqualTo: email)
          .limit(1)
          .get();

      if (querySnapshot.docs.isEmpty) {
        // Remove the progress indicator
        Navigator.pop(context);
        _showErrorSnackBar(context, 'User not found only students can login here');
        return;
      }
      // Sign in the user with Firebase Authentication
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Get the user document reference
      DocumentReference userDocRef = querySnapshot.docs.first.reference;

      // Get the current timestamp
      Timestamp timestamp = Timestamp.now();

      // Update the loginTimes subcollection in the user document
      await userDocRef.collection('loginTimes').add({
        'timestamp': timestamp,
      });

      // Remove the progress indicator
      Navigator.pop(context);

      // Navigate to the home page
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const ExplorePage()),
      );
    } on FirebaseAuthException catch (e) {
      // Remove the progress indicator
      Navigator.pop(context);

      // Show error message to the user
      if (e.code == 'user-not-found') {
        _showErrorSnackBar(context, 'User not found');
      } else if (e.code == 'wrong-password') {
        _showErrorSnackBar(context, 'Wrong password');
      } else {
        _showErrorSnackBar(
            context, 'An error occurred. Please try again later.');
      }
    }
  }

  void _showErrorSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(
      content: Text(message),
      backgroundColor: Colors.red,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
