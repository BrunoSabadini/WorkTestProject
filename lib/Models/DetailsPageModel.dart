import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:work_project/StateController.dart';
import '../l10n/app_localizations.dart';
import 'MessariAPI/Repository.dart';
import 'MessariAPI/big_data_model.dart';

class DetailsPageModelWidget extends StatefulWidget {
  final List? valuesAndPercentages;
  final String? name;
  final String? symbol;

  DetailsPageModelWidget({
    Key? key,
    required this.name,
    required this.symbol,
    required this.valuesAndPercentages,
  }) : super(key: key);

  @override
  State<DetailsPageModelWidget> createState() => DetailsPageModelState();
}

class DetailsPageModelState extends State<DetailsPageModelWidget> {
  bool changeChartType = true;
  List<ChartSampleData> chartSpots = <ChartSampleData>[];
  List chartValues = [];
  double minValue = 0;
  double maxValue = 0;

  late Future<BigDataModel> _futureCoins;
  late Repository repository;

  @override
  initState() {
    super.initState();
    chartSpots = dateFilter(50);
    repository = Repository();
    _futureCoins = repository.getCoins();
    super.initState();
  }

  List<ChartSampleData> dateFilter(int numberOfSpots) {
    chartSpots = <ChartSampleData>[];
    chartValues = [];

    for (var i = 0; i < numberOfSpots; i++) {
      List<dynamic> apiListValuesReversed =
          widget.valuesAndPercentages!.reversed.toList();

      chartValues.add(apiListValuesReversed[i][4]);

      List<DateTime> chartDays = [];
      chartDays.add(DateTime.now().subtract(Duration(days: i)));

      chartSpots.add(
          ChartSampleData(period: chartDays.last, yValue: chartValues.last));
    }

    return chartSpots;
  }

  double currentCoinValue(String abreviation) {
    if (abreviation == "BTC") {
      return widget.valuesAndPercentages!.last[4].toDouble();
    } else if (abreviation == "ETH") {
      return widget.valuesAndPercentages!.last[4].toDouble();
    } else if (abreviation == "LTC") {
      return widget.valuesAndPercentages!.last[4].toDouble();
    }
    return 0;
  }

  double calculateMinAndMaxValue(String minOrMaxValue) {
    double value = chartValues.first;

    if (minOrMaxValue == "min") {
      for (var i = 0; i < chartSpots.length; i++) {
        value = min(value, chartValues[i]);
        minValue = value;
      }
    } else {
      for (var i = 0; i < chartSpots.length; i++) {
        value = max(value, chartValues[i]);
        maxValue = value;
      }
    }
    return value.toDouble();
  }

  void callChartData(int numberOfSpots) {
    setState(() {
      chartSpots = dateFilter(numberOfSpots);
      minValue = calculateMinAndMaxValue("min");
      maxValue = calculateMinAndMaxValue("max");
    });
  }

  void switchChartType() {
    setState(() {
      changeChartType = !changeChartType;
    });
  }

  Widget chartWidget() {
    return Container(
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
                                      currentCoinValue(widget.symbol ?? ""))),
                          backgroundColor:
                              const Color.fromARGB(94, 224, 219, 219),
                          primaryXAxis: DateTimeAxis(
                              maximumLabels: 50,
                              majorGridLines: const MajorGridLines(width: 0),
                              edgeLabelPlacement: EdgeLabelPlacement.shift,
                              intervalType: DateTimeIntervalType.days),
                          series: (changeChartType)
                              ? <ChartSeries<ChartSampleData, DateTime>>[
                                  LineSeries<ChartSampleData, DateTime>(
                                    dataSource: chartSpots,
                                    xValueMapper: (ChartSampleData sales, _) =>
                                        sales.period,
                                    yValueMapper: (ChartSampleData sales, _) =>
                                        sales.yValue,
                                  )
                                ]
                              : <ChartSeries<ChartSampleData, DateTime>>[
                                  BarSeries<ChartSampleData, DateTime>(
                                    dataSource: chartSpots,
                                    xValueMapper: (ChartSampleData sales, _) =>
                                        sales.period,
                                    yValueMapper: (ChartSampleData sales, _) =>
                                        sales.yValue,
                                  )
                                ])))
            ]),
          ],
        ));
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
          Text("Moeda" " " + (widget.name ?? ""),
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
                                                widget.symbol ?? ""))),
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
                                          dataSource: chartSpots,
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
                                          dataSource: chartSpots,
                                          xValueMapper:
                                              (ChartSampleData sales, _) =>
                                                  sales.period,
                                          yValueMapper:
                                              (ChartSampleData sales, _) =>
                                                  sales.yValue,
                                        )
                                      ])))
                  ]),
                ],
              )),
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
                            backgroundColor:
                                MaterialStateProperty.all(Colors.indigo[50]),
                          ),
                  ),
                )
              ],
            ),
          ),
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
                (widget.name ?? ""), currentCoinValue((widget.symbol ?? "")),
                subtitle: Text(AppLocalizations.of(context)?.actualvalue ??
                    "Rever Internationalization")),
          ),
          Provider.of<StateController>(context, listen: true).listTile(
              AppLocalizations.of(context)?.marketcap ??
                  "Rever Internationalization",
              10,
              backgroundColorVerification: 10,
              whatStringReturn: ""),
          Provider.of<StateController>(context, listen: true).listTile(
              AppLocalizations.of(context)?.minimumvalue ??
                  "Rever Internationalization",
              minValue),
          Provider.of<StateController>(context, listen: true).listTile(
              AppLocalizations.of(context)?.maximumvalue ??
                  "Rever Internationalization",
              maxValue),
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
