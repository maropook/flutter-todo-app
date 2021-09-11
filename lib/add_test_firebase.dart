import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

//import 'dart:async';(不要になりました)

// ignore: non_constant_identifier_names

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); //←Firebaseを初期化する際に必要らしい
  await Firebase.initializeApp(); //←Firebaseを初期化
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'テストアプリ',
      home: MainScreen(),
    );
  }
}

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('sample'),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.indigo,
        onPressed: () {},
        child: IconButton(
          icon: Icon(Icons.add),
          color: Colors.white,
          onPressed: () {
            print("test");
            FirebaseFirestore.instance.collection('sample').add(
              {'name': 'test'},
            );
          },
        ),
      ),
    );
  }
}
