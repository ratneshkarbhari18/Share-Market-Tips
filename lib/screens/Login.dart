import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../utils/Constants.dart';
import 'dart:convert';
import './Home.dart';


class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

  final emailController = new TextEditingController();
  final passwordController = new TextEditingController();
  var loginError = "";
  var hidePwd = true;
  var visibilityIcon = Icons.visibility;

  showHidePwd(){
    setState(() {
      if(hidePwd==true){
        visibilityIcon = Icons.visibility_off;
        hidePwd=false;
      }else{
        visibilityIcon = Icons.visibility;
        hidePwd=true;
      }
    });
  }

  Future loginExe() async{
    var prefs = await SharedPreferences.getInstance();
    var emailEntered = emailController.text;
    var passwordEntered = passwordController.text;
    if(emailEntered==""||passwordEntered==""){
      setState(() {
        loginError = "Please Enter both Email and Password";
      });
    }else{
      setState(() {
        loginError = "";
      });
      var url = Constants.apiUrl+'subscriber-login-api';
      var response = await http.post(url, body: {'api_key': '5f4dbf2e5629d8cc19e7d51874266678', 'email': emailEntered, 'password': passwordEntered});
      if(response.statusCode==200){
        var responseBody = jsonDecode(response.body);
        if(responseBody["result"]=="failure"){
          setState(() {
            loginError = responseBody["reason"];
          });
        }else{
          var subData = responseBody["sub_data"];
          var subDataObj = jsonDecode(subData);
          prefs.setBool("logged_in", true);
          prefs.setString("first_name", subDataObj["first_name"]);
          prefs.setString("last_name", subDataObj["last_name"]);
          prefs.setString("email", subDataObj["email"]);
          Navigator.push(context, MaterialPageRoute(builder: (context)=>Home()));
        }
      }else{
        setState(() {
          loginError = "Cannot connect to server, check your internet";
        });
      }
    }
  }



  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
                children: [
              Image.asset("assets/images/insider_logo.jpeg"),
              Text(loginError,style: TextStyle(color: Colors.red, fontSize: 16.0)),
              SizedBox(height: 20.0,),
              TextField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                    labelText: "Email",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(4.0)),
                    )),
              ),
              SizedBox(
                height: 20.0,
              ),
              TextField(
                obscureText: hidePwd,
                controller: passwordController,
                keyboardType: TextInputType.visiblePassword,
                decoration: InputDecoration(
                    suffixIcon: IconButton(
                      icon: Icon(visibilityIcon),
                      onPressed: showHidePwd,
                    ),
                    labelText: "Password",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(4.0)),
                    )),
              ),
              SizedBox(
                height: 20.0,
              ),
              MaterialButton(
                height: 50.0,
                minWidth: double.maxFinite,
                onPressed: loginExe,
                color: Colors.indigo,
                child: Text("LOGIN",style: TextStyle(color: Colors.white,fontSize: 16.0)),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
              ),
              
              ],
            ),
          ),
        ),
      ),
    );
  }
}