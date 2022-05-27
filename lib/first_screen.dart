import 'package:flutter/material.dart';
import 'Models/Repository.dart';
import 'Models/WalletDetailsPageModel.dart';
import 'Models/fetchCoins_models/big_data_model.dart';

class FirstScreen extends StatefulWidget {
  const FirstScreen({
    Key? key,
  }) : super(key: key);

  @override
  _FirstScreenState createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
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
            var coinsData = snapshot.data!.dataModel;
            var coin = coinsData[0];
            var valuesAndPercentages = coin.quoteModel.usdModel;
            print("Tentei rodar a CoinList");
            return DetailsPageModelWidget(
              coins: coinsData,
              valuesAndPercentages: valuesAndPercentages,
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
