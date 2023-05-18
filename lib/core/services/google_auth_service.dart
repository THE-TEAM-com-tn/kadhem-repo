import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../models/user_model.dart';

class GoogleAuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Google Sign in
  Future<UserModel?> signInWithGoogle() async {
    // Begin interactive Sign-in Process
    final GoogleSignIn googleSignIn = GoogleSignIn(scopes: [
      'https://www.googleapis.com/auth/userinfo.email',
      'https://www.googleapis.com/auth/userinfo.profile',
      'https://www.googleapis.com/auth/photoslibrary.readonly',
    ]);

    final GoogleSignInAccount? gUser = await googleSignIn.signIn();

    // Obtain Auth Details From the request
    final GoogleSignInAuthentication gAuth = await gUser!.authentication;

    // Create New Credential for the user
    final OAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: gAuth.accessToken,
      idToken: gAuth.idToken,
    );

    final UserCredential userCredential =
        await _auth.signInWithCredential(credential);
    final User? user = userCredential.user;
    if (user == null) return null;

    // Check if the user already exists in Firestore
    final existingUserSnapshot =
        await _firestore.collection('Users').doc(user.uid).get();
    if (existingUserSnapshot.exists) {
      // User already exists, retrieve the existing data instead of overwriting it
      final userData = existingUserSnapshot.data();
      if (userData == null) return null;

      // Create UserModel instance using existing data
      final userModel = UserModel.fromMap(userData, user.uid);
      return userModel;
    } else {
      // User does not exist, save the user data to Firestore
      final userData = {
        'uid': user.uid,
        'email': user.email,
        'firstName': user.displayName,
        'profile_picture': user.photoURL,
        'signedWithGoogle': true, // Set the signedWithGoogle field to true
      };
      await _firestore.collection('Users').doc(user.uid).set(userData);

      // Create UserModel instance
      final userModel = UserModel(
        userId: user.uid,
        firstname: user.displayName ?? '',
        lastname: '',
        email: user.email ?? '',
        address: '',
        phoneNumber: user.phoneNumber ?? '',
        profilePicture: user.photoURL ??
            'https://cdn-icons-png.flaticon.com/512/3177/3177440.png',
        bio: '',
        company: '',
        role: 'user',
        birthDate: '',
        signedWithGoogle:
            true, // Set the signedWithGoogle field in the UserModel instance
      );

      return userModel;
    }
  }
}
