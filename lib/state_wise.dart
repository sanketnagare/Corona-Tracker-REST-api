import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class Inida extends StatefulWidget {
  const Inida({ Key? key }) : super(key: key);

  @override
  _InidaState createState() => _InidaState();
}

class _InidaState extends State<Inida> {

Future showcard (String ind,inter,recover,death) async
  {
     await showDialog(
        context: context,
        builder: (BuildContext contect)
        {
          return AlertDialog(
            backgroundColor: Color(0xFF363636),
            shape: RoundedRectangleBorder(),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                
                    Text("Indian Cases :$ind",style: TextStyle(fontSize: 25,color : Colors.blue),),
                    Text("Foreigner Cases :$inter",style: TextStyle(fontSize: 25,color : Colors.white),),
                    Text("Total Recoveries :$recover",style: TextStyle(fontSize: 25,color : Colors.green),),
                    Text("Total Deaths :$death",style: TextStyle(fontSize: 25,color : Colors.red),),


                    
                  
                ],
              ),
            ),
          );
        }
      );
  }

  final url  = "https://api.rootnet.in/covid19-in/stats/latest";
  Future <List>? datas;

  Future <List> getDat() async{
    var responce = await Dio().get(url);
    return responce.data['data']['regional']; //in data their is regional folder
      
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    datas = getDat();
  }

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
      title: Text('Statewise Statistics'),
        backgroundColor: Color(0xFF152238)
      
    ),
    backgroundColor: Colors.black,
    body: Container(
      padding: EdgeInsets.all(10),
      child: FutureBuilder(

        future: datas,
        builder: (BuildContext context,AsyncSnapshot snapshot){

          if(snapshot.hasData)
          {print(snapshot.data);
            return  GridView.builder(
              

              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1.0,
                crossAxisSpacing: 10.0,
                mainAxisSpacing: 10.0
              ),
              itemCount: 27,
              

              itemBuilder: (BuildContext context, index) => SizedBox(
                
                
                height : 50.0,
                width : 50.0,
               child: GestureDetector(
                 onTap:()=> showcard(snapshot.data[index]['confirmedCasesIndian'].toString(),
                 snapshot.data[index]['confirmedCasesForeign'].toString(),
                 snapshot.data[index]['discharged'].toString(),
                 snapshot.data[index]['deaths'].toString()),

                child: Card(
                //elevation: 10,
               // child: Padding(padding: EdgeInsets.symmetric(vertical: 10,horizontal: 8),

               child: Container(color: Color(0xFF292929),
                 child : Center(
                  child: Column( 
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children : <Widget>[
                 Padding(padding: EdgeInsets.only(top:5.0)),
                      
                    

                    Text('Indian Cases:${snapshot.data[index]['confirmedCasesIndian'].toString()}',
                    style: TextStyle(color: Color(0xFF45b6fe),fontWeight: FontWeight.bold),),

                 Padding(padding: EdgeInsets.only(top:5.0)),



                 Image(image: AssetImage("images/country.jpg"),
                 height: 100,
                 width: 100
                 ,),
                 Padding(padding: EdgeInsets.only(top:5.0)),
                      
                     
                  

                  Text(snapshot.data[index]['loc'],style: TextStyle(fontSize: 18,color: Colors.white),),
                
                
                
                  ]
              ),)

            ),
              
              )
            )
            )
            );
             
            
            
          }
              return Center(
                child: CircularProgressIndicator(),
              );

        }


      )
          
        
      
    )
  );
      
  
  }
}