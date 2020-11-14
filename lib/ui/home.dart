import 'package:flutter/material.dart';
import 'package:tgi/ui/vigota.dart';
import 'package:tgi/ui/concreto.dart';
import 'package:tgi/ui/malha.dart';
import 'package:tgi/widgets/custom_drawer.dart';
import 'dart:async';


class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _pageController = PageController();
  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: _pageController,
      physics: NeverScrollableScrollPhysics(),
      children: <Widget>[
       Scaffold(
        drawer: CustomDrawer(_pageController),
        backgroundColor: Colors.blueAccent,
        appBar: AppBar(
          title: Text(" Viga "),
          backgroundColor: Colors.blueAccent,
          centerTitle: true,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(30),
            ),
          ),
        ),
        body: Vigota()
       ),
        Scaffold(
            backgroundColor: Colors.blueAccent,
            appBar: AppBar(
              title: Text(" Concreto "),
              backgroundColor: Colors.blueAccent,
              centerTitle: true,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(30),
                ),
              ),
            ),
            drawer: CustomDrawer(_pageController),
            body: Concreto()
        ),
        Scaffold(
            backgroundColor: Colors.blueAccent,
            appBar: AppBar(
              title: Text(" Malha "),
              backgroundColor: Colors.blueAccent,
              centerTitle: true,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(30),
                ),
              ),
            ),
            drawer: CustomDrawer(_pageController),
            body: Malha()
        ),
    ]
    );
  }
}



