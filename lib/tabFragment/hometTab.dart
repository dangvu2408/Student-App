import 'dart:ui';

import 'package:flutter/material.dart';

class homeTab extends StatefulWidget {
    homeTab({Key? key}) : super(key: key);

    @override
    State<homeTab> createState() => homeStateWidget();
}

class homeStateWidget extends State<homeTab> {
    ScrollController controller = ScrollController();
    bool showOverlay = false;

    @override
    void initState() {
        super.initState();
        controller.addListener(() {
            if (controller.offset >= 10) {
                if (!showOverlay) {
                    setState(() {
                        showOverlay = true;
                    });
                }
            } else {
                if (showOverlay) {
                    setState(() {
                        showOverlay = false;
                    });
                }
            }
        });
    }

    @override
    void dispose() {
        controller.dispose();
        super.dispose();
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
                    Container(
                        margin: const EdgeInsets.only(top: 40, right: 25, bottom: 15, left: 25),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                                Flexible(
                                    child: Container(
                                        height: 40,
                                        child: const Image(
                                            image: AssetImage('assets/images/logofull.png'),
                                        ),
                                    ),
                                ),
                                Flexible(
                                    child: Container(
                                        width: 25,
                                        height: 25,
                                        child: const Image(
                                            image: AssetImage('assets/images/settingicon.png'),
                                        ),
                                    ),
                                )
                            ],
                        ),
                    ),
                    SingleChildScrollView(
                        controller: controller,
                        child: Container(
                            margin: const EdgeInsets.only(top: 100),
                            child: Column(
                                children: [
                                    Container(
                                        height: 80,
                                        width: double.infinity,
                                        padding: const EdgeInsets.only(bottom: 15),
                                        child: ListView(
                                            scrollDirection: Axis.horizontal,
                                            children: [
                                                Container(
                                                    padding: const EdgeInsets.only(left: 25),
                                                    child: const CircleAvatar(
                                                        radius: 45,
                                                        backgroundColor: Color(0xFFD80015),
                                                        child: Padding(
                                                            padding: EdgeInsets.all(2), // Border radius
                                                            child: ClipOval(
                                                                child:
                                                                Image(
                                                                    image: AssetImage('assets/images/defaultavt.jpg'),
                                                                ),
                                                            ),
                                                        ),
                                                    ),
                                                ),
                                                Container(
                                                    child: ClipRRect(
                                                        borderRadius: BorderRadius.circular(15),
                                                        child: BackdropFilter(
                                                            filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                                                            child: Container(
                                                                width: 100,
                                                                decoration: BoxDecoration(
                                                                    borderRadius: BorderRadius.circular(15.0),
                                                                    border: Border.all(
                                                                        width: 1.0,
                                                                        color: Color(0xFFD80015).withOpacity(0.3),
                                                                    ),
                                                                    color: Color(0xFFD80015).withOpacity(0.1),
                                                                ),
                                                            ),
                                                        ),
                                                    ),
                                                ),
                                                Image(
                                                    image: AssetImage('assets/images/logofull.png'),
                                                ),
                                            ],
                                        ),
                                    ),
                                    Container(
                                        height: MediaQuery.of(context).size.height,
                                        decoration: const BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(25.0),
                                                topRight: Radius.circular(25.0),
                                            ),
                                        ),
                                    ),
                                ],
                            )

                        )
                    ),
                    Positioned(
                        top: 0,
                        left: 0,
                        right: 0,
                        child: AnimatedOpacity(
                            opacity: showOverlay ? 1.0 : 0.0,
                            duration: const Duration(milliseconds: 300),
                            child: Container(
                                padding: const EdgeInsets.only(top: 40, right: 25, bottom: 15, left: 25),
                                color: Color(0xFFD80015),
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                        Container(
                                            height: 40,
                                            child: const Image(
                                                image: AssetImage('assets/images/logofull.png'),
                                            ),
                                        ),
                                        Container(
                                            width: 25,
                                            height: 25,
                                            child: const Image(
                                                image: AssetImage('assets/images/settingicon.png'),
                                            ),
                                        ),
                                    ],
                                ),
                            ),
                        ),
                    )
                ],
            ),
        );
    }
}
