import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:table_calendar/table_calendar.dart';
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
    DateTime today = DateTime.now();
    void onDaySelect(DateTime day, DateTime focus) {
        setState(() {
            today = day;
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
                                            image: AssetImage('assets/images/menu.png'),
                                        ),
                                    ),
                                )
                            ],
                        ),
                    ),
                    NotificationListener<OverscrollIndicatorNotification> (
                        onNotification: (overscroll) {
                            overscroll.disallowIndicator();
                            return true;
                        },
                        child: SingleChildScrollView(
                            controller: controller,
                            physics: const ClampingScrollPhysics(),
                            child: Container(
                                margin: const EdgeInsets.only(top: 100),
                                child: Column(
                                    children: [
                                        Container(
                                            height: 102,
                                            width: double.infinity,
                                            padding: const EdgeInsets.only(bottom: 15),
                                            child: ListView(
                                                physics: const ClampingScrollPhysics(),
                                                scrollDirection: Axis.horizontal,
                                                shrinkWrap: true,
                                                children: [
                                                    Row(
                                                        mainAxisSize: MainAxisSize.min,
                                                        children: [
                                                            Container(
                                                                margin: const EdgeInsets.only(right: 12, left: 25),
                                                                child: ClipRRect(
                                                                    borderRadius: BorderRadius.circular(15),
                                                                    child: BackdropFilter(
                                                                        filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                                                                        child: Container(
                                                                            padding: const EdgeInsets.only(right: 10, top: 10, bottom: 10),
                                                                            decoration: BoxDecoration(
                                                                                borderRadius: BorderRadius.circular(15.0),
                                                                                border: Border.all(
                                                                                    width: 1.0,
                                                                                    color: Color.fromARGB(255, 255, 44, 65).withOpacity(.6),
                                                                                ),
                                                                            ),
                                                                            child: Row(
                                                                                children: [
                                                                                    Container(
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
                                                                                        padding: const EdgeInsets.only(right: 10),
                                                                                        child: const Column(
                                                                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                                                            children: [
                                                                                                Text(
                                                                                                    'Nguyễn Văn A',
                                                                                                    style: TextStyle(
                                                                                                        fontSize: 16,
                                                                                                        fontFamily: 'SFProSemiBold',
                                                                                                        color: Colors.white,
                                                                                                        fontWeight: FontWeight.bold,
                                                                                                    ),
                                                                                                ),
                                                                                                Text(
                                                                                                    '20220001',
                                                                                                    style: TextStyle(
                                                                                                        fontSize: 15,
                                                                                                        fontFamily: 'SFPro',
                                                                                                        color: Colors.white,
                                                                                                    ),
                                                                                                ),
                                                                                            ],
                                                                                        )
                                                                                    ),
                                                                                    const Image(
                                                                                        width: 10,
                                                                                        height: 10,
                                                                                        image: AssetImage('assets/images/forwardicon.png'),
                                                                                    ),
                                                                                ],
                                                                            )
                                                                        ),
                                                                    ),
                                                                ),
                                                            ),

                                                            Container(
                                                                margin: const EdgeInsets.only(right: 12, left: 12),
                                                                child: ClipRRect(
                                                                    borderRadius: BorderRadius.circular(15),
                                                                    child: BackdropFilter(
                                                                        filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                                                                        child: Container(
                                                                            padding: const EdgeInsets.only(right: 10, top: 10, bottom: 10),
                                                                            decoration: BoxDecoration(
                                                                                borderRadius: BorderRadius.circular(15.0),
                                                                                border: Border.all(
                                                                                    width: 1.0,
                                                                                    color: Color.fromARGB(255, 255, 44, 65).withOpacity(.6),
                                                                                ),
                                                                            ),
                                                                            child: Row(
                                                                                children: [
                                                                                    Container(
                                                                                        padding: const EdgeInsets.only(left: 20, right: 10),
                                                                                        child: const Column(
                                                                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                                                            children: [
                                                                                                Text(
                                                                                                    'Thông tin học tập',
                                                                                                    style: TextStyle(
                                                                                                        fontSize: 16,
                                                                                                        fontFamily: 'SFProSemiBold',
                                                                                                        color: Colors.white,
                                                                                                        fontWeight: FontWeight.bold,
                                                                                                    ),
                                                                                                ),
                                                                                                Row(
                                                                                                    children: [
                                                                                                        Column(
                                                                                                            children: [
                                                                                                                Text(
                                                                                                                    'GPA: 3.0',
                                                                                                                    style: TextStyle(
                                                                                                                        fontSize: 15,
                                                                                                                        fontFamily: 'SFPro',
                                                                                                                        color: Colors.white,
                                                                                                                    ),
                                                                                                                ),
                                                                                                                Text(
                                                                                                                    'CPA: 3.0',
                                                                                                                    style: TextStyle(
                                                                                                                        fontSize: 15,
                                                                                                                        fontFamily: 'SFPro',
                                                                                                                        color: Colors.white,
                                                                                                                    ),
                                                                                                                ),
                                                                                                            ],
                                                                                                        ),
                                                                                                        const Image(
                                                                                                            width: 45,
                                                                                                            height: 18,
                                                                                                            image: AssetImage('assets/images/invisibleeyeicon.png'),
                                                                                                        ),
                                                                                                    ],
                                                                                                )

                                                                                            ],
                                                                                        )
                                                                                    ),
                                                                                    const Image(
                                                                                        width: 10,
                                                                                        height: 10,
                                                                                        image: AssetImage('assets/images/forwardicon.png'),
                                                                                    ),
                                                                                ],
                                                                            )
                                                                        ),
                                                                    ),
                                                                ),
                                                            ),

                                                            Container(
                                                                margin: const EdgeInsets.only(right: 25, left: 12),
                                                                child: ClipRRect(
                                                                    borderRadius: BorderRadius.circular(15),
                                                                    child: BackdropFilter(
                                                                        filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                                                                        child: Container(
                                                                            padding: const EdgeInsets.only(right: 10, top: 10, bottom: 10),
                                                                            decoration: BoxDecoration(
                                                                                borderRadius: BorderRadius.circular(15.0),
                                                                                border: Border.all(
                                                                                    width: 1.0,
                                                                                    color: Color.fromARGB(255, 255, 44, 65).withOpacity(.6),
                                                                                ),
                                                                            ),
                                                                            child: Row(
                                                                                children: [
                                                                                    Container(
                                                                                        padding: const EdgeInsets.only(left: 20, right: 10),
                                                                                        child: const Column(
                                                                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                                                            children: [
                                                                                                Text(
                                                                                                    'Thông tin điểm rèn luyện',
                                                                                                    style: TextStyle(
                                                                                                        fontSize: 16,
                                                                                                        fontFamily: 'SFProSemiBold',
                                                                                                        color: Colors.white,
                                                                                                        fontWeight: FontWeight.bold,
                                                                                                    ),
                                                                                                ),
                                                                                                Row(
                                                                                                    children: [
                                                                                                        Text(
                                                                                                            'Điểm rèn luyện: 70',
                                                                                                            style: TextStyle(
                                                                                                                fontSize: 15,
                                                                                                                fontFamily: 'SFPro',
                                                                                                                color: Colors.white,
                                                                                                            ),
                                                                                                        ),
                                                                                                        const Image(
                                                                                                            width: 45,
                                                                                                            height: 18,
                                                                                                            image: AssetImage('assets/images/invisibleeyeicon.png'),
                                                                                                        ),
                                                                                                    ],
                                                                                                )

                                                                                            ],
                                                                                        )
                                                                                    ),
                                                                                    const Image(
                                                                                        width: 10,
                                                                                        height: 10,
                                                                                        image: AssetImage('assets/images/forwardicon.png'),
                                                                                    ),
                                                                                ],
                                                                            )
                                                                        ),
                                                                    ),
                                                                ),
                                                            ),
                                                        ],
                                                    )
                                                ],
                                            ),
                                        ),
                                        Container(
                                            padding: const EdgeInsets.only(left: 15, right: 15, top: 15, bottom: 15),
                                            decoration: const BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: BorderRadius.only(
                                                    topLeft: Radius.circular(25.0),
                                                    topRight: Radius.circular(25.0),
                                                ),
                                            ),
                                            child: Container(
                                                padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                                                decoration: const BoxDecoration(
                                                    color: Color(0xFFF8F9FD),
                                                    borderRadius: BorderRadius.only(
                                                        topLeft: Radius.circular(20.0),
                                                        topRight: Radius.circular(20.0),
                                                        bottomLeft: Radius.circular(20.0),
                                                        bottomRight: Radius.circular(20.0),
                                                    ),
                                                    boxShadow: [
                                                        BoxShadow(
                                                            color: Colors.grey,
                                                            offset: Offset(0.0, 0.5), //(x,y)
                                                            blurRadius: 5.0,
                                                        ),
                                                    ],
                                                ),
                                                child: TableCalendar(
                                                    focusedDay: today,
                                                    rowHeight: 40,
                                                    calendarFormat: CalendarFormat.week,
                                                    firstDay: DateTime.utc(2010, 10, 15),
                                                    lastDay: DateTime.utc(2050, 10, 15),
                                                    headerStyle: const HeaderStyle(
                                                        formatButtonVisible: false,
                                                        titleCentered: true,
                                                        titleTextStyle: TextStyle(
                                                            fontSize: 18,
                                                            fontFamily: 'SFProSemiBold',
                                                        ),
                                                    ),
                                                    availableGestures: AvailableGestures.all,
                                                    onDaySelected: onDaySelect,
                                                    selectedDayPredicate: (day) => isSameDay(day, today),
                                                )
                                            )
                                        ),
                                    ],
                                )
                            )
                        ),
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
                                                image: AssetImage('assets/images/menu.png'),
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
