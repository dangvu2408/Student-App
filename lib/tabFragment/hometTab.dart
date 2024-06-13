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
            if (controller.offset >= 100) {
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
                        margin: const EdgeInsets.only(top: 15, right: 25),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                                Flexible(
                                    child: Container(
                                        width: double.infinity,
                                        height: 90,
                                        child: const Image(
                                            image: AssetImage('assets/images/logofull.png'),
                                        ),
                                    ),
                                ),
                                Flexible(
                                    child: Container(
                                        width: 25,
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
                            height: MediaQuery.of(context).size.height,
                            margin: const EdgeInsets.only(top: 180),
                            decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(25.0),
                                    topRight: Radius.circular(25.0),
                                ),
                            ),
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
                                padding: const EdgeInsets.only(top: 15, right: 25),
                                color: Color(0xFFD80015),
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                        Flexible(
                                            child: Container(
                                                width: double.infinity,
                                                height: 90,
                                                child: const Image(
                                                    image: AssetImage('assets/images/logofull.png'),
                                                ),
                                            ),
                                        ),
                                        Flexible(
                                            child: Container(
                                                width: 25,
                                                child: const Image(
                                                    image: AssetImage('assets/images/settingicon.png'),
                                                ),
                                            ),
                                        )
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
