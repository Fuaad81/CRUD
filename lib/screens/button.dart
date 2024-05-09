// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_local_variable, unused_field, avoid_unnecessary_containers

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  var name = TextEditingController();
  var activity = TextEditingController();
  late String updatetext;

  final validate = GlobalKey<FormState>();

  void addDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: TextFormField(
            controller: name,
            decoration: InputDecoration(hintText: "Name"),
          ),
          content: TextFormField(
            controller: activity,
            decoration: InputDecoration(
              hintText: "activity",
            ),
          ),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  todo();
                },
                child: Text("Save"))
          ],
        );
      },
    );
  }

  void editDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: TextFormField(
            controller: name,
            decoration: InputDecoration(hintText: "name"),
          ),
          content: TextFormField(
            controller: activity,
            decoration: InputDecoration(hintText: 'activity'),
          ),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("Cancel")),
            TextButton(
                onPressed: () {
                  if (name.text.isNotEmpty && activity.text.isNotEmpty) {
                    FirebaseFirestore.instance
                        .collection("Todo")
                        .doc(updatetext)
                        .update({'name': name.text, 'activity': activity.text});
                    name.clear();
                    activity.clear();
                    Navigator.of(context).pop();
                  }
                },
                child: Text("Update"))
          ],
        );
      },
    );
  }

  Future<void> todo() async {
    final adding = await FirebaseFirestore.instance
        .collection("Todo")
        .add({'name': name.text, 'activity': activity.text});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: validate,
          child: Stack(
            children: [
              Column(
                children: [
                  Expanded(
                    child: StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('Todo')
                          .orderBy('name')
                          .snapshots(),
                      builder:
                          (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (!snapshot.hasData) {
                          return Center(
                            child: Text("No data!!"),
                          );
                        }
                        final users = snapshot.data!.docs;
                        return ListView.builder(
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            var todo = snapshot.data!.docs[index];
                            return ListTile(
                              title: Text(todo['name']),
                              subtitle: Text(todo['activity']),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                      onPressed: () {
                                        updatetext = todo.id;
                                        name.text = todo['name'];
                                        activity.text = todo['activity'];
                                        editDialog();
                                      },
                                      icon: Icon(
                                        Icons.edit,
                                        color: Colors.blue,
                                      )),
                                  IconButton(
                                      onPressed: () {
                                        FirebaseFirestore.instance
                                            .collection("Todo")
                                            .doc(todo.id)
                                            .delete();
                                      },
                                      icon: Icon(
                                        Icons.delete_outline,
                                        color: Colors.red,
                                      ))
                                ],
                              ),
                            );
                          },
                        );
                      },
                    ),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10, right: 10),
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: FloatingActionButton(
                    onPressed: () {
                      addDialog();
                      name.clear();
                      activity.clear();
                    },
                    child: Icon(Icons.add),
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
