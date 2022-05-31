import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:work_project/StateController.dart';
import '../l10n/app_localizations.dart';
import 'MessariAPI/data_model.dart';
import 'MessariAPI/usd_model.dart';

class APIchartWidget extends StatefulWidget {
  final List<DataModel> coins;
  final UsdModel valuesAndPercentages;
  final int wichCoin;

  APIchartWidget(
      {Key? key,
      required this.coins,
      required this.valuesAndPercentages,
      required this.wichCoin})
      : super(key: key);

  @override
  State<APIchartWidget> createState() => APIchartState();
}

class APIchartState extends State<APIchartWidget> {
  List<ChartSampleData> chartData = <ChartSampleData>[];
  bool changeChartType = true;
  List randomNumbers = [];

  @override
  initState() {
    super.initState();
    chartData = dateFilter(30);
  }

  List<ChartSampleData> dateFilter(int numberOfSpots) {
    final DateTime oneDay = DateTime.now().subtract(Duration(days: 1));
    final DateTime sevenDays = DateTime.now().subtract(Duration(days: 7));
    final DateTime thirtyDays = DateTime.now().subtract(Duration(days: 30));
    final DateTime sixtyDays = DateTime.now().subtract(Duration(days: 60));
    final DateTime ninetyDays = DateTime.now().subtract(Duration(days: 90));

    List<ChartSampleData> test = <ChartSampleData>[
      ChartSampleData(period: oneDay, yValue: 1),
      ChartSampleData(period: sevenDays, yValue: 2),
      ChartSampleData(period: thirtyDays, yValue: 3),
      ChartSampleData(period: sixtyDays, yValue: 4),
      ChartSampleData(period: ninetyDays, yValue: 5)
    ];

    // if (numberOfSpots == 1) {
    //   return ;
    // }
    // else if (numberOfSpots == 7) {
    //   return ;
    // } else if (numberOfSpots == 30) {
    //   return ;
    // }
    // else if (numberOfSpots == 60) {
    //   return ;
    // }
    // else if (numberOfSpots == 90) {
    //   return ;

    return test;
  }

  double currentCoinValue(String abreviation) {
    if (abreviation == "BTC") {
      return widget.valuesAndPercentages.price.toDouble();
    } else if (abreviation == "ETH") {
      return widget.valuesAndPercentages.price.toDouble();
    } else if (abreviation == "LTC") {
      return widget.valuesAndPercentages.price.toDouble();
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
      for (var i = 0; i < randomNumbers.length; i++) {
        value = max(value, randomNumbers[i]);
      }
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
        style: ButtonStyle(
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
            iconTheme: const IconThemeData(
              color: Colors.black,
            ),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () {
                Navigator.of(context, rootNavigator: true).pushNamed("/");
              },
            ),
            toolbarOpacity: 0.5,
            backgroundColor: const Color.fromARGB(193, 255, 255, 255),
            title: const SizedBox(
              width: double.infinity,
              child: Text('Detalhes',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black)),
            )),
        body: ListView(children: <Widget>[
          Text("Moeda" " " + widget.coins[widget.wichCoin].name,
              textAlign: TextAlign.center,
              style: const TextStyle(
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
                                                widget.coins[0].symbol))),
                                backgroundColor:
                                    const Color.fromARGB(94, 224, 219, 219),
                                primaryXAxis: DateTimeAxis(
                                    maximumLabels: 50,
                                    majorGridLines:
                                        const MajorGridLines(width: 0),
                                    edgeLabelPlacement:
                                        EdgeLabelPlacement.shift,
                                    intervalType: DateTimeIntervalType.days),
                                series: (changeChartType)
                                    ? <ChartSeries<ChartSampleData, DateTime>>[
                                        LineSeries<ChartSampleData, DateTime>(
                                          dataSource: chartData,
                                          xValueMapper:
                                              (ChartSampleData sales, _) =>
                                                  sales.period,
                                          yValueMapper:
                                              (ChartSampleData sales, _) =>
                                                  sales.yValue,
                                        )
                                      ]
                                    : <ChartSeries<ChartSampleData, DateTime>>[
                                        BarSeries<ChartSampleData, DateTime>(
                                          dataSource: dateFilter(30),
                                          xValueMapper:
                                              (ChartSampleData sales, _) =>
                                                  sales.period,
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
                            child: const Icon(Icons.bar_chart),
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
              padding: EdgeInsets.fromLTRB(20, 0, 0, 15),
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
                widget.coins[widget.wichCoin].name,
                currentCoinValue(widget.coins[widget.wichCoin].symbol),
                subtitle: Text(AppLocalizations.of(context)?.actualvalue ??
                    "Rever Internationalization")),
          ),
          Provider.of<StateController>(context, listen: true).listTile(
              AppLocalizations.of(context)?.marketcap ??
                  "Rever Internationalization",
              widget.valuesAndPercentages.percentChange_1h.toDouble(),
              backgroundColorVerification:
                  widget.valuesAndPercentages.percentChange_24h.toDouble(),
              whatStringReturn: ""),
          Provider.of<StateController>(context, listen: true).listTile(
              AppLocalizations.of(context)?.minimumvalue ??
                  "Rever Internationalization",
              3),
          Provider.of<StateController>(context, listen: true).listTile(
              AppLocalizations.of(context)?.maximumvalue ??
                  "Rever Internationalization",
              4),
          Provider.of<StateController>(context, listen: true).elevatedButton(
              context, "Converter moeda",
              routeNavigator: "/conversion"),
        ]));
  }
}

class ChartSampleData {
  ChartSampleData({this.period, this.yValue});

  final DateTime? period;
  final num? yValue;
}
