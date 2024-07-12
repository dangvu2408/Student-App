import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';

class courseTab extends StatefulWidget {
    courseTab({Key? key}) : super(key: key);
    @override
    State<courseTab> createState() => courseStateWidget();
}

class courseStateWidget extends State<courseTab> {
    late TooltipBehavior _tooltipBehavior;

    @override
    void initState(){
        _tooltipBehavior = TooltipBehavior(enable: true);
        super.initState();
    }

    ScrollController controller = ScrollController();
    bool showOverlay = false;
    @override

    @override
    void dispose() {
      controller.dispose();
      super.dispose();
    }

    @override
    Widget build(BuildContext context) {
        List<int> listData = List.generate(100, (index) => index + 1);
        return Scaffold(
            body: Stack(
                children: [
                    NotificationListener<OverscrollIndicatorNotification> (
                        onNotification: (overscroll) {
                            overscroll.disallowIndicator();
                            return true;
                        },
                        child: SingleChildScrollView(
                          controller: controller,
                          physics: const BouncingScrollPhysics(),
                            child: Container(
                                margin: const EdgeInsets.only(top: 100, bottom: 40),
                                padding: const EdgeInsets.only(left: 15, right: 15),
                                child: Column(
                                    children: [
                                        Container(
                                            height: 250,
                                            width: double.infinity,
                                            child: SfCartesianChart(
                                                primaryXAxis: CategoryAxis(),
                                                title: const ChartTitle(
                                                    text: 'Điểm trung bình các học kì (GPA)',
                                                    textStyle: TextStyle(
                                                        color: Color(0xFFD80015),
                                                        fontFamily: 'SFProSemiBold',
                                                        fontSize: 14,
                                                    ),
                                                    alignment: ChartAlignment.near,
                                                ),
                                                legend: Legend(isVisible: true),
                                                tooltipBehavior: _tooltipBehavior,
                                                series: <LineSeries<SalesData, String>>[
                                                    LineSeries<SalesData, String>(
                                                        name:'GPA',
                                                        color: Color(0xFFD80015),
                                                        dataSource:  <SalesData>[
                                                          SalesData('20221', 3.85),
                                                          SalesData('20222', 3.08),
                                                          SalesData('20231', 3.50),
                                                          SalesData('20232', 3.42),
                                                        ],
                                                        xValueMapper: (SalesData sales, _) => sales.year,
                                                        yValueMapper: (SalesData sales, _) => sales.sales,
                                                        dataLabelSettings: DataLabelSettings(isVisible: true)
                                                    )
                                                ]
                                            ),
                                        ),
                                        Container(
                                            height: 250,
                                            width: double.infinity,
                                            child: SfCartesianChart(
                                                primaryXAxis: CategoryAxis(),
                                                title: const ChartTitle(
                                                    text: 'Điểm trung bình tích lũy (CPA)',
                                                    textStyle: TextStyle(
                                                          color: Color(0xFFD80015),
                                                          fontFamily: 'SFProSemiBold',
                                                          fontSize: 14,
                                                    ),
                                                    alignment: ChartAlignment.near,
                                                ),
                                                legend: Legend(isVisible: true),
                                                tooltipBehavior: _tooltipBehavior,
                                                series: <LineSeries<SalesData, String>>[
                                                    LineSeries<SalesData, String>(
                                                        name:'CPA',
                                                        color: Color(0xFFD80015),
                                                        dataSource:  <SalesData>[
                                                            SalesData('20221', 3.85),
                                                            SalesData('20222', 3.46),
                                                            SalesData('20231', 3.48),
                                                            SalesData('20232', 3.45),
                                                        ],
                                                        xValueMapper: (SalesData sales, _) => sales.year,
                                                        yValueMapper: (SalesData sales, _) => sales.sales,
                                                        dataLabelSettings: DataLabelSettings(isVisible: true)
                                                    )
                                                ]
                                            ),
                                        ),
                                        SizedBox(
                                            height: 300,
                                            child: ListView.separated(
                                                physics: const NeverScrollableScrollPhysics(),
                                                itemBuilder: (context, index) {
                                                    return Container(
                                                        height: 50,
                                                        decoration: const BoxDecoration(
                                                            color: Colors.greenAccent,
                                                            borderRadius: BorderRadius.only(topLeft: Radius.circular(15.0), topRight: Radius.circular(15.0), bottomRight: Radius.circular(15.0), bottomLeft: Radius.circular(15.0)),
                                                        ),
                                                        child: Center(child:
                                                            Text('Item thứ ${listData[index]}'),),
                                                    );
                                                },
                                                separatorBuilder: (context, index) => const SizedBox(height: 10,),
                                                itemCount: 4
                                            ),
                                        )
                                    ],
                                )
                            )
                        )
                    ),
                    Container(
                        padding: const EdgeInsets.only(top: 40, right: 25, bottom: 15, left: 25),
                        color: Color(0xFFD80015),
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
                ]
            )
        );
    }
}
class SalesData {
    SalesData(this.year, this.sales);
    final String year;
    final double sales;
}