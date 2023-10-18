import 'package:flutter/material.dart';
import 'package:wr_music/screens/Home.dart';
import 'package:wr_music/screens/upload.dart';


void main(){
  runApp(Music());
}

class Music extends StatefulWidget{
  @override
  _MusicState createState()=> _MusicState();
}

class _MusicState extends State<Music>{
  int currentindex = 0;
  //initializing the bottom nav items in the list
  List tabs = [
    Home(),
    Upload(),
  ];
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Wr-Music",
      theme: ThemeData(
        primarySwatch: Colors.grey,
        primaryColor: Colors.grey.shade600,
        fontFamily: 'Inria',
        textTheme: const TextTheme(
          bodyMedium: TextStyle(fontSize: 20.0,
          letterSpacing: 1.0),
        ),
        
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text("Wr-Music",
          style: TextStyle(fontFamily:'Inria', fontWeight: FontWeight.bold ),
          ),
        ),
        body: tabs[currentindex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: currentindex,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.cloud_upload),
              label: 'Upload',
            )
          ],
          onTap: (index){
            setState(() {
              currentindex=index;
            });
           
          },
        ),
        ),
    );
  }
}