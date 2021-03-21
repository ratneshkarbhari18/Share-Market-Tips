import 'package:flutter/material.dart';
import 'package:share_market_tips/utils/Constants.dart';
import '../templates/AppBarTemplate.dart';
import '../templates/DrawerTemplate.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';



class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var fiveNotifs;

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

  

  static  List<Widget> _botttomNavBodies = <Widget>[
    HomePageBody(),PlansBody(),MyProfilePage()
  ];

  static  List _botttomNavBodiesTitles = [
    "Home","Plans","Profile"
  ];

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: DrawerTemplate(firstName,lastName,email),
        appBar: AppBarTemplate(_botttomNavBodiesTitles.elementAt(_selectedIndex)),
        body: _botttomNavBodies.elementAt(_selectedIndex),
        bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: 'Plans',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_box),
            label: 'Account',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.pink,
        onTap: _onItemTapped,
      ),
      ),
    );
  }
}


class MyProfilePage extends StatefulWidget {
  @override
  _MyProfilePageState createState() => _MyProfilePageState();
}

class _MyProfilePageState extends State<MyProfilePage> {

  final firstNameController = new TextEditingController();
  final lastNameController = new TextEditingController();
  final emailController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
          padding: const EdgeInsets.all(20.0),
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
      ),
    );
  }
}

class PlansBody extends StatefulWidget {
  @override
  _PlansBodyState createState() => _PlansBodyState();
}

class _PlansBodyState extends State<PlansBody> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
          child: Padding(
                padding: const EdgeInsets.all(20.0),
                      child: Column(
              children: [
                SizedBox(
                  height: 10.0,
                ),
                Text("Plan 1", style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold)),
                SizedBox(
                  height: 10.0,
                ),
                Text("Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam ", style: TextStyle(fontSize: 16.0)),
                SizedBox(
                  height: 10.0,
                ),
                Text("Plan 2", style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold)),
                SizedBox(
                  height: 10.0,
                ),
                Text("Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam ", style: TextStyle(fontSize: 16.0)),
                SizedBox(
                  height: 10.0,
                ),
                Text("Plan 3", style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold)),
                SizedBox(
                  height: 10.0,
                ),
                Text("Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam ", style: TextStyle(fontSize: 16.0)),
                SizedBox(
                  height: 10.0,
                ),
              ],
            ),
          )
        );
  }
}


class HomePageBody extends StatefulWidget {
  
  @override
  _HomePageBodyState createState() => _HomePageBodyState();
}


class _HomePageBodyState extends State<HomePageBody> {

  var pushNotifMessage = "";

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  _registerOnFirebase() {
    _firebaseMessaging.subscribeToTopic('all');
    _firebaseMessaging.getToken().then((token) => print(token));
  }

  void getMessage() {
    _firebaseMessaging.configure(
        onMessage: (Map<String, dynamic> message) async {
      print(message);
      setState(() => pushNotifMessage = message["notification"]["body"]);
      _showNotification(message["notification"]["title"],message["notification"]["body"]);
    }, onResume: (Map<String, dynamic> message) async {
      print('on resume $message');
      setState(() => pushNotifMessage = message["notification"]["body"]);
      _showNotification(message["notification"]["title"],message["notification"]["body"]);
    }, onLaunch: (Map<String, dynamic> message) async {
      print('on launch $message');
      setState(() => pushNotifMessage = message["notification"]["body"]);
      _showNotification(message["notification"]["title"],message["notification"]["body"]);
    });
  }


  final List<String> carouselImgList = [
    'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
    'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
    'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
    'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
    'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
    'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80'
  ];

  var fiveNotifs;

  Future fetchLatestFiveNotif() async {
    var url =
        Constants.apiUrl+"/jaldi-five-notif-fetch";
    var apiKey = "5f4dbf2e5629d8cc19e7d51874266678";
    var params = {'api_key': apiKey};
    var res = await http.post(url, body: params);
    var notifsObj = res.body;
    var resBody = jsonDecode(notifsObj);
    var notifications = resBody["notifications"];
    setState(() {
      fiveNotifs = notifications;
    });
    return fiveNotifs;
  }

    // Creating a notification
  FlutterLocalNotificationsPlugin localNotification;

  @override
  void initState() {
    var androidInitialize = new AndroidInitializationSettings("app_icon");
    var iosInitializa = new IOSInitializationSettings();
    var intiailizationSettings = new InitializationSettings(android: androidInitialize, iOS: iosInitializa);
    localNotification = new FlutterLocalNotificationsPlugin();
    localNotification.initialize(intiailizationSettings);
    _registerOnFirebase();
    getMessage();
    fetchLatestFiveNotif();
    
    super.initState();
  }

  Future _showNotification(title,body) async{
    var androidDetails = new AndroidNotificationDetails("general_tips", "Share Market Tips", "General Share Market Tips for All");
    var iosDetails = new IOSNotificationDetails();
    var generalNotifDetails = new NotificationDetails(android: androidDetails,iOS: iosDetails);
    await localNotification.show(0, title, body, generalNotifDetails);

  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
          child: Column(children: [
            CarouselSlider(
              options: CarouselOptions(viewportFraction: 1),
              items: carouselImgList
                  .map((item) => Image.network(item.toString(),
                      fit: BoxFit.cover, width: 1000))
                  .toList(),
            ),
            SizedBox(
              height: 10.0,
            ),
            
            Text(
              "Today's Tips",
              style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10.0,
            ),
            Padding(
                padding: const EdgeInsets.all(10.0),
                child: (fiveNotifs==null) ? CircularProgressIndicator() : ListView.builder(
                    physics: ScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: (fiveNotifs.length<5)?fiveNotifs.length:5,
                    itemBuilder: (context, index) {
                      return Card(
                        color: Colors.indigo,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: ListView(
                            physics: ScrollPhysics(),
                            shrinkWrap: true,
                            children: [
                              Text(
                                fiveNotifs[index]["name"],
                                style: TextStyle(
                                    fontSize: 20.0,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                  "Market Price: ₹ " +
                                      fiveNotifs[index]["market_price"],
                                  style: TextStyle(
                                      fontSize: 15.0, color: Colors.white)),
                              Text(
                                  "Buy Price: ₹ " +
                                      fiveNotifs[index]["buy_price"],
                                  style: TextStyle(
                                      fontSize: 15.0, color: Colors.white)),
                              Text(
                                  "Stop Loss Price: ₹ " +
                                      fiveNotifs[index]["stop_loss"],
                                  style: TextStyle(
                                      fontSize: 15.0, color: Colors.white)
                              ),
                              Text(
                                "Date: " +
                                    fiveNotifs[index]["date"],
                                style: TextStyle(
                                    fontSize: 15.0, color: Colors.white
                                )
                              ),
                            ],
                          ),
                        ),
                      );
                    }))
          ]),
        );
  }
}