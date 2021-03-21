import 'package:flutter/material.dart';
import 'package:share_market_tips/screens/Login.dart';
import './screens/Home.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var prefs = await SharedPreferences.getInstance();

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Share Market Tips',
    theme: ThemeData( 
      primarySwatch: Colors.indigo,
      visualDensity: VisualDensity.adaptivePlatformDensity, 
    ),
    home: prefs.getBool("logged_in")==true?Home():Login()
  ));
}