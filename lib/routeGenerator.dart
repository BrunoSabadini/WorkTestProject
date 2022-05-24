import 'package:flutter/material.dart';
import 'package:work_project/CoinsDataToFutureAPI.dart';
import 'package:work_project/Models/CoinConversion.dart';
import 'Models/CompletedConversionScreen.dart';
import 'Models/WalletDetailsPageModel.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Getting arguments passed in while calling Navigator.pushNamed
    switch (settings.name) {
      case '/ethereum':
        return MaterialPageRoute(
            builder: (_) => DetailsPageModelWidget(
                coin: Coins(
                    abreviation: 'ETH',
                    name: "Ethereum",
                    icon: Icons.currency_bitcoin),
                detailPage: DetailPage(
                  coinName: "Ethereum",
                  capMercado: 10,
                )));
      case '/litecoin':
        return MaterialPageRoute(
            builder: (_) => DetailsPageModelWidget(
                coin: Coins(
                    abreviation: 'LTC',
                    name: "Litecoin",
                    icon: Icons.currency_bitcoin),
                detailPage: DetailPage(coinName: "Litecoin", capMercado: 10)));
      case '/bitcoin':
        return MaterialPageRoute(
          builder: (_) => DetailsPageModelWidget(
            coin: Coins(
                abreviation: 'BTC',
                name: "Bitcoin",
                icon: Icons.currency_bitcoin),
            detailPage: DetailPage(
              coinName: "Bitcoin",
              capMercado: 10,
            ),
            // data: args,
          ),
        );
      case '/conversion':
        return MaterialPageRoute(builder: (_) => const CoinsConversionWidget());
      case '/completedConversion':
        return MaterialPageRoute(
            builder: (_) => const CompletedConversionScreen());
    }
    return _errorRoute();
    // If there is no such named route in the switch statement
  }
}

Route<dynamic> _errorRoute() {
  return MaterialPageRoute(builder: (_) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rota não encontrada'),
      ),
      body: const Center(
        child: Text('A sua rota não foi definida corretamente'),
      ),
    );
  });
}
