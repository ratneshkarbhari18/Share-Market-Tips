import 'package:flutter/material.dart';
import '../templates/AppBarTemplate.dart';
import '../templates/DrawerTemplate.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './Notifications.dart';

class NotificationDetailPage extends StatefulWidget {
  final fiveNotifs;
  NotificationDetailPage(this.fiveNotifs);
  @override
  _NotificationDetailPageState createState() => _NotificationDetailPageState(fiveNotifs);
}

class _NotificationDetailPageState extends State<NotificationDetailPage> {
  final fiveNotifs;

    var firstName;
  var lastName;
  var email;

  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();


  Future<void> _setUserState() async {
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
    _setUserState();
  }

  _NotificationDetailPageState(this.fiveNotifs);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: DrawerTemplate(firstName,lastName,email),
        appBar: AppBarTemplate(fiveNotifs["name"]),
        body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Center(
                child: Column(
                children: [
                  SizedBox(
                    height: 10.0,
                  ),
                  MaterialButton(
                    height: 50.0,
                    minWidth: double.maxFinite,
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> Notifications()));
                    },
                    color: Colors.indigo,
                    child: Text("See All Notifications",style: TextStyle(color: Colors.white,fontSize: 16.0)),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  Text(
                    fiveNotifs["name"],
                    style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                      "Market Price: ₹ " +
                          fiveNotifs["market_price"],
                      style: TextStyle(
                          fontSize: 15.0, color: Colors.black)),
                  Text(
                      "Buy Price: ₹ " +
                          fiveNotifs["buy_price"],
                      style: TextStyle(
                          fontSize: 15.0, color: Colors.black)),
                  Text(
                      "Stop Loss Price: ₹ " +
                          fiveNotifs["stop_loss"],
                      style: TextStyle(
                          fontSize: 15.0, color: Colors.black)
                  ),
                  Text(
                    "Date: " +
                        fiveNotifs["date"],
                    style: TextStyle(
                        fontSize: 15.0, color: Colors.black
                    )
                  ),
                ],
              ),
            ),
          )
        ),
      ),
    );
  }
}