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
        body: Page1(),
      ),
    );
  }
}

class Page1 extends StatefulWidget {
  @override
  _Page1State createState() => _Page1State();
}

class _Page1State extends State<Page1> {

  TextEditingController _username;
  TextEditingController _password;

  
  //user and password use login this applica....
  String usertrue = "ware";
  String passtrue = "12345";

  String user = "";
  String pass = "";

  @override
    void initState() {
      // TODO: implement initState
      super.initState();
      _username = TextEditingController();
      _password = TextEditingController();
    }
  onlogin(){
    print("object");
    setState(() {
      user = _username.text;
      pass = _password.text;
    });
    print(user == usertrue);
    onnavigator();
    
  }

  onnavigator(){
    if (user == usertrue && pass ==passtrue){
      print("ddfdf");
      Navigator.push(
       context, 
       MaterialPageRoute(builder: (context)=> AfterLogin()
       )
      ); 
    }
    else{
      _password.clear();
      _username.clear();
    }
  }
  @override
  Widget build(BuildContext context) {
    return Container(
            height: double.infinity,
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: 50.0),
                  child: Image.asset("assets/Logo.png"),
                  width: 200,
                  height: 200,
                ),
                Container(
                  width: 400,
                  child: TextFormField(
                    controller: _username,
                    decoration: InputDecoration(
                      hintText: "Username"
                    ),
                  )
                  ),
                Container(
                  width: 400,
                  child: TextFormField(
                    controller: _password,
                    decoration: InputDecoration(
                      hintText: "Password",
                
                    ),
                    obscureText: true,
                  )
                ),
                Container(
                  padding: EdgeInsets.only(top: 20.0),
                  child: FlatButton(
                    onPressed: (){
                      onlogin();                      
                    },
                    child: Container(
                      color: Colors.blue,
                      alignment: Alignment.center,
                      width: 200,
                      height: 50,
                      child: Text(
                        "Login",
                        style: TextStyle(
                          fontSize: 30.0,
                          color: Colors.white
                        ),
                      ),
                    ),
                    
                  ),
                )
              ],
            ),
          );
  }
}

class AfterLogin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        alignment: Alignment.center,
        width: double.infinity,
        height: double.infinity,
        color: Colors.white,
        child: Text("login แล้วน่ะ"),
      )
    
    );
  }
}