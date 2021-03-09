import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:qr_mobile_vision/qr_camera.dart';

import 'package:qr_mobile_vision/qr_mobile_vision.dart';

import 'bottom_nav_bar.dart';

void main() {
  debugPaintSizeEnabled = false;
  runApp(new HomePage());
}

class HomePage extends StatefulWidget {
  @override
  HomeState createState() => new HomeState();
}

class HomeState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(home: new MyApp());
  }
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String qr;
  bool camState = false;

  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Expanded(
            child: camState
                ? new Center(
                    child: new SizedBox(
                      width: MediaQuery.of(context).size.width,
                      //height: 600.0,
                      child: new QrCamera(
                        onError: (context, error) => Text(
                          error.toString(),
                          style: TextStyle(color: Colors.red),
                        ),
                        qrCodeCallback: (code) {
                          setState(() {
                            qr = code;
                          });
                        },
                        child: new Container(
                          decoration: new BoxDecoration(
                            color: Colors.transparent,
                          ),
                        ),
                      ),
                    ),
                  )
                : new Center(
                    child: new Text("Camera inactive"),
                  ),
          ),
          Positioned(
            bottom: 0,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.transparent,
                border: Border.all(
                    color: Colors.black, width: 1.0, style: BorderStyle.solid),
              ),
              child: Container(
                color: Colors.white,
                width: MediaQuery.of(context).size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    IconButton(
                      padding: EdgeInsets.all(0),
                      icon: Icon(
                        Icons.add,
                        size: 35,
                        color: Colors.black,
                      ),
                      onPressed: () {
                        //Navigator.pop(context);
                      },
                    ),
                    SizedBox(
                      width: 35,
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.clear_all,
                        size: 35,
                      ),
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            width: 60,
            height: 60,
            bottom: 20,
            right: 15,
            child: FloatingActionButton(
              backgroundColor: Colors.white,
              child: Icon(
                Icons.qr_code_scanner_outlined,
                color: Colors.green[400],
              ),
              onPressed: () {
                setState(() {
                  camState = !camState;
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}

class ResultPage extends StatefulWidget {
  String result;
  ResultPage({@required this.result});

  @override
  _ResultPageState createState() => _ResultPageState(result: result);
}

class _ResultPageState extends State<ResultPage> {
  String result;
  _ResultPageState({@required this.result});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(result),
    );
  }
}
