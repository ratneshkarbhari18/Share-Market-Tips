import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../screens/Login.dart';



class AppBarTemplate extends StatelessWidget with PreferredSizeWidget {

  final title;
  AppBarTemplate(this.title);

  

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(this.title),
      actions: [
        IconButton(
          onPressed: ()async{
          var prefs = await SharedPreferences.getInstance();
          await prefs.clear();
          Navigator.push(context, MaterialPageRoute(builder: (context)=>Login()));
        },
          icon: Icon(Icons.logout),
        )
      ],
    );
  }
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
