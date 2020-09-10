import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

final client = MqttServerClient('192.168.137.1', '');

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
    print("กำลังล็อคอิน");
    setState(() {
      user = _username.text;
      pass = _password.text;
    });
    print(user == usertrue);
    onnavigator();
    
  }

  onnavigator(){
    if (user == usertrue && pass ==passtrue){
      print("ล็อคอินสำเร็จ");
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
                  child: Image.asset("assets/112.png"),
                  width: 200,
                  height: 200,
                ),
                Container(
                  width: 400,
                  child: TextFormField(
                    controller: _username,
                    decoration: InputDecoration(
                      hintText: "ชื่อผู้ใช้งาน"
                    ),
                  )
                  ),
                Container(
                  width: 400,
                  child: TextFormField(
                    controller: _password,
                    decoration: InputDecoration(
                      hintText: "รหัสผ่าน",
                
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
                        "ล็อคอินเพื่อถอนเงิน",
                        style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 30.0),
                  child: FlatButton(
                    onPressed: (){
                      Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Page3()));
                    },
                     child: Container(
                       color: Colors.blue,
                       alignment: Alignment.center,
                       width: 200,
                       height: 50,
                       child: Text(
                         "เช็คยอดเงิน",
                         style: TextStyle(
                           fontSize: 20.0,
                           color: Colors.white,
                         ),
                         ),
                     )
                      )
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
          child: Screen1(),

        ),
      );
    
  }
}


class Screen1 extends StatefulWidget {
  
  
  
  @override
  _Screen1State createState() => _Screen1State();
}

class _Screen1State extends State<Screen1> {
  String _message = "";
  connectionMqtt()async{

	//fixต้องใส่   เช็คการ connection
    client.port = 1883;
    client.onConnected = onConnected;
    try {
      await client.connect();
    } on Exception catch (e) {
      print('EXAMPLE::client exception - $e');
      client.disconnect();
    }
    if (client.connectionStatus.state == MqttConnectionState.connected) {
      print('EXAMPLE::Mosquitto client connected');
    } else {
      print(
          'EXAMPLE::ERROR Mosquitto client connection failed - disconnecting, state is ${client.connectionStatus.state}');
      client.disconnect();
    }
    final connMess = MqttConnectMessage()
      .withClientIdentifier('Mqtt_MyClientUniqueId')
      .startClean() // Non persistent session for testing
      .withWillQos(MqttQos.atLeastOnce);
    print('EXAMPLE::Mosquitto client connecting....');
    client.connectionMessage = connMess;


    //subscribe  ส่วนของการ connection หากต้องการ subscribe ให้ setstateตรงนี้  อย่าลืมนะ ใช้ stateful 
    const topic = 'at2';
    client.subscribe(topic, MqttQos.atMostOnce);
    client.updates.listen((List<MqttReceivedMessage<MqttMessage>> c) {

      final MqttPublishMessage recMess = c[0].payload;
	//pt เป็นข้อความที่ได้รับมา หากจะรับและมาแสดงผล ให้ setstate ที่นี่
      final pt =
          MqttPublishPayload.bytesToStringAsString(recMess.payload.message);
          setState(() {
            _message = pt;
          });

      print(
          'EXAMPLE::Change notification:: topic is <${c[0].topic}>, payload is <-- $pt -->');
      print('');
    });
  }
   void onConnected(){
    print("......................connected...............");  
  }

  final ware2 = 'at2';
  send456(){
    final builder = MqttClientPayloadBuilder();
    builder.addString('Sum');
    client.publishMessage(ware2, MqttQos.exactlyOnce, builder.payload);
    
  }

    final ware = 'at2';
  send123(){
    final builder = MqttClientPayloadBuilder();
    builder.addString('Reset');
    client.publishMessage(ware, MqttQos.exactlyOnce, builder.payload);

  } 

  @override

  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "จำนวนเงินในขณะนี้ \n$_message",
          style: TextStyle(
            fontSize: 40.0
          ),
        ),
        RaisedButton(
          onPressed: (){
             connectionMqtt();
          },
          child: Text(
            "รีเฟรช",
            style: TextStyle(
              fontSize: 20,
              color:Colors.black,
            )
          ),
        ),

          FlatButton(
          onPressed: (){
            send123();
          }, 
          child: Container(
            alignment: Alignment.center,
            height: 100.0,
            width: 200,
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.all(Radius.circular(40),
              )
            ),
            child: Text(
              "รีเซ็ตจำนวนเงิน",
              style: TextStyle(
                fontSize: 30,
                color: Colors.yellow,
              ),
            ),
          )
          ),
      ],
    );
  }
}



class Page3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
        body: Container(
          alignment: Alignment.center,
          child: Screen2(),

        ),
      );
    
  }
}


class Screen2 extends StatefulWidget {
  
  
  
  @override
  _Screen2State createState() => _Screen2State();
}

class _Screen2State extends State<Screen2> {
  String _message = "";
  connectionMqtt()async{

	//fixต้องใส่   เช็คการ connection
    client.port = 1883;
    client.onConnected = onConnected;
    try {
      await client.connect();
    } on Exception catch (e) {
      print('EXAMPLE::client exception - $e');
      client.disconnect();
    }
    if (client.connectionStatus.state == MqttConnectionState.connected) {
      print('EXAMPLE::Mosquitto client connected');
    } else {
      print(
          'EXAMPLE::ERROR Mosquitto client connection failed - disconnecting, state is ${client.connectionStatus.state}');
      client.disconnect();
    }
    final connMess = MqttConnectMessage()
      .withClientIdentifier('Mqtt_MyClientUniqueId')
      .startClean() // Non persistent session for testing
      .withWillQos(MqttQos.atLeastOnce);
    print('EXAMPLE::Mosquitto client connecting....');
    client.connectionMessage = connMess;


    //subscribe  ส่วนของการ connection หากต้องการ subscribe ให้ setstateตรงนี้  อย่าลืมนะ ใช้ stateful 
    const topic = 'at2';
    client.subscribe(topic, MqttQos.atMostOnce);
    client.updates.listen((List<MqttReceivedMessage<MqttMessage>> c) {

      final MqttPublishMessage recMess = c[0].payload;
	//pt เป็นข้อความที่ได้รับมา หากจะรับและมาแสดงผล ให้ setstate ที่นี่
      final pt =
          MqttPublishPayload.bytesToStringAsString(recMess.payload.message);
          setState(() {
            _message = pt;
          });

      print(
          'EXAMPLE::Change notification:: topic is <${c[0].topic}>, payload is <-- $pt -->');
      print('');
    });
  }
   void onConnected(){
    print("......................connected...............");  
  }

  final ware2 = 'at2';
  send456(){
    final builder = MqttClientPayloadBuilder();
    builder.addString('Sum');
    client.publishMessage(ware2, MqttQos.exactlyOnce, builder.payload);
    
  }

    final ware = 'at2';
  send123(){
    final builder = MqttClientPayloadBuilder();
    builder.addString('Reset');
    client.publishMessage(ware, MqttQos.exactlyOnce, builder.payload);

  } 

  @override

  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "จำนวนเงินในขณะนี้ \n$_message",
          style: TextStyle(
            fontSize: 40.0
          ),
        ),
        RaisedButton(
          onPressed: (){
             connectionMqtt();
          },
          child: Text(
            "รีเฟรช",
            style: TextStyle(
              fontSize: 20,
              color:Colors.black,
            )
          ),
        ),
        FlatButton(
          onPressed: (){
            send456();
          }, 
          child: Container(
            alignment: Alignment.center,
            height: 100.0,
            width: 200,
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.all(Radius.circular(40),
              )
            ),
            child: Text(
              "เช็คยอดเงิน",
              style: TextStyle(
                fontSize: 30,
                color: Colors.yellow,
              ),
            ),
          )
          ),

      ],
    );
  }
}