import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;

class StateController with ChangeNotifier {
  IconData eyeShow = Icons.visibility_rounded;
  IconData eyeHide = Icons.visibility_off_rounded;
  bool showHide = false;
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

  Widget elevatedButton(
    BuildContext context,
    String text, {
    Color backgroundButtonColor = const Color.fromARGB(255, 221, 48, 85),
    Color textButtonColor = const Color.fromARGB(255, 255, 255, 255),
    double width = 30,
    double height = 50,
    double fontSize = 20,
    String routeNavigator = "Go to Error Screen",
  }) {
    return ElevatedButton(
      child: Text(text),
      onPressed: () {
        Navigator.of(context, rootNavigator: true).pushNamed(routeNavigator);
      },
      style: ElevatedButton.styleFrom(
          onPrimary: textButtonColor,
          primary: backgroundButtonColor,
          textStyle: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
          )),
    );
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
