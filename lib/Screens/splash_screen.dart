// ignore_for_file: prefer_const_constructors

import 'package:filtero/Screens/home_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: Drawer(),
        appBar: AppBar(
          elevation: 15,
          actions: [
            IconButton(onPressed: () {}, icon: Icon(Icons.arrow_back_sharp))
          ],
          centerTitle: true,
          backgroundColor: Colors.deepPurple.shade900,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          bottom: PreferredSize(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: const [
                      Padding(
                        padding: EdgeInsets.only(bottom: 30),
                        child: Text(
                          'Welcome to AR',
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  )
                ],
              ),
              preferredSize: const Size.fromHeight(50)),
        ),
        body: Center(
          child: ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => HomePage(),
                ),
              );
            },
            child: Text('Click Here'),
            style: ElevatedButton.styleFrom(
              minimumSize: Size(200, 50),
              primary: Colors.deepPurple.shade900,
            ),
          ),
        ));
  }
}
