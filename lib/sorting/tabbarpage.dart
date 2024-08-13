// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:testing/sorting/firsttab.dart';
import 'package:testing/sorting/secoundtab.dart';

class Tabbarpage extends StatefulWidget {
  const Tabbarpage({super.key});

  @override
  State<Tabbarpage> createState() => _TabbarpageState();
}

class _TabbarpageState extends State<Tabbarpage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            toolbarHeight: 80,
            automaticallyImplyLeading: false,
            title: TabBar(
                indicatorSize: TabBarIndicatorSize.label,
                indicatorWeight: 2,
                tabs: [
                  Text(
                    "Fruit",
                    style: TextStyle(fontSize: 20),
                  ),
                  Text(
                    "Vegitable",
                    style: TextStyle(fontSize: 20),
                  ),
                  Text(
                    "Grossory",
                    style: TextStyle(fontSize: 20),
                  )
                ]),
          ),
          body: TabBarView(children: [
            FirstTab(),
            SecoundTab(),
            FirstTab(),
          ]),
        ),
      ),
    );
  }
}
