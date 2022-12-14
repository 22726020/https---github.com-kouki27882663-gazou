import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:photograph/display.dart';
import 'package:photograph/get.dart';
import 'package:quiver/async.dart';
import 'package:url_launcher/url_launcher.dart';

Future<void> main() async {
  // main 関数内で非同期処理を呼び出すため
  WidgetsFlutterBinding.ensureInitialized();
  // デバイスで使用可能なカメラのリストを取得
  final cameras = await availableCameras();
  // 利用可能なカメラのリストから特定のカメラを取得
  final firstCamera = cameras.first;
  runApp(MyApp(camera: firstCamera));
}

class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
    required this.camera,
  }) : super(key: key);
  final CameraDescription camera;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:  MyHomePage(camera:camera,title: '抱っこアプリ'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.camera,required this.title}) : super(key: key);

  final String title;
  final CameraDescription camera;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(centerTitle: true,title: new Text(widget.title,style:TextStyle(color: Colors.black)),
        backgroundColor: Color.fromARGB(255, 174, 168, 167)),
        body: new Stack(
          children: <Widget>[
            new Container(
              decoration: new BoxDecoration(
                image: new DecorationImage(
                  image: new NetworkImage(
                      "https://www.angeliebe.co.jp/html/upload/save_image/product/50460/50460-190_l4.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(top: 32),
              child: Text('選択してください',style: TextStyle(fontSize: 30),),
            ),
           
           SizedBox(height: 150,),
            Row(
              
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                ElevatedButton(
                  onPressed: (){},
                  style: ElevatedButton.styleFrom(
                    primary: Color.fromARGB(255, 214, 204, 203),
                    elevation: 26,
                  ),
                  child: Text('基本情報入力',style: TextStyle(color: Colors.black)),
                ),
                ElevatedButton(
                  onPressed: _opneUrl,
                  style: ElevatedButton.styleFrom(
                    primary: Color.fromARGB(255, 214, 204, 203),
                    elevation: 26,
                  ),
                  child: Text('アンケート入力',style: TextStyle(color: Colors.black)),
                ),
                // ElevatedButton(
                //   onPressed: () {},
                //   style: ElevatedButton.styleFrom(
                //     primary: Color.fromARGB(255, 214, 204, 203),
                //     elevation: 26,
                //   ),
                //   child: Text('抱っこ撮影',style: TextStyle(color: Colors.black),),
                // ),
                ElevatedButton(
                  onPressed: (){
                    Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => TakePictureScreen(camera:widget.camera),
              )
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Color.fromARGB(255, 214, 204, 203),
                    elevation: 16,
                  ),
                  child: Text('抱っこ撮影',style: TextStyle(color: Colors.black)),
                ),
              ],
            ),
          ],
        ),
            // ElevatedButton(
            //   onPressed: () { },
            //   child: Text('基本情報の登録',style:TextStyle(color: Colors.black)),
            //   )
          ],
        )
    );
  }
    void _opneUrl() async {
    final url = Uri.parse('https://docs.google.com/forms/d/168uxibsGbr7ciBM2FsLRksgxEMEkJ_TzCcePeq9n82s/edit?usp=sharing'); //←ここに表示させたいURLを入力する
    if (await canLaunchUrl(url)) {
      await launchUrl(
        url,
      );
    } else {
      throw 'このURLにはアクセスできません';
    }
  }
}