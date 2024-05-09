// ignore_for_file: camel_case_types, prefer_const_constructors, prefer_const_literals_to_create_immutables, use_full_hex_values_for_flutter_colors, unused_local_variable, unused_element

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:testing/screens/button.dart';
import 'package:testing/screens/reg.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  var email = TextEditingController();
  var password = TextEditingController();

  final validation = GlobalKey<FormState>();

  Future<void> _savedata(String data) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString("StoreId", data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: validation,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 370,
                  height: 350,
                  decoration:
                      BoxDecoration(color: Color(0xffb4466b2).withOpacity(0.3)),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Log in",
                              style: TextStyle(
                                  color: Color(0xffb4466b2),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 25),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 300,
                              height: 40,
                              child: TextFormField(
                                controller: email,
                                decoration: InputDecoration(
                                    hintText: "Email",
                                    hintStyle: TextStyle(
                                        fontSize: 17,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500),
                                    prefixIcon: Icon(Icons.person),
                                    enabledBorder: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.black))),
                              ),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 40),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 300,
                              height: 40,
                              child: TextFormField(
                                controller: password,
                                decoration: InputDecoration(
                                    hintText: "Password",
                                    hintStyle: TextStyle(
                                        fontSize: 17,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500),
                                    prefixIcon: Icon(Icons.lock),
                                    enabledBorder: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.black))),
                              ),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 50),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: () async {
                                if (validation.currentState!.validate()) {
                                  String email1 = email.text.trim();
                                  String pass = password.text.trim();
                                  var querysnap = await FirebaseFirestore
                                      .instance
                                      .collection("register")
                                      .where("email", isEqualTo: email1)
                                      .limit(1)
                                      .get();

                                  if (querysnap.docs.isNotEmpty) {
                                    var userdata = querysnap.docs.first.data();
                                    if (userdata["password"] == pass) {
                                      await _savedata(userdata["StoreId"]);
                                    }
                                  }
                                }
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => MyHomePage(),
                                    ));
                              },
                              child: Container(
                                width: 300,
                                height: 40,
                                decoration:
                                    BoxDecoration(color: Color(0xffb4466b2)),
                                child: Center(
                                  child: Text(
                                    "Log in",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 18),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Signup(),
                                ));
                          },
                          child: Text("Dont't have any account"))
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
