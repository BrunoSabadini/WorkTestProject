import 'package:flutter/material.dart';
import 'package:work_project/Models/CoinConversion.dart';
import 'Models/CompletedConversionScreen.dart';
import 'Models/DetailsPageModel.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/ethereum':
        return MaterialPageRoute(
            builder: (_) => DetailsPageModelWidget(symbol: 'ETH'));
      case '/litecoin':
        return MaterialPageRoute(
            builder: (_) => DetailsPageModelWidget(symbol: 'LTC'));
      case '/bitcoin':
        return MaterialPageRoute(
          builder: (_) => DetailsPageModelWidget(symbol: 'BTC'),
        );
      case '/conversion':
        return MaterialPageRoute(builder: (_) => const CoinsConversionWidget());
      case '/completedConversion':
        return MaterialPageRoute(
            builder: (_) => const CompletedConversionScreen());
    }
    return _errorRoute();
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
