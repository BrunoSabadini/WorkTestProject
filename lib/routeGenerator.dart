import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:work_project/Models/CoinConversion.dart';
import 'FirstScreen/WalletAndCryptoLabelsWidget.dart';
import 'Models/CompletedConversionScreen.dart';
import 'Models/DetailsPageModel.dart';
import 'StateController.dart';

Widget changeNotifierProvider(String symbol) {
  return ChangeNotifierProvider(
      create: (context) => StoreStateController(),
      child: DetailsPageModelWidget(symbol: symbol));
}

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/ethereum':
        return MaterialPageRoute(builder: (_) => changeNotifierProvider('ETH'));
      case '/litecoin':
        return MaterialPageRoute(builder: (_) => changeNotifierProvider('LTC'));
      case '/bitcoin':
        return MaterialPageRoute(
          builder: (_) => changeNotifierProvider('BTC'),
        );
      case '/conversion':
        return MaterialPageRoute(builder: (_) => const CoinsConversionWidget());
      case '/completedConversion':
        return MaterialPageRoute(
            builder: (_) => const CompletedConversionScreen());
      case '/':
        return MaterialPageRoute(
            builder: (_) => const WalletAndCryptoLabelsWidget());
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
