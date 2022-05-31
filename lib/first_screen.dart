import 'package:flutter/material.dart';
import 'Models/MessariAPI/big_data_model.dart';
import 'Models/MessariAPI/Repository.dart';
import 'Models/DetailsPageModel.dart';

class FirstScreen extends StatefulWidget {
  final int wichCoin;

  const FirstScreen({Key? key, required this.wichCoin}) : super(key: key);

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
            var coinsData = snapshot.data!.dataModel;
            var coin = coinsData[widget.wichCoin];
            var valuesAndPercentages =
                coinsData[widget.wichCoin].metricsModel.usdModel;
            print("Tentei rodar a CoinList");
            return DetailsPageModelWidget(
              wichCoin: widget.wichCoin,
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
