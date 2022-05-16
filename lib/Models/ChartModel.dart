import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ChartModelWidget extends StatefulWidget {
  ChartModelWidget({Key? key}) : super(key: key);

  @override
  ChartModelState createState() => ChartModelState();
}

class ChartModelState extends State<ChartModelWidget> {
  List<ChartSampleData> chartData = <ChartSampleData>[];
  bool changeChartType = true;

  @override
  initState() {
    super.initState();
    chartData = dateFilter(30);
  }

  List<ChartSampleData> dateFilter(int numberOfSpots) {
    final DateTime nowTime = DateTime.now();
    double doubleInitial = 0;
    List<ChartSampleData> test = <ChartSampleData>[];

    for (var i = 0; i < numberOfSpots; i++) {
      double doubleAdd = doubleInitial + i;
      final date = nowTime.subtract(Duration(days: i));

      final ChartSampleData chart = ChartSampleData(x: date, yValue: doubleAdd);
      test.add(chart);
    }
    return test;
  }

  void callChartData(int numberOfSpots) {
    setState(() {
      chartData = dateFilter(numberOfSpots);
    });
  }

  chartButton(int numberOfSpots, String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: OutlinedButton(
        onPressed: () {
          callChartData(numberOfSpots);
        },
        child: Text(label),
        style: (false)
            ? ButtonStyle(
                foregroundColor: MaterialStateProperty.all(Colors.grey),
              )
            : ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.indigo[50]),
              ),
      ),
    );
  }

  void switchChartType() {
    setState(() {
      changeChartType = !changeChartType;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(top: 40.0, right: 25, left: 25),
        height: 300,
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          children: [
            Row(children: [
              Expanded(
                  child: SizedBox(
                      height: 250,
                      width: 100,
                      child: SfCartesianChart(
                          title: ChartTitle(text: "R\$1.000,00"),
                          backgroundColor: Color.fromARGB(94, 224, 219, 219),
                          primaryXAxis: DateTimeAxis(
                              maximumLabels: 50,
                              majorGridLines: MajorGridLines(width: 0),
                              edgeLabelPlacement: EdgeLabelPlacement.shift,
                              intervalType: DateTimeIntervalType.days),
                          series: (changeChartType)
                              ? <ChartSeries<ChartSampleData, DateTime>>[
                                  LineSeries<ChartSampleData, DateTime>(
                                    dataSource: chartData,
                                    xValueMapper: (ChartSampleData sales, _) =>
                                        sales.x,
                                    yValueMapper: (ChartSampleData sales, _) =>
                                        sales.yValue,
                                  )
                                ]
                              : <ChartSeries<ChartSampleData, DateTime>>[
                                  BarSeries<ChartSampleData, DateTime>(
                                    dataSource: chartData,
                                    xValueMapper: (ChartSampleData sales, _) =>
                                        sales.x,
                                    yValueMapper: (ChartSampleData sales, _) =>
                                        sales.yValue,
                                  )
                                ])))
            ]),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  chartButton(5, '5D'),
                  chartButton(10, '10D'),
                  chartButton(15, '15D'),
                  chartButton(30, '30D'),
                  chartButton(50, '50D'),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: OutlinedButton(
                      onPressed: () {
                        switchChartType();
                      },
                      child: Icon(Icons.bar_chart),
                      style: (1 != 1)
                          ? ButtonStyle(
                              foregroundColor:
                                  MaterialStateProperty.all(Colors.grey),
                            )
                          : ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.indigo[50]),
                            ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ));
  }
}

class ChartSampleData {
  ChartSampleData({this.x, this.yValue});

  final DateTime? x;
  final double? yValue;
}
