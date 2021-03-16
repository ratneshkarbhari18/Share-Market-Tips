import 'package:flutter/material.dart';
import '../templates/AppBarTemplate.dart';
import '../templates/DrawerTemplate.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
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
      fiveNotifs = notifications;
    });
    print(fiveNotifs);
    // return fiveNotifs;
  }

  @override
  void initState() {
    super.initState();
    fetchLatestFiveNotif();
  }

  final List<String> carouselImgList = [
    'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
    'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
    'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
    'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
    'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
    'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80'
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: DrawerTemplate(),
        appBar: AppBarTemplate("Home"),
        body: SingleChildScrollView(
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
                    itemCount: 5,
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
                                      fontSize: 15.0, color: Colors.white)),
                            ],
                          ),
                        ),
                      );
                    }))
          ]),
        ),
      ),
    );
  }
}
