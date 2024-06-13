import 'package:flutter/material.dart';

class homeTab extends StatelessWidget {
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
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                            Flexible(
                                child: Container(
                                    margin: const EdgeInsets.symmetric(vertical: 25, horizontal: 0),
                                    width: double.infinity,
                                    height: 90,
                                    child: const Image(
                                        image: AssetImage('assets/images/logofull.png'),
                                    ),
                                ),
                            ),
                            Flexible(
                                child: Container(
                                    margin: const EdgeInsets.symmetric(vertical: 25, horizontal: 25),
                                    width: 25,
                                    child: const Image(
                                        image: AssetImage('assets/images/settingicon.png'),
                                    ),
                                ),
                            )
                        ],
                    ),
                    Positioned(
                        top: 0,
                        left: 0,
                        right: 0,
                        child: Container(
                            height: 800,
                            margin: const EdgeInsets.symmetric(vertical: 180, horizontal: 0),
                            decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20.0),
                                    topRight: Radius.circular(20.0),
                                ),
                            ),
                        )
                    )
                ],
            ),
        );
    }
}