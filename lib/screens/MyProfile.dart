import 'package:flutter/material.dart';

class MyProfile extends StatefulWidget {
  @override
  _MyProfileState createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {

  final firstNameController = new TextEditingController();
  final lastNameController = new TextEditingController();
  final emailController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          TextField(
            controller: firstNameController,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              labelText: "First Name",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(4.0)),
              )
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          TextField(
            controller: lastNameController,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              labelText: "Last Name",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(4.0)),
              )
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          TextField(
            controller: emailController,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              labelText: "Email",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(4.0)),
              )
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          MaterialButton(
            height: 50.0,
            minWidth: double.maxFinite,
            onPressed: () {},
            color: Colors.indigo,
            child: Text("UPDATE PROFILE",style: TextStyle(color: Colors.white,fontSize: 16.0)),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          ),
        ],
      ),
    );
  }
}