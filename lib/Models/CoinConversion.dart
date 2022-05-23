import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:work_project/StateController.dart';

class CoinsConversionWidget extends StatefulWidget {
  CoinsConversionWidget({Key? key}) : super(key: key);

  @override
  State<CoinsConversionWidget> createState() => CoinsConversionState();
}

class CoinsConversionState extends State<CoinsConversionWidget> {
  String selectWichCoinConvert = 'Bitcoin';
  String selectToWichCoinConvert = 'Bitcoin';
  dynamic conversionFieldAmount = TextEditingController();
  dynamic convertedFieldAmount = TextEditingController();
  double coinAmountToReturnAccordingToPercentage = 0;
  String textToConversionField = "Montante a ser convertido";
  String textToConvertedField = "Montante após conversão";

  var items = [
    'Bitcoin',
    'Ethereum',
    'Litecoin',
  ];

  var items2 = [
    'Bitcoin',
    'Ethereum',
    'Litecoin',
  ];

  double convertCoin() {
    double currentValueConvertedCoin = 0;
    double currentValueConvertedToCoin = 0;

    if (selectWichCoinConvert == 'Bitcoin') {
      currentValueConvertedCoin =
          Provider.of<StateController>(context, listen: false)
              .bitcoinCurrentValue;
    }
    if (selectWichCoinConvert == 'Ethereum') {
      currentValueConvertedCoin =
          Provider.of<StateController>(context, listen: false)
              .ethereumCurrentValue;
    }
    if (selectWichCoinConvert == 'Litecoin') {
      currentValueConvertedCoin =
          Provider.of<StateController>(context, listen: false)
              .litecoinCurrentValue;
    }
    if (selectToWichCoinConvert == 'Bitcoin') {
      currentValueConvertedToCoin =
          Provider.of<StateController>(context, listen: false)
              .bitcoinCurrentValue;
    }
    if (selectToWichCoinConvert == 'Ethereum') {
      currentValueConvertedToCoin =
          Provider.of<StateController>(context, listen: false)
              .ethereumCurrentValue;
    }
    if (selectToWichCoinConvert == 'Litecoin') {
      currentValueConvertedToCoin =
          Provider.of<StateController>(context, listen: false)
              .litecoinCurrentValue;
    }
    return (currentValueConvertedCoin / currentValueConvertedToCoin) *
        conversionFieldAmount;
  }

  Widget conversionField(
      dynamic recieveFieldValues, String staticConversionFieldText) {
    return TextFormField(
      controller: recieveFieldValues,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        border: const UnderlineInputBorder(),
        labelText: staticConversionFieldText,
      ),
    );
  }

  Widget percetageToConvertCoin(double percentage) {
    Provider.of<StateController>(context, listen: false).pickWhichCoinConvert =
        selectWichCoinConvert;

    return Center(
        child: Container(
            width: 30,
            child: Material(
                child: InkWell(
                    onTap: () {
                      Provider.of<StateController>(context, listen: false)
                          .percentageToConvert = percentage;
                      Provider.of<StateController>(context, listen: false)
                          .coinAmountConversion();
                      coinAmountToReturnAccordingToPercentage =
                          Provider.of<StateController>(context, listen: false)
                              .coinAmountConversion();
                      textToConvertedField = "2222";
                      setState(() {
                        textToConversionField =
                            Provider.of<StateController>(context, listen: false)
                                .numberFormatConversion(
                                    coinAmountToReturnAccordingToPercentage);
                      });
                    },
                    child: Container(
                        child: Text(
                          "$percentage" "%",
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontSize: 10),
                        ),
                        decoration: BoxDecoration(
                            border:
                                Border.all(color: Color.fromARGB(255, 0, 0, 0)),
                            borderRadius: const BorderRadius.all(
                                Radius.circular(10.0))))))));
  }

  Widget textTitles(String text, {double fontsize = 24}) {
    return Text(text,
        textAlign: TextAlign.center,
        style: TextStyle(
            fontSize: fontsize,
            fontWeight: FontWeight.bold,
            color: Colors.black));
  }

  Widget dropdownButton(String text, {double fontsize = 24}) {
    return DropdownButton(
      alignment: Alignment.center,
      value: selectWichCoinConvert,
      icon: const Icon(Icons.keyboard_arrow_down),
      items: items.map((String items) {
        return DropdownMenuItem(
          value: items,
          child: Text(items),
        );
      }).toList(),
      onChanged: (String? newValue) {
        setState(() {
          selectWichCoinConvert = newValue!;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(children: <Widget>[
      Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 0, 30),
          child: textTitles("Conversão de moeda", fontsize: 30)),
      Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 0, 30),
          child: textTitles("Converter de:")),
      Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 0, 30),
          child: DropdownButton(
            alignment: Alignment.center,
            value: selectWichCoinConvert,
            icon: const Icon(Icons.keyboard_arrow_down),
            items: items.map((String items) {
              return DropdownMenuItem(
                value: items,
                child: Text(items),
              );
            }).toList(),
            onChanged: (String? newValue) {
              setState(() {
                selectWichCoinConvert = newValue!;
              });
            },
          )),
      conversionField(conversionFieldAmount, textToConversionField),
      Padding(
          padding: const EdgeInsets.fromLTRB(20, 20, 0, 30),
          child: Row(children: [
            Expanded(child: percetageToConvertCoin(25)),
            Expanded(child: percetageToConvertCoin(50)),
            Expanded(child: percetageToConvertCoin(75)),
            Expanded(child: percetageToConvertCoin(100))
          ])),
      textTitles("Para receber em:"),
      DropdownButton(
        alignment: Alignment.center,
        value: selectToWichCoinConvert,
        icon: const Icon(Icons.keyboard_arrow_down),
        items: items2.map((String items) {
          return DropdownMenuItem(
            value: items,
            child: Text(items),
          );
        }).toList(),
        onChanged: (String? newValue) {
          setState(() {
            selectToWichCoinConvert = newValue!;
          });
        },
      ),
      conversionField(convertedFieldAmount, textToConvertedField),
      Padding(
        padding: const EdgeInsets.fromLTRB(20, 20, 0, 30),
        child: Row(children: [
          Spacer(),
          Expanded(
              child: Provider.of<StateController>(context, listen: true)
                  .elevatedButton(context, "Cancelar",
                      width: double.infinity,
                      backgroundButtonColor: Color.fromARGB(255, 255, 255, 255),
                      textButtonColor: const Color.fromARGB(255, 221, 48, 85),
                      routeNavigator: '/bitcoin')),
          Expanded(
              child: Provider.of<StateController>(context, listen: true)
                  .elevatedButton(context, "Confirmar",
                      width: double.infinity,
                      routeNavigator: '/completedConversion')),
          Spacer(),
        ]),
      )
    ]));
  }
}
