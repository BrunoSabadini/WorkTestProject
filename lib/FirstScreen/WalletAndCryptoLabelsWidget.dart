import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Models/MessariAPI/AllAssetsBigDataModel.dart';
import '../Models/MessariAPI/AllAssetsRepository.dart';
import '../StateController.dart';
import '../l10n/app_localizations.dart';

class WalletAndCryptoLabelsWidget extends StatefulWidget {
  const WalletAndCryptoLabelsWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<WalletAndCryptoLabelsWidget> createState() =>
      WalletAndCryptoLabelsState();
}

class WalletAndCryptoLabelsState extends State<WalletAndCryptoLabelsWidget> {
  late Future<AllAssetsBigDataModel> _futureCoins;
  late AllAssetsRepository repository;

  @override
  void initState() {
    repository = AllAssetsRepository();
    _futureCoins = repository.getCoins();
    super.initState();
  }

  routeNavegation(String abreviation) {
    switch (abreviation) {
      case "BTC":
        return "/bitcoin";
      case "ETH":
        return "/ethereum";
      case "LTC":
        return "/litecoin";
      default:
        return "will go to error screen";
    }
  }

  wichCoinAmount(String symbol) {
    switch (symbol) {
      case "BTC":
        return Provider.of<StateController>(context, listen: true)
            .bitcoinAmount;
      case "ETH":
        return Provider.of<StateController>(context, listen: true)
            .ethereumAmount;
      case "LTC":
        return Provider.of<StateController>(context, listen: true)
            .litecoinAmount;
      default:
        return "will go to error screen";
    }
  }

  Widget walletAmountWidget() {
    return Container(
      margin: const EdgeInsets.fromLTRB(25, 40, 25, 0),
      height: 150.0,
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                  child: Text(
                      AppLocalizations.of(context)!
                          .wallet, // Deixei "Carteira" mesmo em inglês porque ele reconhece que estou usando inglês
                      style: const TextStyle(
                          fontSize: 29, fontWeight: FontWeight.bold))),
              IconButton(
                icon: Icon(Provider.of<StateController>(context, listen: true)
                    .eyefunc()),
                tooltip: 'HideWalletAmount',
                onPressed: Provider.of<StateController>(context, listen: true)
                    .switchShowHide,
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(children: [
            Expanded(
                child: Text(
                    Provider.of<StateController>(context, listen: true)
                        .amountFunc(
                            Provider.of<StateController>(context, listen: true)
                                .walletAmount()),
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                        fontSize: 29, fontWeight: FontWeight.bold))),
            const IconButton(
              icon: Icon(
                Icons.arrow_forward_ios,
                size: 15,
              ),
              tooltip: 'GoToAmountDetails',
              onPressed: null,
            )
          ]),
          Row(
            children: [
              Expanded(
                  child: Text(
                      Provider.of<StateController>(context, listen: true)
                              .profitFunc() +
                          " " +
                          Provider.of<StateController>(context, listen: true)
                              .remunerationFunc(),
                      textAlign: TextAlign.left,
                      style: const TextStyle(fontSize: 19)))
            ],
          )
        ],
      ),
    );
  }

  Widget coinsLabel(String symbol, String name, double marketCap) {
    return Card(
      child: InkWell(
        onTap: () {
          Navigator.of(context, rootNavigator: true).pushNamed(
            routeNavegation(symbol),
          );
        },
        child: ListTile(
          leading: const Icon(Icons.currency_bitcoin, size: 35),
          title: Text(symbol),
          subtitle: Text(name),
          trailing: Column(children: [
            Text(Provider.of<StateController>(context, listen: true)
                .amountFunc(wichCoinAmount(symbol))),
            (Provider.of<StateController>(context, listen: true)
                .greenOrRedBackground(
                    text: "$marketCap", backgroundColorVerification: marketCap))
          ]),
          isThreeLine: true,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<AllAssetsBigDataModel>(
      future: _futureCoins,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData) {
            var coinsData = snapshot.data!.dataModel;
            return Stack(children: <Widget>[
              ListView(children: <Widget>[
                walletAmountWidget(),
                Tooltip(
                    message: "Go to BTC details",
                    child:
                        coinsLabel(coinsData[0].symbol, coinsData[0].name, 10)),
                Tooltip(
                    message: "Go to ETH details",
                    child:
                        coinsLabel(coinsData[1].symbol, coinsData[1].name, 10)),
                Tooltip(
                    message: "Go to LTC details",
                    child: coinsLabel(
                        coinsData[19].symbol, coinsData[19].name, 10))
              ])
            ]);
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          }
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
