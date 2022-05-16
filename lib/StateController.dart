import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;

class ShowHideController with ChangeNotifier {
  IconData eyeShow = Icons.visibility_rounded;
  IconData eyeHide = Icons.visibility_off_rounded;
  bool showHide = true;
  String showWallet = "R\$ 87.000,00";
  String hideWallet = "----------------";
  String profit = "+R\$ 100,00";
  String remuneration = "(100% do CDI)";
  double amount = 50000.00;

  Widget greenOrRedBackground(
      {String text = "", num? backgroundColorVerification}) {
    if (backgroundColorVerification == null) {
      return Container(
        margin: const EdgeInsets.only(top: 10.0),
        width: 55,
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 13.0),
        ),
      );
    }
    if (backgroundColorVerification > 0) {
      return Container(
        margin: const EdgeInsets.only(top: 10.0),
        width: 55,
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            color: Color.fromARGB(255, 188, 255, 190)),
        child: Text(
          "+" + text + "%",
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 13.0),
        ),
      );
    } else {
      return Container(
          margin: const EdgeInsets.only(top: 10.0),
          width: 55,
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              color: Color.fromARGB(157, 255, 136, 136)),
          child: Text(
            "-" + text + "%",
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 13.0),
          ));
    }
  }

  void switchShowHide() {
    showHide = !showHide;
    notifyListeners();
  }

  eyefunc() {
    if (showHide == false) {
      return eyeShow;
    } else {
      return eyeHide;
    }
  }

  amountFunc(double amount) {
    if (showHide == false) {
      return numberFormatConversion(amount);
    } else {
      return hideWallet;
    }
  }

  String numberFormatConversion(double value,
      {String whatStringReturn = "R\$"}) {
    return intl.NumberFormat.currency(locale: 'pt_BR', name: whatStringReturn)
        .format(value);
  }

  profitFunc() {
    if (showHide == false) {
      return profit;
    } else {
      return "";
    }
  }

  remunerationFunc() {
    if (showHide == false) {
      return remuneration;
    } else {
      return "";
    }
  }
}
