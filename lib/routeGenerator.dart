import 'package:flutter/material.dart';
import 'package:work_project/CoinsDataToFutureAPI.dart';
import 'package:work_project/HomeScreen.dart';
import '../Models/ChartModel.dart';
import 'Models/DetailsPageModel.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Getting arguments passed in while calling Navigator.pushNamed
    final args = settings.arguments;
    DateTime p = DateTime.parse('2019-10-30T20:30:00');
    switch (settings.name) {
      case '/ethereum':
        return MaterialPageRoute(
            builder: (_) => DetailsPageModelWidget(
                coin: Coins(
                    abreviation: 'tirar',
                    name: "Moead Ethereum",
                    icon: Icons.currency_bitcoin),
                detailPage: DetailPage(
                    coinName: "Ethereum",
                    capMercado: 10,
                    maxValue: 15,
                    minValue: 6,
                    value: 1000)));
      case '/litecoin':
        return MaterialPageRoute(
            builder: (_) => DetailsPageModelWidget(
                coin: Coins(
                    abreviation: 'tirar',
                    name: "Moead Litecoin",
                    icon: Icons.currency_bitcoin),
                detailPage: DetailPage(
                    coinName: "Litecoin",
                    capMercado: 10,
                    maxValue: 15,
                    minValue: 6,
                    value: 1000)));
      case '/bitcoin':
        return MaterialPageRoute(
          builder: (_) => DetailsPageModelWidget(
            coin: Coins(
                abreviation: 'tirar',
                name: "Moead Bitcoin",
                icon: Icons.currency_bitcoin),
            detailPage: DetailPage(
                coinName: "Bitcoin",
                capMercado: 10,
                maxValue: 15,
                minValue: 6,
                value: 1000),
            // data: args,
          ),
        );
    }
    return _errorRoute();
    // If there is no such named route in the switch statement
  }
}

Route<dynamic> _errorRoute() {
  return MaterialPageRoute(builder: (_) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Error'),
      ),
      body: Center(
        child: Text('ERROR'),
      ),
    );
  });
}
