// Adapted from https://github.com/FirebaseExtended/flutterfire/tree/master/packages/firebase_auth/firebase_auth/example

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: SizedBox(
              width: 400,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(user.email ?? 'email'),
                  const SizedBox(height: 20),
                  TextButton(
                    onPressed: _signOut,
                    child: const Text('Sign out'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Example code for sign out.
  Future<void> _signOut() async {
    await FirebaseAuth.instance.signOut();
  }
}
