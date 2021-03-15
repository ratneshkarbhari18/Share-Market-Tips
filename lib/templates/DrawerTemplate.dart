import 'package:flutter/material.dart';
import '../screens/Login.dart';
import '../screens/Home.dart';
import '../screens/Notifications.dart';
import '../screens/TnC.dart';
import '../screens/MyProfile.dart';


class DrawerTemplate extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            accountName: Text("Ratnesh Karbhari"),
            accountEmail: Text("ratneshkarbhari23@gmail.com"),
          ),
          ListTile(
            title: Text("Login"),
            onTap: (){
              Navigator.push(context,MaterialPageRoute(builder: (context)=> Login()));
            },
          ),
          ListTile(
            title: Text("MyProfile"),
            onTap: (){
              Navigator.push(context,MaterialPageRoute(builder: (context)=> MyProfile()));
            },
          ),
          ListTile(
            title: Text("Home"),
            onTap: (){
              Navigator.push(context,MaterialPageRoute(builder: (context)=> Home()));
            },
          ),
          ListTile(
            title: Text("Notifications"),
            onTap: (){
              Navigator.push(context,MaterialPageRoute(builder: (context)=> Notifications()));
            },
          ),
          ListTile(
            title: Text("Terms and Conditions"),
            onTap: (){
              Navigator.push(context,MaterialPageRoute(builder: (context)=> TnC()));
            },
          ),
        ],
      ),
    );
  }
}
