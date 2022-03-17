import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
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
        body: Container(),
      ),
    );
  }
}
