import 'package:flutter/material.dart';
import '../templates/AppBarTemplate.dart';
import '../templates/DrawerTemplate.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Notifications extends StatefulWidget {
  @override
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  var fiveNotifs;

  Future fetchLatestFiveNotif() async {
    var url =
        "https://codesevaco.tech/share_market_app_backend/jaldi-five-notif-fetch";
    var apiKey = "5f4dbf2e5629d8cc19e7d51874266678";
    var params = {'api_key': apiKey};
    var res = await http.post(url, body: params);
    var notifsObj = res.body;
    var resBody = jsonDecode(notifsObj);
    var notifications = resBody["notifications"];
    setState(() {
      fiveNotifs = notifications.take(5);
    });
    return fiveNotifs;
  }

  @override
  void initState() {
    super.initState();
    fetchLatestFiveNotif();
  }



  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: DrawerTemplate(),
        appBar: AppBarTemplate("Notifications"),
        body: SingleChildScrollView(
          child: Column(children: [
            ListView.builder(
              shrinkWrap: true,
              physics: ScrollPhysics(),
              itemCount: fiveNotifs.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Card(
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
                                fontSize: 20.0, color: Colors.white,fontWeight: FontWeight.bold),
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
                                  fontSize: 15.0, color: Colors.white)),
                        ],
                      ),
                    ),
                  ),
                );
              },
            )
          ]),
        ),
      ),
    );
  }
}
