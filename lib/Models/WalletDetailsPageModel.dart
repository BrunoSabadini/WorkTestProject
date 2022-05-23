import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:work_project/CoinsDataToFutureAPI.dart';
import 'package:work_project/StateController.dart';

class DetailsPageModelWidget extends StatefulWidget {
  Coins coin;
  DetailPage detailPage;
  DetailsPageModelWidget(
      {Key? key, required this.coin, required this.detailPage})
      : super(key: key);

  @override
  State<DetailsPageModelWidget> createState() => DetailsPageModelState();
}

class DetailsPageModelState extends State<DetailsPageModelWidget> {
  List<ChartSampleData> chartData = <ChartSampleData>[];
  bool changeChartType = true;
  List randomNumbers = [];

  @override
  initState() {
    super.initState();
    chartData = dateFilter(30);
  }

  List<ChartSampleData> dateFilter(int numberOfSpots) {
    final DateTime nowTime = DateTime.now();
    List<ChartSampleData> test = <ChartSampleData>[];
    randomNumbers = [];
    for (var i = 0; i < numberOfSpots; i++) {
      final date = nowTime.subtract(Duration(days: i));
      randomNumbers.add(Random().nextInt(1000));
      final ChartSampleData chart =
          ChartSampleData(x: date, yValue: randomNumbers.last);
      test.add(chart);
    }
    return test;
  }

  double currentCoinValue(String abreviation) {
    if (abreviation == "BTC") {
      return Provider.of<StateController>(context, listen: true)
          .bitcoinCurrentValue;
    } else if (abreviation == "ETH") {
      return Provider.of<StateController>(context, listen: true)
          .ethereumCurrentValue;
    } else if (abreviation == "LTC") {
      return Provider.of<StateController>(context, listen: true)
          .litecoinCurrentValue;
    }
    return 0;
  }

  double calculateMinAndMaxValue(String minOrMaxValue) {
    int value = randomNumbers.first;
    minOrMaxValue = minOrMaxValue;
    if (minOrMaxValue == "min") {
      for (var i = 0; i < randomNumbers.length; i++) {
        value = min(value, randomNumbers[i]);
      }
    } else {
      for (var i = 0; i < randomNumbers.length; i++)
        value = max(value, randomNumbers[i]);
    }
    return value.toDouble();
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
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(80, 11, 10, 10),
          title: const Text('Detalhes',
              textAlign: TextAlign.left,
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black)),
        ),
        body: ListView(children: <Widget>[
          Text("Moeda" " " + widget.coin.name,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black)),
          Container(
              margin: const EdgeInsets.only(top: 20.0, right: 25, left: 25),
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
                                title: ChartTitle(
                                    text: Provider.of<StateController>(context,
                                            listen: true)
                                        .numberFormatConversion(
                                            currentCoinValue(
                                                widget.coin.abreviation))),
                                backgroundColor:
                                    Color.fromARGB(94, 224, 219, 219),
                                primaryXAxis: DateTimeAxis(
                                    maximumLabels: 50,
                                    majorGridLines: MajorGridLines(width: 0),
                                    edgeLabelPlacement:
                                        EdgeLabelPlacement.shift,
                                    intervalType: DateTimeIntervalType.days),
                                series: (changeChartType)
                                    ? <ChartSeries<ChartSampleData, DateTime>>[
                                        LineSeries<ChartSampleData, DateTime>(
                                          dataSource: chartData,
                                          xValueMapper:
                                              (ChartSampleData sales, _) =>
                                                  sales.x,
                                          yValueMapper:
                                              (ChartSampleData sales, _) =>
                                                  sales.yValue,
                                        )
                                      ]
                                    : <ChartSeries<ChartSampleData, DateTime>>[
                                        BarSeries<ChartSampleData, DateTime>(
                                          dataSource: chartData,
                                          xValueMapper:
                                              (ChartSampleData sales, _) =>
                                                  sales.x,
                                          yValueMapper:
                                              (ChartSampleData sales, _) =>
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
                                    backgroundColor: MaterialStateProperty.all(
                                        Colors.indigo[50]),
                                  ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              )),
          const Padding(
              padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
              child: Text("Informações",
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black))),
          Container(
            decoration: const BoxDecoration(
                border: Border(
                    top: BorderSide(
                        width: 1.1, color: Color.fromARGB(60, 0, 0, 0)))),
            child: Provider.of<StateController>(context, listen: true).listTile(
                widget.detailPage.coinName,
                currentCoinValue(widget.coin.abreviation),
                subtitle: const Text("Valor Atual")),
          ),
          Provider.of<StateController>(context, listen: true).listTile(
              "Cap de mercado", widget.detailPage.capMercado,
              backgroundColorVerification: widget.detailPage.capMercado,
              whatStringReturn: ""),
          Provider.of<StateController>(context, listen: true)
              .listTile("Valor mínimo", calculateMinAndMaxValue("min")),
          Provider.of<StateController>(context, listen: true)
              .listTile("Valor máximo", calculateMinAndMaxValue("max")),
          Provider.of<StateController>(context, listen: true).elevatedButton(
              context, "Converter moeda",
              routeNavigator: "/conversion"),
        ]));
  }
}

class ChartSampleData {
  ChartSampleData({this.x, this.yValue});

  final DateTime? x;
  final double? yValue;
}
