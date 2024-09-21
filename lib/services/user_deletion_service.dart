import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:futureme/auth/sign_in.dart';

class UserDeletionService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> deleteUserData(BuildContext context) async {
    try {
      User? currentUser = _auth.currentUser;
      if (currentUser == null) {
        throw Exception('No authenticated user found');
      }

      await _firestore.runTransaction((transaction) async {
        transaction.delete(_firestore.collection('users').doc(currentUser.uid));

        QuerySnapshot userPosts = await _firestore
            .collection('letters')
            .where('userId', isEqualTo: currentUser.uid)
            .get();

        for (var doc in userPosts.docs) {
          transaction.delete(doc.reference);
        }
      });

      print('User data deleted successfully');
    } catch (e) {
      print('Error deleting user data: $e');
      _showErrorDialog(
          context, 'Failed to delete user data. Please try again.');
      rethrow;
    }
  }

  Future<void> deleteAccount(BuildContext context) async {
    try {
      User? currentUser = _auth.currentUser;
      if (currentUser == null) {
        throw Exception('No authenticated user found');
      }

      bool isReauthenticated = await _reauthenticateUser(context);
      if (!isReauthenticated) {
        throw Exception('Re-authentication failed');
      }

      await deleteUserData(context);

      await currentUser.delete();

      print('User account deleted successfully');
      _showSuccessDialog(
          context, 'Your account has been successfully deleted.');
    } catch (e) {
      print('Error deleting user account: $e');
      _showErrorDialog(context, 'Failed to delete account. Please try again.');
    }
  }

  Future<bool> _reauthenticateUser(BuildContext context) async {
    try {
      User? user = _auth.currentUser;
      if (user == null) return false;

      String? password = await _promptForPassword(context);
      if (password == null) return false;

      AuthCredential credential = EmailAuthProvider.credential(
        email: user.email!,
        password: password,
      );

      await user.reauthenticateWithCredential(credential);
      return true;
    } catch (e) {
      print('Reauthentication error: $e');
      _showErrorDialog(context, 'Reauthentication failed. Please try again.');
      return false;
    }
  }

  Future<String?> _promptForPassword(BuildContext context) async {
    String? password;
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Confirm Password'),
          content: TextField(
            obscureText: true,
            onChanged: (value) {
              password = value;
            },
            decoration: InputDecoration(hintText: "Enter your password"),
          ),
          actions: [
            TextButton(
              child: Text('Cancel'),
              onPressed: () => Navigator.pop(context),
            ),
            TextButton(
              child: Text('Confirm'),
              onPressed: () => Navigator.pop(context, password),
            ),
          ],
        );
      },
    );
    return password;
  }

  void _showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text(message),
          actions: [
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _showSuccessDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Success'),
          content: Text(message),
          actions: [
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => SignInPage()));
              },
            ),
          ],
        );
      },
    );
  }
}
