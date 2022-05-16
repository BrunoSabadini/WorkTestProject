import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:work_project/CoinsData.dart';
import 'package:work_project/StateController.dart';
import 'package:work_project/l10n/app_localizations.dart';

class WalletAmountWidget extends StatefulWidget {
  WalletAmountWidget({Key? key, required this.coin}) : super(key: key);
  Coins coin;

  @override
  WalletAmountState createState() => WalletAmountState();
}

class WalletAmountState extends State<WalletAmountWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 40.0, right: 25, left: 25),
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
                icon: Icon(
                    Provider.of<ShowHideController>(context, listen: true)
                        .eyefunc()),
                tooltip: 'HideWalletAmount',
                onPressed:
                    Provider.of<ShowHideController>(context, listen: true)
                        .switchShowHide,
              ),
            ],
          ),
          SizedBox(height: 20),
          Row(children: [
            Expanded(
                child: Text(
                    Provider.of<ShowHideController>(context, listen: true)
                        .amountFunc(widget.coin.walletAmount),
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
                      Provider.of<ShowHideController>(context, listen: true)
                              .profitFunc() +
                          " " +
                          Provider.of<ShowHideController>(context, listen: true)
                              .remunerationFunc(),
                      textAlign: TextAlign.left,
                      style: const TextStyle(fontSize: 19)))
            ],
          )
        ],
      ),
    );
  }
}
