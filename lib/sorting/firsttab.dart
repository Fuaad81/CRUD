// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FirstTab extends StatefulWidget {
  const FirstTab({super.key});

  @override
  State<FirstTab> createState() => _FirstTabState();
}

class _FirstTabState extends State<FirstTab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('fruitlist')
            .where("catagory", isEqualTo: "Fruit")
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: Text("No data!!"),
            );
          }
          return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                var fruit = snapshot.data!.docs[index];
                return Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10,bottom: 10),
                  child: ListTile(
                    onLongPress: () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text("Are you want delete?"),
                          titleTextStyle:
                              TextStyle(fontSize: 18, color: Colors.black),
                          content: Text("are you sure you want delete this"),
                          actions: [
                            TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text("Cancel")),
                            TextButton(
                                onPressed: () {
                                  FirebaseFirestore.instance
                                      .collection("fruitlist")
                                      .doc(fruit.id)
                                      .delete();
                                  Navigator.pop(context);
                                },
                                child: Text("Delete"))
                          ],
                        ),
                      );
                    },
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    tileColor: Colors.grey.shade400,
                    title: Text(
                      fruit["name"],
                      style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),
                    ),
                    subtitle: Text(
                      fruit["prize"],
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                );
              });
        },
      ),
    );
  }
}
