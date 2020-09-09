import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
home: Scaffold(
  body: Container(
    height: double.infinity,
    width: double.infinity,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children:[
        Container(
          padding: EdgeInsets.only(bottom:50),
          child:Image.asset("assets/Logo.png"),
        width: 200,
        height: 200,
        ),
        Container(
          width: 300,
          child: TextFormField(
              decoration: InputDecoration(
              hintText: "Username"
              ),
          ),
          ),
        Container(
          width: 300,
          child: TextFormField(
            decoration: InputDecoration(
              hintText: "Password"

            ),
            obscureText: true,
          )
          ),
        Container(
          padding: EdgeInsets.only(top: 20),
          child: RaisedButton(
            color: Colors.blue,
            onPressed: (){

            },
            child: Container(
              alignment: Alignment.center,
              width: 150,
              height: 50,
              child: Text("Login",
              style:TextStyle(
                fontSize: 30,
                color: Colors.white
              )),
            ),

          ),
        )
      ],
    ),
  ),
),
    );
  }
}