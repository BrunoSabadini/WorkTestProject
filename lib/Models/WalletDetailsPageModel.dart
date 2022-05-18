import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:work_project/CoinsDataToFutureAPI.dart';
import 'package:work_project/Models/ChartModel.dart';
import 'package:intl/intl.dart' as intl;
import 'package:work_project/StateController.dart';

class DetailsPageModelWidget extends StatefulWidget {
  Coins coin;
  DetailPage detailPage;
  DetailsPageModelWidget(
      {Key? key, required this.coin, required this.detailPage})
      : super(key: key);

  @override
  State<DetailsPageModelWidget> createState() => DetailsPageModelState();
}

class DetailsPageModelState extends State<DetailsPageModelWidget> {
  Widget listTile(String title, double trailingValue,
      {Widget? subtitle,
      String whatStringReturn = "R\$",
      num? backgroundColorVerification}) {
    return ListTile(
      title: Text(title),
      subtitle: subtitle,
      trailing: Provider.of<StateController>(context, listen: true)
          .greenOrRedBackground(
              text: Provider.of<StateController>(context, listen: true)
                  .numberFormatConversion(trailingValue,
                      whatStringReturn: whatStringReturn),
              backgroundColorVerification: backgroundColorVerification),
      contentPadding:
          const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(80, 11, 10, 10),
          title: const Text('Detalhes',
              textAlign: TextAlign.left,
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black)),
        ),
        body: ListView(children: <Widget>[
          Text("Moeda" " " + widget.coin.name,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black)),
          ChartModelWidget(),
          const Padding(
              padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
              child: Text("Informações",
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black))),
          Container(
            decoration: const BoxDecoration(
                border: Border(
                    top: BorderSide(
                        width: 1.1, color: Color.fromARGB(60, 0, 0, 0)))),
            child: listTile(widget.detailPage.coinName, widget.detailPage.value,
                subtitle: const Text("Valor Atual")),
          ),
          listTile("Valor Atual", widget.detailPage.value),
          listTile("Cap de mercado", widget.detailPage.capMercado,
              backgroundColorVerification: widget.detailPage.capMercado,
              whatStringReturn: ""),
          listTile("Valor mínimo", widget.detailPage.minValue),
          listTile("Valor máximo", widget.detailPage.maxValue),
          Provider.of<StateController>(context, listen: true).elevatedButton(
              context, "Converter moeda",
              routeNavigator: "/conversion"),
        ]));
  }
}
