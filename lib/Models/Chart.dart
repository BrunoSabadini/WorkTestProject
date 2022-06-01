import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:work_project/StateController.dart';
import '../l10n/app_localizations.dart';
import 'CoinMarketAPI/market_big_data_model.dart';
import 'CoinMarketAPI/market_repository.dart';
import 'MessariAPI/data_model.dart';
import 'MessariAPI/usd_model.dart';

class ChartWidget extends StatefulWidget {
  final UsdModel valuesAndPercentages;
  final int wichCoin;
  final String symbol;
  final String name;

  ChartWidget(
      {Key? key,
      required this.symbol,
      required this.name,
      required this.valuesAndPercentages,
      required this.wichCoin})
      : super(key: key);

  @override
  State<ChartWidget> createState() => APIchartState();
}

class APIchartState extends State<ChartWidget> {
  List<ChartSampleData> chartData = <ChartSampleData>[];
  bool changeChartType = true;
  List randomNumbers = [];

  late Future<MarketBigDataModel> _futureCoins;
  late MarketRepository repository;

  @override
  void initState() {
    chartData = dateFilter(1, 2, 3, 4, 5);
    repository = MarketRepository();
    _futureCoins = repository.getCoins();
    super.initState();
  }

  List<ChartSampleData> dateFilter(num dayOneValue, num daysevenValue,
      num dayThirtyValue, num daySixtyValue, num dayNinetyValue) {
    final DateTime oneDay = DateTime.now().subtract(Duration(days: 1));
    final DateTime sevenDays = DateTime.now().subtract(Duration(days: 7));
    final DateTime thirtyDays = DateTime.now().subtract(Duration(days: 30));
    final DateTime sixtyDays = DateTime.now().subtract(Duration(days: 60));
    final DateTime ninetyDays = DateTime.now().subtract(Duration(days: 90));

    List<ChartSampleData> test = <ChartSampleData>[
      ChartSampleData(period: oneDay, yValue: dayOneValue),
      ChartSampleData(period: sevenDays, yValue: daysevenValue),
      ChartSampleData(period: thirtyDays, yValue: dayThirtyValue),
      ChartSampleData(period: sixtyDays, yValue: daySixtyValue),
      ChartSampleData(period: ninetyDays, yValue: dayNinetyValue)
    ];
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
      chartData = dateFilter(1, 2, 3, 4, 5);
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

  Widget chartWidget(num dayOneValue, num daysevenValue, num dayThirtyValue,
      num daySixtyValue, num dayNinetyValue) {
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
          Text("Moeda" " " + widget.name,
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
                                            currentCoinValue(widget.symbol))),
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
                                          dataSource: dateFilter(
                                              dayOneValue,
                                              daysevenValue,
                                              dayThirtyValue,
                                              daySixtyValue,
                                              dayNinetyValue),
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
                                          dataSource: dateFilter(
                                              dayOneValue,
                                              daysevenValue,
                                              dayThirtyValue,
                                              daySixtyValue,
                                              dayNinetyValue),
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
        ]));
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<MarketBigDataModel>(
      future: _futureCoins,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData) {
            var coinsData = snapshot.data!.dataModel;
            var coin = coinsData[widget.wichCoin];
            var valuesAndPercentages =
                coinsData[widget.wichCoin].quoteModel.usdModel;
            print("Tentei rodar a CoinList");
            return chartWidget(
                valuesAndPercentages.percentChange_24h,
                valuesAndPercentages.percentChange_7d,
                valuesAndPercentages.percentChange_30d,
                valuesAndPercentages.percentChange_60d,
                valuesAndPercentages.percentChange_90d);
          } else if (snapshot.hasError) {
            print("Ba deu ruim");
            return Text('${snapshot.error}');
          }
        }

        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}

class ChartSampleData {
  ChartSampleData({this.period, this.yValue});

  final DateTime? period;
  final num? yValue;
}
