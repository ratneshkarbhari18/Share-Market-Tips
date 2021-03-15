import 'package:flutter/material.dart';
import './screens/Home.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import './utils/Constants.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Constants.prefs = await SharedPreferences.getInstance();
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Share Market Tips',
    theme: ThemeData(
      primarySwatch: Colors.indigo,
      visualDensity: VisualDensity.adaptivePlatformDensity,
    ),
    home: Home(),
  ));
}