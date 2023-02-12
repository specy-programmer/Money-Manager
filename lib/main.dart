import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:money_manager/pages/home_page.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FutureBuilder(
        future: _initialization,
        builder: (context, snapshot){
          if (snapshot.hasError){
            return Center(child: Text('Beklenmeyen hata'));
          } else if (snapshot.hasData){
            return HomePage();
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      )
    //RootApp(),
  ));
}

