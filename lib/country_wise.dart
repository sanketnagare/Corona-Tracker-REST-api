import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class World extends StatefulWidget {
  const World({Key? key}) : super(key: key);

  @override
  _WorldState createState() => _WorldState();
}

class _WorldState extends State<World> {
  final url = "https://corona.lmao.ninja/v2/countries";

  Future<List>? datas;

  Future<List> getData() async {
    var responce = await Dio().get(url);
    return responce.data;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    datas = getData();
  }

  Future showcard(String country, cases, tdeath, death, recovered) async
  {
    await showDialog(context: context, builder: (BuildContext context)
    {
      return AlertDialog(
        backgroundColor: Colors.white,
        shape: const RoundedRectangleBorder(),
        content: SingleChildScrollView(
          child: ListBody(children: <Widget>[
             Text("Country : $country", style: TextStyle(fontSize: 25,color: Colors.black),),
            Text("Total Cases : $cases", style: TextStyle(fontSize: 25,color: Colors.black),),
            Text("Today's Death : $tdeath", style: TextStyle(fontSize: 25,color: Colors.red),),
            Text("Total Death : $death", style: TextStyle(fontSize: 25,color: Colors.red),),
            Text("Total Recoverd : $recovered", style: TextStyle(fontSize: 25,color: Colors.green),),
          ],)
        ),
      );
    }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: Text('Each Country Statistics'),
          backgroundColor: Colors.lightBlue,
        ),
        body: Container(
            padding: const EdgeInsets.all(10),
            child: FutureBuilder(
              future: datas,
              builder: (BuildContext context, AsyncSnapshot SnapShot) {
                if (SnapShot.hasData) {
                  //print(SnapShot.data);
                  return GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 1.0,
                        crossAxisSpacing: 10.0,
                        mainAxisSpacing: 10.0),
                    itemCount: 199,
                    itemBuilder: (BuildContext context, index) => SizedBox(
                      height: 50,
                      width: 50,
                      child: GestureDetector(
                          onTap: () => showcard(
                            SnapShot.data[index]['country'].toString(),
                            SnapShot.data[index]['cases'].toString(),
                            SnapShot.data[index]['todayCases'].toString(),
                            SnapShot.data[index]['deaths'].toString(),
                            SnapShot.data[index]['recovered'].toString(),
                          ),
                          child: Card(
                            child: Container(
                              color: Color(0xFF292929),
                              child: Center(
                                child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      const Padding(padding: EdgeInsets.only(top:10)),
                                      const Image(
                                        image: AssetImage("images/country.jpg"),
                                        height: 85,
                                        width: 85,
                                      ),
                                      // Padding(padding: EdgeInsets.all(10)),
                                      Text(
                                        SnapShot.data[index]['country'],
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 18.0,
                                        ),
                                      )
                                    ]),
                              ),
                            ),
                          )),
                    ),
                  );
                }
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
            )));
  }
}
