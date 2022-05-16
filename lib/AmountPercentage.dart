import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:work_project/StateController.dart';

class CoinAmountAndPercentageWidget extends StatefulWidget {
  const CoinAmountAndPercentageWidget(
      {Key? key, required this.amount, required this.percentage})
      : super(key: key);
  final double amount;
  final double percentage;

  @override
  State<CoinAmountAndPercentageWidget> createState() =>
      CoinAmountAndPercentageState();
}

class CoinAmountAndPercentageState
    extends State<CoinAmountAndPercentageWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Text(Provider.of<ShowHideController>(context, listen: true)
          .amountFunc(widget.amount)),
      (Provider.of<ShowHideController>(context, listen: true)
          .greenOrRedBackground())
      // myWidget("+" + widget.percentage.toString() + "%")
    ]);
  }
}
