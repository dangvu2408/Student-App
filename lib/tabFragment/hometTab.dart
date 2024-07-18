import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:table_calendar/table_calendar.dart';

import 'courseTab.dart';

class homeTab extends StatefulWidget {
    homeTab({Key? key, required this.onItemTapped}) : super(key: key);
    final Function(int) onItemTapped;
    @override
    State<homeTab> createState() => homeStateWidget();
}

class homeStateWidget extends State<homeTab> {
    ScrollController controller = ScrollController();
    bool showOverlay = false;

    @override
    void initState() {
        super.initState();
        controller.addListener(scrollListenSetting);
    }

    @override
    void dispose() {
        controller.removeListener(scrollListenSetting);
        controller.dispose();
        super.dispose();
    }
    void scrollListenSetting() {
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
    }

    DateTime today = DateTime.now();
    void onDaySelect(DateTime day, DateTime focus) {
        setState(() {
            today = day;
        });
    }
    @override
    Widget build(BuildContext context) {
        List<int> listData = List.generate(100, (index) => index + 1);
        return Scaffold(
            body: Stack(
                children: [
                    Container(
                        height: double.infinity, width: double.infinity,
                        child: const Image(
                            image: AssetImage('assets/images/homebackground.png'), fit: BoxFit.cover,
                        ),
                    ),
                    Align(
                        alignment: Alignment.bottomCenter,
                        child: FractionallySizedBox(
                            heightFactor: 0.5,
                            child: Container(
                                color: Color(0xFFF8F9FD),
                            ),
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
                                        width: 25, height: 25,
                                        child: const Image(image: AssetImage('assets/images/menu.png'),),
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
                            physics: const BouncingScrollPhysics(),
                            child: Container(
                                margin: const EdgeInsets.only(top: 100),
                                child: Column(
                                    children: [
                                        Container(
                                            height: 81,
                                            width: double.infinity,
                                            padding: const EdgeInsets.only(bottom: 15),
                                            child: ListView(
                                                physics: const BouncingScrollPhysics(),
                                                scrollDirection: Axis.horizontal,
                                                shrinkWrap: true,
                                                children: [
                                                    Row(
                                                        mainAxisSize: MainAxisSize.min,
                                                        children: [
                                                            Container(
                                                                margin: const EdgeInsets.only(right: 12, left: 25),
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
                                                                            padding: const EdgeInsets.only(right: 10, left: 10),
                                                                            child: const Column(
                                                                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                                                children: [
                                                                                    Text(
                                                                                        'Nguyễn Văn A',
                                                                                        style: TextStyle(fontSize: 16, fontFamily: 'SFProSemiBold', color: Colors.white, fontWeight: FontWeight.bold,),
                                                                                    ),
                                                                                    Text(
                                                                                        '20220001',
                                                                                        style: TextStyle(fontSize: 15, fontFamily: 'SFPro', color: Colors.white,),
                                                                                    ),
                                                                                ],
                                                                            )
                                                                        ),
                                                                    ],
                                                                )
                                                            ),

                                                            GestureDetector(
                                                                onTap: () {
                                                                    widget.onItemTapped(1);
                                                                },
                                                                child: Container(
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
                                                                                                    Text('Thông tin học tập', style: TextStyle(fontSize: 16, fontFamily: 'SFProSemiBold', color: Colors.white, fontWeight: FontWeight.bold,),),
                                                                                                    Text('GPA: 3.50 / CPA: 3.48', style: TextStyle(fontSize: 15, fontFamily: 'SFPro', color: Colors.white,),),
                                                                                                ],
                                                                                            )
                                                                                        ),
                                                                                        const Image(width: 10, height: 10, image: AssetImage('assets/images/forwardicon.png'),),
                                                                                    ],
                                                                                )
                                                                            ),
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
                                                                                border: Border.all(width: 1.0, color: Color.fromARGB(255, 255, 44, 65).withOpacity(.6),),
                                                                            ),
                                                                            child: Row(
                                                                                children: [
                                                                                    Container(
                                                                                        padding: const EdgeInsets.only(left: 20, right: 10),
                                                                                        child: const Column(
                                                                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                                                            children: [
                                                                                                Text('Thông tin điểm rèn luyện', style: TextStyle(fontSize: 16, fontFamily: 'SFProSemiBold', color: Colors.white, fontWeight: FontWeight.bold,),),
                                                                                                Text('Điểm rèn luyện: 70', style: TextStyle(fontSize: 15, fontFamily: 'SFPro', color: Colors.white,),),
                                                                                            ],
                                                                                        )
                                                                                    ),
                                                                                    const Image(width: 10, height: 10, image: AssetImage('assets/images/forwardicon.png'),),
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
                                            padding: const EdgeInsets.only(left: 15, right: 15, top: 15, bottom: 90),
                                            decoration: const BoxDecoration(
                                                color: Color(0xFFF8F9FD),
                                                borderRadius: BorderRadius.only(topLeft: Radius.circular(25.0), topRight: Radius.circular(25.0),),
                                            ),
                                            child: Column(
                                                children: [
                                                    Container(
                                                        padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                                                        decoration: const BoxDecoration(
                                                            color: Color(0xFFFFFFFF),
                                                            borderRadius: BorderRadius.only(topLeft: Radius.circular(20.0), topRight: Radius.circular(20.0), bottomLeft: Radius.circular(20.0), bottomRight: Radius.circular(20.0),),
                                                            boxShadow: [BoxShadow(color: Colors.grey, offset: Offset(0.0, 0.5), blurRadius: 5.0,),],
                                                        ),
                                                        child: Column(
                                                            children: [
                                                                Row(
                                                                    children: [
                                                                        Expanded(
                                                                            child: TableCalendar(
                                                                                focusedDay: today,
                                                                                rowHeight: 40,
                                                                                calendarFormat: CalendarFormat.week,
                                                                                firstDay: DateTime.utc(2010, 10, 15),
                                                                                lastDay: DateTime.utc(2050, 10, 15),
                                                                                headerStyle: const HeaderStyle(
                                                                                    formatButtonVisible: false,
                                                                                    titleCentered: true,
                                                                                    titleTextStyle: TextStyle(fontSize: 18, fontFamily: 'SFProSemiBold',),
                                                                                ),
                                                                                calendarStyle: const CalendarStyle(
                                                                                    defaultTextStyle: TextStyle(fontSize: 18, fontFamily: 'SFPro',),
                                                                                    todayTextStyle: TextStyle(fontSize: 18, color: Colors.white, fontFamily: 'SFProSemiBold',),
                                                                                    weekendTextStyle: TextStyle(fontSize: 18, color: Colors.black, fontFamily: 'SFPro',),
                                                                                    selectedTextStyle: TextStyle(fontSize: 18, color: Colors.white, fontFamily: 'SFProSemiBold',),
                                                                                ),
                                                                                daysOfWeekStyle: const DaysOfWeekStyle(
                                                                                    weekdayStyle: TextStyle(fontSize: 16, fontFamily: 'SFPro', color: Colors.black,),
                                                                                    weekendStyle: TextStyle(fontSize: 16, fontFamily: 'SFPro', color: Colors.black,),
                                                                                ),
                                                                                availableGestures: AvailableGestures.all,
                                                                                onDaySelected: onDaySelect,
                                                                                selectedDayPredicate: (day) => isSameDay(day, today),
                                                                            ),
                                                                        ),
                                                                    ],
                                                                ),
                                                                SizedBox(
                                                                    height: 400,
                                                                    child: ListView.separated(
                                                                        physics: const NeverScrollableScrollPhysics(),
                                                                        itemBuilder: (context, index) {
                                                                            return Container(
                                                                                height: 50,
                                                                                decoration: const BoxDecoration(
                                                                                    color: Color(0xFFf3eded),
                                                                                    borderRadius: BorderRadius.only(topLeft: Radius.circular(15.0), topRight: Radius.circular(15.0), bottomRight: Radius.circular(15.0), bottomLeft: Radius.circular(15.0)),
                                                                                ),
                                                                                child: Center(child:
                                                                                Text('Item thứ ${listData[index]}'),),
                                                                            );
                                                                        },
                                                                        separatorBuilder: (context, index) => const SizedBox(height: 10,),
                                                                        itemCount: 6
                                                                    ),
                                                                )
                                                            ],
                                                        ),
                                                    ),
                                                    SizedBox(
                                                        height: 350,
                                                        child: GridView.count(
                                                            crossAxisCount: 2,
                                                            crossAxisSpacing: 15,
                                                            mainAxisSpacing: 15,
                                                            physics: NeverScrollableScrollPhysics(),
                                                            children: [
                                                                Container(
                                                                    child: Column(
                                                                        children: [
                                                                            Container(
                                                                                padding: const EdgeInsets.all(10),
                                                                                margin: const EdgeInsets.all(10),
                                                                                decoration: const BoxDecoration(
                                                                                    color: Color(0xFFFFFFFF),
                                                                                    borderRadius: BorderRadius.only(topLeft: Radius.circular(20.0), topRight: Radius.circular(20.0), bottomLeft: Radius.circular(20.0), bottomRight: Radius.circular(20.0),),
                                                                                    boxShadow: [BoxShadow(color: Colors.grey, offset: Offset(0.0, 0.5), blurRadius: 5.0,),],
                                                                                ),
                                                                                child: const Image(width: 45, height: 45, image: AssetImage('assets/images/calendar1.png'),),
                                                                            ),
                                                                            Text('Thời khóa biểu', textAlign: TextAlign.center, style: TextStyle(fontSize: 18, fontFamily: 'SFProSemiBold', color: Colors.black, fontWeight: FontWeight.bold,),),
                                                                            Text('Tra cứu thời khóa biểu, lịch thi', textAlign: TextAlign.center, style: TextStyle(fontSize: 16, fontFamily: 'SFPro', color: Colors.black, ),),
                                                                        ],
                                                                    )
                                                                ),
                                                                Container(
                                                                    child: Column(
                                                                        children: [
                                                                            Container(
                                                                                padding: const EdgeInsets.all(10),
                                                                                margin: const EdgeInsets.all(10),
                                                                                decoration: const BoxDecoration(
                                                                                    color: Color(0xFFFFFFFF),
                                                                                    borderRadius: BorderRadius.only(topLeft: Radius.circular(20.0), topRight: Radius.circular(20.0), bottomLeft: Radius.circular(20.0), bottomRight: Radius.circular(20.0),),
                                                                                    boxShadow: [BoxShadow(color: Colors.grey, offset: Offset(0.0, 0.5), blurRadius: 5.0,),],
                                                                                ),
                                                                                child: const Image(width: 45, height: 45, image: AssetImage('assets/images/settingcalendar.png'),),
                                                                            ),
                                                                            Text('Sắp xếp TKB', textAlign: TextAlign.center, style: TextStyle(fontSize: 18, fontFamily: 'SFProSemiBold', color: Colors.black, fontWeight: FontWeight.bold,),),
                                                                            Text('Sắp xếp, chỉnh sửa thời khóa biểu', textAlign: TextAlign.center, style: TextStyle(fontSize: 16, fontFamily: 'SFPro', color: Colors.black, ),),
                                                                        ],
                                                                    )
                                                                ),
                                                                Container(
                                                                    child: Column(
                                                                        children: [
                                                                            Container(
                                                                                padding: const EdgeInsets.all(10),
                                                                                margin: const EdgeInsets.all(10),
                                                                                decoration: const BoxDecoration(
                                                                                    color: Color(0xFFFFFFFF),
                                                                                    borderRadius: BorderRadius.only(topLeft: Radius.circular(20.0), topRight: Radius.circular(20.0), bottomLeft: Radius.circular(20.0), bottomRight: Radius.circular(20.0),),
                                                                                    boxShadow: [BoxShadow(color: Colors.grey, offset: Offset(0.0, 0.5), blurRadius: 5.0,),],
                                                                                ),
                                                                                child: const Image(width: 45, height: 45, image: AssetImage('assets/images/listcourse1.png'),),
                                                                            ),
                                                                            Text('Danh mục học phần', textAlign: TextAlign.center, style: TextStyle(fontSize: 18, fontFamily: 'SFProSemiBold', color: Colors.black, fontWeight: FontWeight.bold,),),
                                                                            Text('Tra cứu học phần trong chương trình đào tạo', textAlign: TextAlign.center, style: TextStyle(fontSize: 16, fontFamily: 'SFPro', color: Colors.black, ),),
                                                                        ],
                                                                    )
                                                                ),
                                                                Container(
                                                                    child: Column(
                                                                        children: [
                                                                            Container(
                                                                                padding: const EdgeInsets.all(10),
                                                                                margin: const EdgeInsets.all(10),
                                                                                decoration: const BoxDecoration(
                                                                                    color: Color(0xFFFFFFFF),
                                                                                    borderRadius: BorderRadius.only(topLeft: Radius.circular(20.0), topRight: Radius.circular(20.0), bottomLeft: Radius.circular(20.0), bottomRight: Radius.circular(20.0),),
                                                                                    boxShadow: [BoxShadow(color: Colors.grey, offset: Offset(0.0, 0.5), blurRadius: 5.0,),],
                                                                                ),
                                                                                child: const Image(width: 45, height: 45, image: AssetImage('assets/images/dollar1.png'),),
                                                                            ),
                                                                            Text('Học phí - Công nợ', textAlign: TextAlign.center, style: TextStyle(fontSize: 18, fontFamily: 'SFProSemiBold', color: Colors.black, fontWeight: FontWeight.bold,),),
                                                                            Text('Tra cứu thông tin về học phí, công nợ', textAlign: TextAlign.center, style: TextStyle(fontSize: 16, fontFamily: 'SFPro', color: Colors.black, ),),
                                                                        ],
                                                                    )
                                                                ),
                                                            ],
                                                        )
                                                    )
                                                ],
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
                                            height: 40, child: const Image(image: AssetImage('assets/images/logofull.png'),),
                                        ),
                                        Container(
                                            width: 25, height: 25, child: const Image(image: AssetImage('assets/images/menu.png'),),
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
