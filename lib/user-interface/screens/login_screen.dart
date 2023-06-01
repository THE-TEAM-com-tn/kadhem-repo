import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:theteam_gyp/admin-interface/AdminDashboardPage.dart';
import 'package:theteam_gyp/admin-interface/register_page.dart';
import 'package:theteam_gyp/admin-interface/welcome_screen.dart';
import 'package:theteam_gyp/user-interface/constans/assets_path.dart';
import 'package:theteam_gyp/user-interface/screens/welcome_screen.dart';
import '../components/my_button.dart';
import '../components/my_textfield.dart';
import 'forgot_pwd_screen.dart';
import 'package:flutter/services.dart';

class LoginPage extends StatefulWidget {
  final Function()? onTap;

  const LoginPage({super.key, this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // text editing controllers

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  // final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;

// Press Enter to Login :
  final FocusNode _focusNode = FocusNode();

// Sing in Validator Key :
  final _formKey = GlobalKey<FormState>();

// //  Sign in Anonymously - Start //

//   void signInAnonymously() async {
//     // show a loading circle while the user logs in
//     showDialog(
//       context: context,
//       builder: (context) {
//         return const Center(
//           child: CircularProgressIndicator(),
//         );
//       },
//     );

//     // Sign in anonymously
//     try {
//       await FirebaseAuth.instance.signInAnonymously();
//     } on FirebaseAuthException catch (e) {
//       // hide the loading circle
//       Navigator.pop(context);

//       // show error to user
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text(e.message ?? 'An unknown error occurred.'),
//           duration: const Duration(seconds: 3),
//           backgroundColor: Colors.redAccent,
//         ),
//       );
//     }

//     // hide the loading circle
//     Navigator.pop(context);
//   }

// //  Sign in Anonymously - End  //

  void showValidationMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 3),
        backgroundColor: Colors.redAccent,
      ),
    );
  }

//  Sign in Exceptions & Validators - Start //

  bool isValidEmail(String email) {
    final RegExp emailRegex = RegExp(
      r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$",
    );
    return emailRegex.hasMatch(email);
  }

  void networkIssueMessage() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Network issue, please check your internet connection'),
        duration: Duration(seconds: 3),
        backgroundColor: Colors.purpleAccent,
      ),
    );
  }

  /* General exceptions: For other unknown or unexpected exceptions, you can show a generic error message.  */

  void generalErrorMessage() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('An error occurred, please try again later'),
        duration: Duration(seconds: 3),
        backgroundColor: Colors.redAccent,
      ),
    );
  }

  void wrongEmailMessage() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Incorrect Email'),
        duration: Duration(seconds: 3),
        backgroundColor: Colors.redAccent,
      ),
    );
  }

  void wrongPasswordMessage() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Incorrect Password'),
        duration: Duration(seconds: 3),
        backgroundColor: Colors.redAccent,
      ),
    );
  }

//////////////////////////// Sign in Exceptions & Validators - - End /////////////////////////////

//////////////////////////// sign user in method - Start /////////////////////////////

  // void signUserIn() async {
  //   try {
  //     UserCredential userCredential = await _auth.signInWithEmailAndPassword(
  //       email: _emailController.text.trim(),
  //       password: _passwordController.text.trim(),
  //     );
  //     // User is logged in
  //     // You can access the logged-in user details using userCredential.user
  //     print('User logged in: ${userCredential.user!.uid}');

  //     String userId = userCredential.user!.uid;

  //     DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
  //         .collection('Users')
  //         .doc(userId)
  //         .get();

  //     var role = (userSnapshot.data() as Map<String, dynamic>)['role'];

  //     if (role.toString() == "admin") {
  //       print(
  //           "##### ROLE-LOG ::: login_screen => signUserIn() ::: Logged in as $role");
  //       Navigator.pushReplacement(
  //         context,
  //         MaterialPageRoute(
  //             builder: (context) => DashboardAdminSummaryWidget()),
  //       );
  //     } else {
  //       print(
  //           "##### ROLE-LOG ::: login_screen => signUserIn() ::: Logged in as $role");
  //       Navigator.pushReplacement(
  //         context,
  //         MaterialPageRoute(builder: (context) => WelcomeScreen()),
  //       );
  //     }
  //   } catch (e) {
  //     // Login failed
  //     print('Login error: $e');
  //   }
  // }

  void signUserIn() async {
    late UserCredential userCredential;
    if (!_formKey.currentState!.validate()) {
      return;
    }

    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );

    try {
      userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      String userId = userCredential.user!.uid;

      DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
          .collection('profiles')
          .doc(userId)
          .get();

      var role = (userSnapshot.data() as Map<String, dynamic>)['role'];

      if (role.toString() == "admin") {
        print(
            "##### ROLE-LOG ::: login_screen => signUserIn() ::: Logged in as $role");
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => DashboardAdminSummaryWidget()),
        );
      } else {
        print(
            "##### ROLE-LOG ::: login_screen => signUserIn() ::: Logged in as $role");
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => WelcomeScreen()),
        );
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        wrongEmailMessage();
      } else if (e.code == 'wrong-password') {
        wrongPasswordMessage();
      } else {
        generalErrorMessage();
      }
    } catch (e) {
      // Handle network-related or other general exceptions
      networkIssueMessage();
      return;
    }
  }

//////////////////////////// Sign in with Google - Start /////////////////////////////

//////////////////////////// Login Page UI - Start /////////////////////////////

  @override
  Widget build(BuildContext context) {
    print("##### Loaded ::: LoginPage ::: Widget");
    return Scaffold(
      // backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(300, 0, 300, 0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 50),
                  // stack the logo image over the rest of the content
                  Stack(
                    children: [
                      // logo
                      Positioned(
                        right: 5,
                        child: Image.asset(
                          ImageRasterPath.companyLogo,
                          height: 40,
                        ),
                      ),
                      // the rest of the content

                      Column(
                        children: [
                          /*       const SizedBox(height: 50),
            
                          // Load a Lottie file from your assets
                          Lottie.asset(
                            'lib/images/lottie_pc_logo.json',
                            height: 150,
                            width: 150,
                          ),
                          */
                          const SizedBox(height: 50),

                          // Lottie.asset(
                          //   'lib/images/login-page-lock-lottie-anim.json',
                          //   height: 150,
                          //   width: 150,
                          //   repeat: true,
                          // ),

                          const SizedBox(height: 50),
                          // welcome back, you've been missed!

                          Text(
                            'Welcome back you\'ve been missed!',
                            style: TextStyle(
                              // color: Colors.grey[700],
                              fontSize: 16,
                            ),
                          ),

                          const SizedBox(height: 25),

                          // Email TextField
                          Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                // Email Field
                                MyTextField(
                                  validator: (value) {
                                    if (!isValidEmail(value!)) {
                                      return 'Please enter a valid email';
                                    }
                                    return null;
                                  },
                                  controller: _emailController,
                                  hintText: 'Email: admin@gmail.com',
                                  obscureText: false,
                                ),

                                const SizedBox(height: 10),

                                // Password Field
                                MyTextField(
                                  controller: _passwordController,
                                  hintText: 'Password: admin123',
                                  obscureText: true,
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(height: 10),

                          // forgot password?
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 25.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) {
                                          return const ForgotPasswordPage();
                                        },
                                      ),
                                    );
                                  },
                                  child: const Text(
                                    'Forgot Password?',
                                    style: TextStyle(
                                      // color: Colors.blue,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(height: 25),
                          // sign in button

                          RawKeyboardListener(
                            focusNode: _focusNode,
                            onKey: (RawKeyEvent event) {
                              if (event
                                  .isKeyPressed(LogicalKeyboardKey.enter)) {
                                signUserIn();
                              }
                            },
                            child: MyButton(
                              text: "Sign in",
                              onTap: signUserIn,
                            ),
                          ),

                          // const SizedBox(height: 50),
                          // or continue with

                          // Padding(
                          //   padding: const EdgeInsets.symmetric(horizontal: 25.0),
                          //   child: Row(
                          //     children: [
                          //       Expanded(
                          //         child: Divider(
                          //           thickness: 0.5,
                          //           color: Colors.grey[400],
                          //         ),
                          //       ),
                          //       Padding(
                          //         padding: const EdgeInsets.symmetric(
                          //             horizontal: 10.0),
                          //         child: Text(
                          //           'Or continue with',
                          //           style: TextStyle(color: Colors.grey[700]),
                          //         ),
                          //       ),
                          //       Expanded(
                          //         child: Divider(
                          //           thickness: 0.5,
                          //           color: Colors.grey[400],
                          //         ),
                          //       ),
                          //     ],
                          //   ),
                          // ),

                          // const SizedBox(height: 50),

                          // // google + apple sign in buttons
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.center,
                          //   children: [
                          //     // google button

                          //     SquareTile(
                          //       imagePath: 'lib/images/google.png',
                          //       onTap: () async {
                          //         try {
                          //           await GoogleAuthService().signInWithGoogle();
                          //           // Navigate to the next page, or show a success message as needed
                          //         } catch (eg) {
                          //           // Handle any errors or exceptions
                          //           print('Error signing in with Google: $eg');
                          //         }
                          //       },
                          //     ),

                          //     const SizedBox(width: 15),

                          //     // apple button
                          //     SquareTile(
                          //         imagePath: 'lib/images/apple.png',
                          //         onTap: () {}),

                          //     const SizedBox(width: 15),
                          //     // facebook button
                          //     SquareTile(
                          //         imagePath: 'lib/images/facebook.png',
                          //         onTap: () {}),
                          //   ],
                          // ),

                          // const SizedBox(height: 30),

                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.center,
                          //   children: [
                          //     const SizedBox(width: 15),
                          //     // Linkedin button
                          //     SquareTile(
                          //         imagePath: 'lib/images/linkedin.png',
                          //         onTap: () {}),

                          //     const SizedBox(width: 15),
                          //     // anonymous button

                          //     // SquareTile(
                          //     //   imagePath: 'lib/images/anonymous.png',
                          //     //   onTap: signInAnonymously,
                          //     // )
                          //   ],
                          // ),

                          // const SizedBox(height: 30),

                          // not a member? register now
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Not a member?',
                                // style: TextStyle(color: Colors.grey[700]),
                              ),
                              const SizedBox(width: 4),
                              GestureDetector(
                                onTap: () {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => RegisterPage(
                                              onTap: () {
                                                Navigator.pushReplacement(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          LoginPage()),
                                                );
                                              },
                                            )),
                                  );
                                },
                                child: const Text(
                                  'Register now',
                                  style: TextStyle(
                                    // color: Colors.blue,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 30),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
