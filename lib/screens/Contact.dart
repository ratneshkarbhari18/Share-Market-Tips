import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../templates/AppBarTemplate.dart';
import '../templates/DrawerTemplate.dart';
import 'package:share_market_tips/utils/Constants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Contact extends StatefulWidget {
  @override
  _ContactState createState() => _ContactState();
}

class _ContactState extends State<Contact> {

  var firstName;
  var lastName;
  var email;

  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();


  Future<void> _incrementCounter() async {
    final SharedPreferences prefs = await _prefs;
    setState(() {
      firstName = prefs.getString("first_name");
      lastName = prefs.getString("last_name");
      email = prefs.getString("email");
    });
  }

  @override
  void initState() {
    super.initState();
    _incrementCounter();
  }

  var firstNameController = new TextEditingController();
  var lastNameController = new TextEditingController();
  var contactNumberController = new TextEditingController();
  var messageController = new TextEditingController();

  var _contactFormErrorText = "";
  var _contactFormSuccessText = "";

  Future sendMessage() async{
    var enteredFirstName = firstNameController.text;
    var enteredLastName = lastNameController.text;
    var enteredContactNumber = contactNumberController.text;
    var enteredMessage = messageController.text;
    if (enteredFirstName==""||enteredLastName==""||enteredContactNumber==""||enteredMessage=="") {
      setState(() {
        _contactFormErrorText="Please Enter All Fields";
      });
    } else {
      var url = Constants.apiUrl+'lead-gen-contact-form-api';
      var response = await http.post(url, body: {'api_key': '5f4dbf2e5629d8cc19e7d51874266678', 'fist_name': enteredFirstName, 'last_name': enteredLastName, 'contact_number': enteredContactNumber, 'message':enteredMessage});
        if(response.statusCode==200){
        var responseBody = jsonDecode(response.body);
        if(responseBody["result"]=="failure"){
          setState(() {
            _contactFormErrorText = responseBody["reason"];
          });
        }else{
          setState(() {
            _contactFormErrorText="";
          _contactFormSuccessText="Your Message was sent successfully";
          });
        }
      }else{
        setState(() {
          _contactFormErrorText = "Cannot connect to server, check your internet";
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: DrawerTemplate(firstName,lastName,email),
        appBar: AppBarTemplate("Contact"),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                Image.asset("assets/images/contact.jpg"),
                SizedBox(height: 20.0),
                Text("Send us a Message",style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold)),
                SizedBox(height: 20.0),
                Text(_contactFormErrorText,style: TextStyle(color: Colors.red,fontSize: 15.0)),
                Text(_contactFormSuccessText,style: TextStyle(color: Colors.green,fontSize: 15.0)),
                SizedBox(height: 10.0,),
                TextField(
                  controller: firstNameController,
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                      labelText: "First Name",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(4.0)),
                      )),
                ),
                SizedBox(height: 10.0,),
                TextField(
                  controller: lastNameController,
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                      labelText: "Last Name",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(4.0)),
                      )),
                ),
                SizedBox(height: 10.0,),
                TextField(
                  controller: contactNumberController,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                      labelText: "Contact Number",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(4.0)),
                      )),
                ),
                SizedBox(height: 10.0,),
                TextField(
                  controller: messageController,
                  keyboardType: TextInputType.text,
                  minLines: 4,
                  maxLines: null,
                  decoration: InputDecoration(
                      labelText: "Your Message",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(4.0)),
                      )),
                ),
                SizedBox(height: 10.0),
                MaterialButton(
                  height: 50.0,
                  minWidth: double.maxFinite,
                  onPressed: sendMessage,
                  color: Colors.indigo,
                  child: Text("SEND MESSAGE",style: TextStyle(color: Colors.white,fontSize: 16.0)),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                ),
                SizedBox(height: 25.0),
              ],
            ),
          ),
        ),
      ), 
    );
  }
}