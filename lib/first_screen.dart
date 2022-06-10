import 'package:flutter/material.dart';
import 'Models/MessariAPI/big_data_model.dart';
import 'Models/MessariAPI/Repository.dart';
import 'Models/DetailsPageModel.dart';

class FirstScreen extends StatefulWidget {
  const FirstScreen({Key? key}) : super(key: key);

  @override
  _FirstScreenState createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  int? selectCoinIndex;
  late Future<BigDataModel> _futureCoins;
  late Repository repository;

  @override
  void initState() {
    repository = Repository();
    _futureCoins = repository.getCoins();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<BigDataModel>(
      future: _futureCoins,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData) {
            var coinName = snapshot.data!.name;
            var coinSymbol = snapshot.data!.symbol;
            var coinSlug = snapshot.data!.slug;
            var valuesAndPercentages = snapshot.data!.values;
            print("Tentei rodar a CoinList");
            return DetailsPageModelWidget(
              valuesAndPercentages: valuesAndPercentages,
              name: coinName,
              symbol: coinSymbol,
            );
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
