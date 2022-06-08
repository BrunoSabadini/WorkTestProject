import 'package:flutter/material.dart';
import 'package:work_project/CoinsDataToFutureAPI.dart';
import 'package:work_project/Models/CoinConversion.dart';
import 'Models/CompletedConversionScreen.dart';
import 'Models/DetailsPageModel.dart';
import 'first_screen.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Getting arguments passed in while calling Navigator.pushNamed
    switch (settings.name) {
      case '/ethereum':
        return MaterialPageRoute(builder: (_) => FirstScreen());
      case '/litecoin':
        return MaterialPageRoute(builder: (_) => FirstScreen());
      case '/bitcoin':
        return MaterialPageRoute(
          builder: (_) => FirstScreen(),
        );
      case '/conversion':
        return MaterialPageRoute(builder: (_) => const CoinsConversionWidget());
      case '/completedConversion':
        return MaterialPageRoute(
            builder: (_) => const CompletedConversionScreen());
      case '/API':
        return MaterialPageRoute(builder: (_) => FirstScreen());
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
