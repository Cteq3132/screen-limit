import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:screen_limit/auth.dart';
import 'package:screen_limit/profile.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ScreenLimitApp());
}

class ScreenLimitApp extends StatelessWidget {
  const ScreenLimitApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Screen Limit App',
      theme: ThemeData(primarySwatch: Colors.purple),
      home: Scaffold(
        body: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return const ProfilePage();
            }
            return const AuthGate();
          },
        ),
      ),
    );
  }
}
