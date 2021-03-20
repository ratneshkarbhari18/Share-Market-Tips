import 'package:flutter/material.dart';
import '../screens/Notifications.dart';
import '../screens/TnC.dart';
import '../screens/Contact.dart';

class DrawerTemplate extends StatelessWidget {

  final firstName;
  final lastName;
  final email;

  DrawerTemplate(this.firstName,this.lastName,this.email);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(this.firstName+" "+this.lastName),
            accountEmail: Text(this.email),
          ),
          
          
          ListTile(
            title: Text("Notifications"),
            onTap: (){
              Navigator.push(context,MaterialPageRoute(builder: (context)=> Notifications()));
            },
          ),
          ListTile(
            title: Text("Contact"),
            onTap: (){
              Navigator.push(context,MaterialPageRoute(builder: (context)=> Contact()));
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
