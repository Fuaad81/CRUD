// ignore_for_file: prefer_const_constructors, unused_local_variable, empty_catches, unnecessary_brace_in_string_interps, avoid_print, non_constant_identifier_names, prefer_typing_uninitialized_variables

import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Checking extends StatefulWidget {
  const Checking({super.key});

  @override
  State<Checking> createState() => _CheckingState();
}

class _CheckingState extends State<Checking> {
  var image_url;
  File? image;
  Future<void> picker() async {
    final pickedfile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedfile != null) {
        image = File(pickedfile.path);
      } else {
        print("no image select");
      }
    });
  }

  Future<void> uploadimage() async {
    if (image != null) {
      try {
        final ref = firebase_storage.FirebaseStorage.instance
            .ref()
            .child('product image')
            .child(DateTime.now().millisecondsSinceEpoch.toString());
            await ref.putFile(image!);

            image_url = await ref.getDownloadURL();
      } catch (e) {
        print("error ${e}");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
              child: CircleAvatar(
            radius: 50,
            backgroundImage: image != null ? FileImage(image!) : null,
          )),
          IconButton(
              onPressed: () {
                picker();
              },
              icon: Icon(Icons.add)),
              
        ],
      ),
      floatingActionButton: FloatingActionButton(onPressed: (){
        uploadimage();
      },child: Text("Save"),),
    );
  }
}
