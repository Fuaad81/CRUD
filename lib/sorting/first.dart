// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:testing/sorting/tabbarpage.dart';

class FirstPage extends StatefulWidget {
  const FirstPage({super.key});

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  var catagory = ["Fruit", "Vegitable", "Grossory"];
  String? name = "Fruit";
  var namecontroller = TextEditingController();
  var prizecontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: 300,
                height: 50,
                child: TextFormField(
                  controller: namecontroller,
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(), hintText: "name"),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: 300,
              height: 50,
              child: TextFormField(
                controller: prizecontroller,
                decoration:
                    InputDecoration(enabledBorder: OutlineInputBorder(),hintText: "prize"),
              ),
            ),
          ),
          SizedBox(
            height: 50,
            width: 200,
            child: DropdownButton(

              style: TextStyle(
                color: Colors.black,
                fontSize: 20
              ),
                value: name,
                icon: Icon(Icons.keyboard_arrow_down),
                items: catagory.map((String catagory) {
                  return DropdownMenuItem(
                      value: catagory, child: Text(catagory));
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    name = newValue;
                  });
                }),
          ),
          ElevatedButton(
              onPressed: () {
                FirebaseFirestore.instance.collection("fruitlist").add({
                  "name": namecontroller.text,
                  "prize": prizecontroller.text,
                  "catagory": name,
                });
                namecontroller.clear();
                prizecontroller.clear();
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Tabbarpage(),
                    ));
              },
              child: Text("Submit"))
        ],
      ),
    );
  }
}
