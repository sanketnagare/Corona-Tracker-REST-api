import 'dart:convert';

import 'package:corona_tracker/model/total_case.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:corona_tracker/model/total_case.dart';
import 'package:corona_tracker/country_wise.dart';
import 'package:corona_tracker/state_wise.dart';
import 'package:corona_tracker/model/india_stats.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final url = Uri.parse("https://corona.lmao.ninja/v2/all");

  @override
  void initState() {
    super.initState();
    getJsonData();
  }

  navigateToCountry() async {
    await Navigator.push(
        context, MaterialPageRoute(builder: (context) => const World()));
  }

  navigateToIndia() async {
    await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Inida(),
        ));
  }
    navigateToCowin(url) async {
    if(await canLaunch(url))
    {
      await launch(url);
    }
    else{
      Text("Link is not working $url");
    }
  }

  Future<Tcases> getJsonData() async {
    var response = await http.get(url);

    if (response.statusCode == 200) {
      final convertDataJSON = jsonDecode(response.body);

      return Tcases.fromJson(convertDataJSON);
    } else {
      throw Exception("Try to reload");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Center(child: Text('COVID-19 Tracker')),
        backgroundColor: Colors.lightBlue,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const <Widget>[
                    Padding(padding: EdgeInsets.only(top: 50)),
                    Text(
                      "Stay",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 25.0,
                          fontWeight: FontWeight.bold),
                    ),
                    Card(
                      color: Colors.amber,
                      child: Text(
                        "Home",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 25.0,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                     Text(
                      "   Wear",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 25.0,
                          fontWeight: FontWeight.bold),
                    ),
                    Card(
                      color: Colors.amber,
                      child: Text(
                        "Mask",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 25.0,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                
              ),
              
              const Padding(padding: EdgeInsets.only(top: 20.0)),
              const Center(
                child: Text(
                  'World Stats',
                  style: TextStyle(fontSize: 25.0, color: Colors.white,fontWeight: FontWeight.bold),
                ),
              ),
              Padding(padding: EdgeInsets.only(top: 10.0)),
              FutureBuilder<Tcases>(
                  future: getJsonData(),
                  builder: (BuildContext context, SnapShot) {
                    if (SnapShot.hasData) {
                      final covid = SnapShot.data;
                      return Column(
                        children: <Widget>[
                          Card(
                              color: Color(0xFF292929),
                              child: ListTile(
                                  title: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: <Widget>[
                                    Text(
                                      "${covid?.cases} ",
                                      style: const TextStyle(
                                          color: Colors.blue,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      "${covid?.deaths}",
                                      style: const TextStyle(
                                          color: Colors.red,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text("${covid?.recovered}",
                                        style: const TextStyle(
                                            color: Colors.green,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold)),
                                  ]))),
                        ],
                      );
                    } else if (SnapShot.hasError) {
                      return Text(SnapShot.error.toString());
                    }
      
                    return const Center(child: CircularProgressIndicator());
                  }),
              const Padding(padding: EdgeInsets.only(top: 5.0)),
              Card(
                color: Color(0xFF292929),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: const <Widget>[
                    Text(
                      "Total Cases ",
                      style: TextStyle(
                          color: Colors.blue,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "Deaths",
                      style: TextStyle(
                          color: Colors.red,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    Text("Recoverd",
                        style: TextStyle(
                            color: Colors.green,
                            fontSize: 20,
                            fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
              const Padding(padding: EdgeInsets.only(top: 20.0)),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: <
                  Widget>[
                Card(
                    child: Container(
                        color: Color(0xFF292929),
                        child: Center(
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                              const Padding(padding: EdgeInsets.only(top: 20.0)),
      
                              const Image(
                                image: AssetImage("images/indiamap.png"),
                                height: 200,
                                width: 190,
                              ),
                              const Padding(padding: EdgeInsets.all(10)),
                              // ignore: deprecated_member_use
                              OutlineButton(
                                borderSide:
                                    const BorderSide(color: Color(0xFFfe9900)),
                                onPressed: () => navigateToIndia(),
                                child: Center(
                                    child: const Text(
                                  "              Indian \n Statewise Statistics",
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: Color(0xFFfe9900),
                                      fontWeight: FontWeight.bold),
                                )),
                              ),
                            ])))),
                Card(
                    child: Container(
                        color: const Color(0xFF292929),
                        child: Center(
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                              const Padding(padding: EdgeInsets.only(top: 20.0)),
      
                              const Image(
                                image: AssetImage("images/world.jpg"),
                                height: 200,
                                width: 190,
                              ),
                              const Padding(padding: EdgeInsets.all(10)),
                              // ignore: deprecated_member_use
                              OutlineButton(
                                borderSide:
                                    const BorderSide(color: Color(0xFFfe9900)),
                                onPressed: () => navigateToCountry(),
                                child: const Text(
                                  "Countrywise Statistics",
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: Color(0xFFfe9900),
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ])))),
              ]),
              const Padding(padding: EdgeInsets.only(top: 20.0)),
              Card(
                  child: Container(
                      color: const Color(0xFF292929),
                      child: Center(
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: <Widget>[
                            const Padding(padding: EdgeInsets.only(top: 20.0)),
      
                            const Image(
                              image: AssetImage("images/vaccine.jpg"),
                              height: 100,
                              width: 100,
                            ),
                            const Padding(padding: EdgeInsets.all(10)),
                                   // ignore: deprecated_member_use
                                   OutlineButton(
                            borderSide: BorderSide(color : Color(0xFFfe9900)),
      
                                     onPressed: ()=> navigateToCowin("https://www.cowin.gov.in/home"),
      
                                   child : const Text("Take your vaccine now..",style: TextStyle(fontSize: 15,color:Color(0xFFfe9900),fontWeight: FontWeight.bold),),
                                      ),
                          ])))),
            ],
          ),
        ),
      ),
    );
  }
}
