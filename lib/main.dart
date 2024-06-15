import 'package:flutter/material.dart';
import 'package:hust_sa/tabFragment/hometTab.dart';
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
            home: myWidget(title: 'HUST',),
            debugShowCheckedModeBanner: false,
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
    final tabsFrag = [
        homeTab(),
        Container(
            child: const Center(
                child: Text('HOME2'),
            ),
        ),
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
    ];
    @override
    Widget build(BuildContext context) {
        return Scaffold(
            body: Stack(
                children: [
                    tabsFrag[current],
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
                                            icon: ImageIcon(AssetImage('assets/images/homeicon1.png')),
                                            label: 'Trang chủ',
                                        ),
                                        BottomNavigationBarItem(
                                            icon: ImageIcon(AssetImage('assets/images/bottomiconlist.png')),
                                            label: 'Học phần',
                                        ),
                                        BottomNavigationBarItem(
                                            icon: ImageIcon(AssetImage('assets/images/news.png')),
                                            label: 'Tin tức',
                                        ),
                                        BottomNavigationBarItem(
                                            icon: ImageIcon(AssetImage('assets/images/studentuser.png')),
                                            label: 'Cá nhân',
                                        ),
                                    ],
                                    currentIndex: current,
                                    onTap: (index) {
                                        setState(() {
                                            current = index;
                                        });},
                                )
                            )
                        ),
                    )
                ],
            )
        );
    }
}
