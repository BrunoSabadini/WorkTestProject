import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:work_project/CoinsDataToFutureAPI.dart';
import 'package:work_project/StateController.dart';

class CoinsLabelModelWidget extends StatefulWidget {
  final Coins coin;
  const CoinsLabelModelWidget({Key? key, required this.coin}) : super(key: key);

  @override
  State<CoinsLabelModelWidget> createState() => CoinsLabelModelState();
}

class CoinsLabelModelState extends State<CoinsLabelModelWidget> {
  String routeNavegation(String abreviation) {
    if (abreviation == "BTC") {
      return "/bitcoin";
    } else if (abreviation == "ETH") {
      return "/ethereum";
    } else if (abreviation == "LTC") {
      return "/litecoin";
    } else {
      return "will go to error screen";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () {
          Navigator.of(context, rootNavigator: true).pushNamed(
            routeNavegation(widget.coin.abreviation),
          );
        },
        child: ListTile(
          leading: Icon(widget.coin.icon, size: 35),
          title: Text(widget.coin.abreviation),
          subtitle: Text(widget.coin.name),
          trailing: Column(children: [
            Text(Provider.of<StateController>(context, listen: true).amountFunc(
                Provider.of<StateController>(context, listen: true)
                    .bitcoinAmount)),
            (Provider.of<StateController>(context, listen: true)
                .greenOrRedBackground(
                    text: "${widget.coin.variation}",
                    backgroundColorVerification: widget.coin.variation))
          ]),
          isThreeLine: true,
          contentPadding:
              EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
        ),
      ),
    );
  }
}
