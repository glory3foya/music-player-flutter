import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';



class Upload extends StatefulWidget {
  @override
  State<Upload> createState() => _UploadState();
}

class _UploadState extends State<Upload> {
  TextEditingController artistname = TextEditingController();
  TextEditingController songname = TextEditingController();
  late File image,song;
  late String imagepath,songpath;

  final FirebaseStorage storage = FirebaseStorage.instance;
  late Reference ref;
  late String imageDownUrl,songDownUrl;
 
//  // Function to select an image
  Future<void> selectImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );

    if (result != null) {
      File image = File(result.files.single.path!);
      imagepath = basename(image.path);
      ref = storage.ref().child('images/$imagepath');
      await uploadFile(image, ref);
    } else {
      // User canceled the file picker
      print('User canceled the file picker');
    }
  }

// // //   // Function to select a song
  Future<void> selectSong() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.audio,
    );

    if (result != null) {
      File song = File(result.files.single.path!);
      songpath = basename(song.path);
      ref = storage.ref().child('songs/$songpath');
      await uploadFile(song, ref);
    } else {
      // User canceled the file picker
      print('User canceled the file picker');
    }
  }

 Future<String> uploadFile(File file, Reference ref)async{
  UploadTask uploadTask = ref.putFile(file);
  await uploadTask.whenComplete(() {});
  final String downloadURL = await ref.getDownloadURL();
  return downloadURL;
 }




  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: (){
                  selectImage();
                  },
                child: Text('Select Image'),
              ),
              SizedBox(width: 25),
              ElevatedButton( 
                onPressed: (){
                  selectSong();
                  },
                child: Text('Select Song'),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(30.0, 10.0, 30.0, 10.0),
            child: TextField(
              controller: songname,
              decoration: InputDecoration(
                hintText: 'Enter Song name',
              ),
            ),
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.fromLTRB(30.0, 10.0, 30.0, 10.0),
            child: TextField(
              controller: artistname,
              decoration: InputDecoration(
                hintText: 'Enter artist name',
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              // selectImage();
            }, 
            child: Text(
              'Upload',
              style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1.0),
            ),
          ),
        ],
      ),
    );
  }
}
