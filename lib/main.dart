import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hust_sa/navigator/loginProperties.dart';
import 'package:hust_sa/tabFragment/hometTab.dart';
import 'package:hust_sa/tabFragment/courseTab.dart';
import 'package:page_transition/page_transition.dart';
import 'package:loading_indicator/loading_indicator.dart';
void main() {
    runApp(myApp());
}

class myApp extends StatelessWidget {
    @override
    Widget build(BuildContext context) {
        return MaterialApp(
            title: 'Flutter App',
            theme: ThemeData(
                primaryColor: Color(0xFFD80015),
                fontFamily: 'SFPro',
            ),
            home: splashScreen(),
            debugShowCheckedModeBanner: false,
        );
    }
}

class splashScreen extends StatefulWidget {
    @override
    splashScreenState createState() => splashScreenState();
}

class splashScreenState extends State<splashScreen> {
    @override
    void initState() {
        super.initState();
        Timer(const Duration(milliseconds: 2000), () {
            Navigator.push(context, PageTransition(
                type: PageTransitionType.fade,
                child: loginActivity(),
                duration: const Duration(milliseconds: 2000),
            ));
        });
    }
    @override
    Widget build(BuildContext context) {
        return Scaffold(
            body: Stack(
                children: [
                    Container(
                        height: double.infinity,
                        width: double.infinity,
                        child: const Image(
                            image: AssetImage('assets/images/homebackground.png'),
                            fit: BoxFit.cover,
                        ),
                    ),
                    Center(
                        child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 80),
                            child: const Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                    LinearProgressIndicator(
                                        backgroundColor: Colors.white,
                                        color: Color(0xFFD80015),
                                    )
                                ],
                            ),
                        ),
                    )
                ],
            )
        );
    }
}

class myWidget extends StatefulWidget {
    myWidget({Key? key, required this.title}) : super(key: key);
    final String title;
    @override
    homeState createState() => homeState();
}

class homeState extends State<myWidget> {
    int current = 0;
    PageController pageController = PageController();
    void _onItemTapped(int index) {
        setState(() {
            current = index;
        });
        pageController.jumpToPage(index);
    }
    @override
    Widget build(BuildContext context) {
        return Scaffold(
            body: Stack(
                children: [
                    PageView(
                        controller: pageController,
                        onPageChanged: (index) {
                            setState(() {
                                current = index;
                            });
                        },
                        children: <Widget>[
                            homeTab(onItemTapped: _onItemTapped),
                            courseTab(),
                            Container(
                                child: const Center(
                                    child: Text('HOME3'),
                                ),
                            ),
                            Container(
                                child: const Center(
                                    child: Text('HOME4'),
                                ),
                            ),
                        ],
                    ),
                    Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Container(
                            margin: const EdgeInsets.only(bottom: 15, right: 15, left: 15),
                            decoration: const BoxDecoration(
                                boxShadow: [
                                    BoxShadow(color: Color.fromARGB(255, 128, 127, 127), spreadRadius: 0, blurRadius: 8),
                                ],
                            ),
                            child: ClipRRect(
                                borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(15.0),
                                    topRight: Radius.circular(15.0),
                                    bottomLeft: Radius.circular(15.0),
                                    bottomRight: Radius.circular(15.0),
                                ),
                                child: BottomNavigationBar(
                                    backgroundColor: Color(0xFFD80015),
                                    fixedColor: Colors.white,
                                    type: BottomNavigationBarType.fixed,
                                    unselectedItemColor: Color(0xFFFF7E89),
                                    iconSize: 20,
                                    selectedLabelStyle: const TextStyle(
                                        fontFamily: 'SFPro',
                                        fontWeight: FontWeight.bold,
                                        fontSize: 17,
                                        color: Colors.white,
                                    ),
                                    unselectedLabelStyle: const TextStyle(
                                        fontFamily: 'SFPro',
                                        fontWeight: FontWeight.normal,
                                        fontSize: 17,
                                        color: Color(0xFFFF7E89),
                                    ),
                                    items: const [
                                        BottomNavigationBarItem(
                                            icon: ImageIcon(AssetImage('assets/images/home.png')),
                                            label: 'Trang chủ',
                                        ),
                                        BottomNavigationBarItem(
                                            icon: ImageIcon(AssetImage('assets/images/server.png')),
                                            label: 'Học tập',
                                        ),
                                        BottomNavigationBarItem(
                                            icon: ImageIcon(AssetImage('assets/images/drl.png')),
                                            label: 'Rèn luyện',
                                        ),
                                        BottomNavigationBarItem(
                                            icon: ImageIcon(AssetImage('assets/images/grid.png')),
                                            label: 'Tiện ích',
                                        ),
                                    ],
                                    currentIndex: current,
                                    onTap: _onItemTapped,
                                )
                            )
                        ),
                    )
                ],
            )
        );
    }
}
