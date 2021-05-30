import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'Usermodel.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);


  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}
class _MyHomePageState extends State<MyHomePage> {
  String interest  ;
Future<UserModel> createUser(String principal, String rate,String year) async{
  final String apiUrl = "http://192.168.29.176:8080/Interest";
  final response = await http.post(apiUrl,  headers: {
    "content-type" : "application/json",
    "accept" : "application/json",
  }, body: jsonEncode(<String,String> {
    "principal":principal ,
    "rate": rate,
    "year":year,
  }));
  print(response.statusCode);
  print(response.body);
  String data=response.body;
  setState(() {
    interest= data;
  });

}
  

  TextEditingController Principal = TextEditingController();
  TextEditingController  Rate= TextEditingController();
  TextEditingController Year= TextEditingController();


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(

        title: Text("INTEREST CALCULATOR"),
      ),
      body:Container(
        padding: EdgeInsets.all(32),
        child: Column(
          children: <Widget>[

            TextField(
              controller: Principal,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
              border:OutlineInputBorder(),
              hintText : "principal"),
              autofocus: true,
            ),

            TextField(
              controller: Rate,
              keyboardType:TextInputType.number,
              decoration: InputDecoration(
                border:OutlineInputBorder(),
                hintText: "rate"
              ),
              autofocus: true,
            ),
            TextField(
            controller: Year,
                keyboardType:TextInputType.number,
              decoration: InputDecoration(
                border:OutlineInputBorder(),
                hintText:"year"
              ),
              autofocus: true,
            ),
            SizedBox(height: 50,),
            interest== null ? Container() :
            Text("Your Compound Interest=${interest}",style: TextStyle(fontSize: 25.0,fontWeight: FontWeight.bold),),

          ],
        ),
      ),

    floatingActionButton: FloatingActionButton(
        onPressed: () async{
          /*final String principal = Principal.text;
          final  String rate = Rate.text;
          final String year = Year.text;
         */
         final String principal = Principal.text;
         final String rate=Rate.text;
         final String year=Year.text;

          final UserModel user = await createUser(principal, rate, year);
          },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}