import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../admin-interface/my_button.dart';
import '../admin-interface/my_textfield.dart';

class RegisterPage extends StatefulWidget {
  final Function()? onTap;

  const RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool lower = false,
      upper = false,
      symbol = false,
      length = false,
      number = false;
  // text editing controllers

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _ageController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

// I used dispose() with these !!!

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose(); // Add this line
    _confirmPasswordController.dispose();
    _ageController.dispose();
    super.dispose();
  }

  String? emailValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter an email';
    }
    if (!RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(value)) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  String? passwordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a password';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters long';
    }
    if (!RegExp(r'(?=.*[A-Z])').hasMatch(value)) {
      return 'Password must contain at least one uppercase letter';
    }
    if (!RegExp(r'(?=.*[a-z])').hasMatch(value)) {
      return 'Password must contain at least one lowercase letter';
    }
    if (!RegExp(r'(?=.*\d)').hasMatch(value)) {
      return 'Password must contain at least one digit';
    }
    if (!RegExp(r'(?=.*[\W_])').hasMatch(value)) {
      return 'Password must contain at least one special character (e.g., !@#\$%\^&\*)';
    }
    return null;
  }

  void signUserUp() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (_passwordController.text.trim() !=
        _confirmPasswordController.text.trim()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Passwords do not match.'),
          duration: const Duration(seconds: 3),
          backgroundColor: Colors.redAccent,
        ),
      );
      return;
    }

    try {
      // Create User
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: _emailController.text.trim(),
              password: _passwordController.text.trim());

      // add user Details
      addUserDetails(
          _firstNameController.text.trim(),
          _lastNameController.text.trim(),
          _emailController.text.trim(),
          _passwordController.text.trim(),
          int.parse(
            _ageController.text.trim(),
          ),
          userCredential.user!.uid);

      User? user = userCredential.user;
      await user?.sendEmailVerification(); // This sends the verification email
      print('Verification email sent to ${user?.email}');
    } on FirebaseAuthException catch (e) {
      signUserUpErrorMessages(e, context);
    } catch (e) {
      print(e);
    }
  } // Move the closing brace here

  Future addUserDetails(String firstName, String lastName, String email,
      String password, int age, String id) async {
    /* await FirebaseFirestore.instance.collection('users').add({
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'age': age,
    });*/
    await FirebaseFirestore.instance.collection('Users').doc(id).set({
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'age': age,
      'password': password,
      'role': 'user'
    });
  }

  void signUserUpErrorMessages(FirebaseAuthException e, BuildContext context) {
    String errorMessage = '';

    if (e.code == 'weak-password') {
      errorMessage = 'The password provided is too weak.';
    } else if (e.code == 'email-already-in-use') {
      errorMessage = 'The account already exists for that email.';
    } else if (e.code == 'invalid-email') {
      errorMessage = 'The email address is not valid.';
    } else if (e.code == 'user-not-found') {
      errorMessage = 'No user found for that email.';
    } else if (e.code == 'wrong-password') {
      errorMessage = 'Wrong password provided for that user.';
    } else if (e.code == 'user-disabled') {
      errorMessage = 'The user account has been disabled.';
    } else {
      errorMessage = 'An undefined error happened.';
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(errorMessage),
        duration: const Duration(seconds: 3),
        backgroundColor: Colors.redAccent,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // stack the logo image over the rest of the content
                Stack(
                  children: [
                    // logo

                    // the rest of the content

                    Column(
                      children: [
                        const SizedBox(height: 25),
                        Image.asset(
                          'lib/images/theteamlogo.png',
                          height: 150,
                        ),

                        /*   const Icon(
                          Icons.account_box_rounded,
                          size: 100,
                        ),*/

                        const SizedBox(height: 25),

                        // welcome back, you've been missed!
                        Text(
                          'Let\'s create an account for you!',
                          style: TextStyle(
                            color: Colors.grey[700],
                            fontSize: 16,
                          ),
                        ),

                        Card(
                          elevation: 5,
                          shadowColor: Colors.black,
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.75,
                            child: Column(
                              children: [
                                const SizedBox(height: 25),
                                Form(
                                  key: _formKey,
                                  child: Column(
                                    children: [
                                      // email textfield
                                      MyTextField(
                                        validator: emailValidator,
                                        controller: _emailController,
                                        hintText: 'Email',
                                        obscureText: false,
                                      ),

                                      const SizedBox(height: 10),

                                      // first name textfield
                                      MyTextField(
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Please enter your first name';
                                          }
                                          return null;
                                        },
                                        controller: _firstNameController,
                                        hintText: 'First Name',
                                        obscureText: false,
                                      ),

                                      const SizedBox(height: 10),

                                      // last name textfield
                                      MyTextField(
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Please enter your last name';
                                          }
                                          return null;
                                        },
                                        controller: _lastNameController,
                                        hintText: 'Last Name',
                                        obscureText: false,
                                      ),

                                      const SizedBox(height: 10),

                                      // age textfield
                                      MyTextField(
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Please enter your age';
                                          }
                                          if (int.tryParse(value) == null) {
                                            return 'Please enter a valid age';
                                          }
                                          int age = int.parse(value);
                                          if (age < 0 || age > 150) {
                                            return 'Please enter a valid age';
                                          }
                                          return null;
                                        },
                                        controller: _ageController,
                                        hintText: 'Date of birth',
                                        obscureText: false,
                                        keyboardType: TextInputType.number,
                                      ),

                                      const SizedBox(height: 10),

                                      // password textfield
                                      MyTextField(
                                        onchanged: (value) {
                                          verifyRequirements(value);
                                        },
                                        validator: passwordValidator,
                                        controller: _passwordController,
                                        hintText: 'Password',
                                        obscureText: true,
                                      ),

                                      const SizedBox(height: 10),

                                      // confirm password textfield
                                      MyTextField(
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Please confirm your password';
                                          }
                                          if (value !=
                                              _passwordController.text.trim()) {
                                            return 'Passwords do not match';
                                          }
                                          return null;
                                        },
                                        controller: _confirmPasswordController,
                                        hintText: 'Confirm Password',
                                        obscureText: true,
                                      ),

                                      const SizedBox(height: 25),

                                      // sign in button
                                      MyButton(
                                        hoverColor: Colors.black87,
                                        color: Color(0xFF17282E),
                                        text: "Sign up",
                                        onTap: signUserUp,
                                      ),

                                      const SizedBox(height: 25),

                                      const SizedBox(height: 30),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        // Already a member? Sign in now / Login Now !
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Already a member?',
                              style: TextStyle(color: Colors.grey[700]),
                            ),
                            const SizedBox(width: 4),
                            GestureDetector(
                              onTap: widget.onTap,
                              child: const Text(
                                'Login now',
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  verifyRequirements(String value) {
    final upperCaseRegex = RegExp(r'[A-Z]');
    final lowerCaseRegex = RegExp(r'[a-z]');
    final numberRegex = RegExp(r'[0-9]');
    final symbolRegex = RegExp(r'[!@#\$&*~%]');
    value.length > 8
        ? setState(() {
            length = true;
          })
        : setState(() {
            length = false;
          });

    upperCaseRegex.hasMatch(value)
        ? setState(() {
            upper = true;
          })
        : setState(() {
            upper = false;
          });

    lowerCaseRegex.hasMatch(value)
        ? setState(() {
            lower = true;
          })
        : setState(() {
            lower = false;
          });

    numberRegex.hasMatch(value)
        ? setState(() {
            number = true;
          })
        : setState(() {
            number = false;
          });
    symbolRegex.hasMatch(value)
        ? setState(() {
            symbol = true;
          })
        : setState(() {
            symbol = false;
          });
  }
}
