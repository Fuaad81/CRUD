// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, empty_catches, unused_local_variable, avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:testing/screens/smap.dart';

class Logsamp extends StatefulWidget {
  const Logsamp({super.key});

  @override
  State<Logsamp> createState() => _LogsampState();
}

class _LogsampState extends State<Logsamp> {
  final _formkey = GlobalKey<FormState>();
  TextEditingController email = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: _formkey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 50),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 300,
                      child: TextFormField(
                        controller: email,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'enter email address';
                          }
                          return null;
                        },
                        style: TextStyle(
                          color: Colors.black,
                        ),
                        decoration: InputDecoration(
                            hintText: "email",
                            hintStyle: TextStyle(color: Colors.black),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black)),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black))),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                        onPressed: () async {
                          if (_formkey.currentState?.validate() ?? true) {
                            bool emailExists =
                                await checkEmailExists(email.text);
                            if (emailExists) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (ctx) =>
                                      StoreResetPassword(email: email.text),
                                ),
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text("email not found")),
                              );
                            }
                          }
                        },
                        child: Text("Submit")),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

Future<bool> checkEmailExists(String email) async {
  try {
    // Query Firestore collection "storekeeper" for the provided email
    var querySnapshot = await FirebaseFirestore.instance
        .collection('register')
        .where('email', isEqualTo: email)
        .get();
    // Check if any documents match the provided email
    return querySnapshot.docs.isNotEmpty;
  } catch (e) {
    print("Error checking email: $e");
    return false;
  }
}
