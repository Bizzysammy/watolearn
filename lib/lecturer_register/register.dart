// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wato/lecturer_register/login.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  RegisterState createState() => RegisterState();
}

class RegisterState extends State<Register> {
  List<String> courses = ['Information Technology', 'LAW', 'Social Work', 'Business Administration'];
  String? selectedCourse;
  String? selectedCountryCode;
  List<String>? countryCodes;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _idNumberController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
  TextEditingController();

  @override
  void initState() {
    super.initState();
    countryCodes = [
      '+1',
      '+256',
      '+91',
      '+234',
      '+81',
      '+86',
      '+61',
      '+64',
      '+27',
    ];
    selectedCountryCode = countryCodes![1];
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(children: [
              Container(
                alignment: Alignment.topLeft,
                child: IconButton(
                  icon: const Icon(Icons.arrow_back),
                  color: Colors.green,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              const Text("Register",
                  style: TextStyle(
                    color: Colors.green,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  )),
              SizedBox(
                height: size.height * 0.02,
              ),
              SizedBox(
                width: size.width * 0.8,
                child: Column(
                  children: [
                    TextField(
                      controller: _nameController,
                      decoration: const InputDecoration(
                        hintText: "Name",
                        prefixIcon: Icon(Icons.person),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.02,
                    ),
                    TextField(
                      controller: _idNumberController,
                      decoration: const InputDecoration(
                        hintText: "ID Number",
                        prefixIcon: Icon(Icons.credit_card),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.02,
                    ),
                    DropdownButtonFormField<String>(
                      items: courses.map((String course) {
                        return DropdownMenuItem<String>(
                          value: course,
                          child: Text(course),
                        );
                      }).toList(),
                      onChanged: (String? value) {
                        setState(() {
                          selectedCourse = value;
                        });
                      },
                      value: selectedCourse,
                      decoration: const InputDecoration(
                        labelText: 'Select a course',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(30))),
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.02,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: size.width * 0.25,
                          child: DropdownButtonFormField<String>(
                            items: countryCodes?.map((String? countryCode) {
                              return DropdownMenuItem<String>(
                                value: countryCode,
                                child: Text(countryCode!),
                              );
                            }).toList(),
                            onChanged: (String? value) {
                              setState(() {
                                selectedCountryCode = value;
                              });
                            },
                            value: selectedCountryCode,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(30)),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: size.width * 0.02),
                        Expanded(
                          child: TextFormField(
                            controller: _phoneNumberController,
                            keyboardType: TextInputType.phone,
                            decoration: const InputDecoration(
                              labelText: 'Phone Number',
                              hintText: 'Enter your phone number',
                              prefixIcon: Icon(Icons.phone),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(30)),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: size.height * 0.02,
                    ),
                    TextField(
                      controller: _emailController,
                      decoration: const InputDecoration(
                        hintText: "Email",
                        prefixIcon: Icon(Icons.email),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.02,
                    ),
                    TextField(
                      controller: _passwordController,
                      decoration: const InputDecoration(
                        hintText: "Password",
                        prefixIcon: Icon(Icons.lock),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.02,
                    ),
                    TextField(
                      controller: _confirmPasswordController,
                      decoration: const InputDecoration(
                        hintText: "Confirm Password",
                        prefixIcon: Icon(Icons.lock),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30)),
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
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                      ),
                      onPressed: () {
                        register();
                      },
                      child: const Text(
                        "Sign Up",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.02,
                    ),
                  ],
                ),
              ),
            ]),
          ),
        ));
  }

  void register() async {
    // Get the values from the form fields
    String name = _nameController.text;
    String idNumber = _idNumberController.text;
    String phoneNumber = _phoneNumberController.text;
    String email = _emailController.text;
    String password = _passwordController.text;
    String confirmPassword = _confirmPasswordController.text;

    // Validate the form fields
    if (name.isEmpty) {
      _showErrorSnackBar('Name is required');
      return;
    }
    if (idNumber.isEmpty) {
      _showErrorSnackBar('id number is required');
      return;
    }
    if (selectedCourse == null) {
      _showErrorSnackBar('Please select a course');
      return;
    }
    if (phoneNumber.isEmpty) {
      _showErrorSnackBar('Phone number is required');
      return;
    }
    if (email.isEmpty) {
      _showErrorSnackBar('Email is required');
      return;
    }
    if (password.isEmpty) {
      _showErrorSnackBar('Password is required');
      return;
    }
    if (confirmPassword.isEmpty) {
      _showErrorSnackBar('Confirm password is required');
      return;
    }
    if (password != confirmPassword) {
      _showErrorSnackBar('Passwords do not match');
      return;
    }

    try {
      // Create a new user in Firebase Authentication
      UserCredential lecturerCredential =
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Save user data to Firebase Firestore
      FirebaseFirestore.instance
          .collection('lecturers')
          .doc(lecturerCredential.user!.uid)
          .set({
        'name': name,
        'idNumber': idNumber,
        'course': selectedCourse!,
        'phoneNumber': phoneNumber,
        'email': email,
      });

      // Navigate to the profile page
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const Login()),
      );
    } catch (e) {
      _showErrorSnackBar('Registration failed: $e');
    }
  }

  void _showErrorSnackBar(String message) {
    final snackBar = SnackBar(
      content: Text(message),
      backgroundColor: Colors.red,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
