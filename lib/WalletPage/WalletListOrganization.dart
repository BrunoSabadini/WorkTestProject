import 'package:flutter/material.dart';
import 'package:work_project/Models/CoinsLabel.dart';
import 'package:work_project/CoinsData.dart';
import 'package:work_project/WalletPage/Wallet.dart';

class ListOrganizationState extends State<ListOrganizationWidget> {
  @override
  Widget build(BuildContext context) {
    return Stack(children: <Widget>[
      ListView(children: <Widget>[
        WalletAmountWidget(
          coin: widget.coin,
        ),
        Tooltip(
            message: "Go to BTC details",
            child: CoinsLabelModelWidget(
                coin: Coins(
                    abreviation: 'BTC',
                    name: "BitCoin",
                    icon: Icons.currency_bitcoin))),
        Tooltip(
            message: "Go to ETH details",
            child: CoinsLabelModelWidget(
                coin: Coins(
                    abreviation: 'ETH',
                    name: "Ethereum",
                    icon: Icons.text_rotation_angledown))),
        Tooltip(
            message: "Go to LTC details",
            child: CoinsLabelModelWidget(
                coin: Coins(
                    abreviation: 'LTC',
                    name: "LiteCoin",
                    icon: Icons.monetization_on)))
      ])
    ]);
  }
}

class ListOrganizationWidget extends StatefulWidget {
  ListOrganizationWidget({Key? key}) : super(key: key);
  Coins coin = Coins(abreviation: "", name: "", icon: Icons.visibility_rounded);

  @override
  State<ListOrganizationWidget> createState() => ListOrganizationState();
}
