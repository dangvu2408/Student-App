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
                    Container(
                        margin: const EdgeInsets.only(top: 25, right: 25),
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
                        child: Positioned(
                            top: 0,
                            left: 0,
                            right: 0,
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
                    ),
                ],
            ),
        );
    }
}