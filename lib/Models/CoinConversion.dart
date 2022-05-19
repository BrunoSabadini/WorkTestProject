import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:work_project/StateController.dart';

class CoinsConversionWidget extends StatefulWidget {
  CoinsConversionWidget({Key? key}) : super(key: key);

  @override
  State<CoinsConversionWidget> createState() => CoinsConversionState();
}

class CoinsConversionState extends State<CoinsConversionWidget> {
  String dropdownvalue = 'Bitcoin';
  dynamic textFieldConversionAmount = TextEditingController();

  var items = [
    'Bitcoin',
    'Ethereum',
    'Litecoin',
  ];

  Widget percetageToConvertCoin(double percentage) {
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
                    },
                    child: Container(
                        child: Text(
                          "${percentage}" + "%",
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
      value: dropdownvalue,
      icon: const Icon(Icons.keyboard_arrow_down),
      items: items.map((String items) {
        return DropdownMenuItem(
          value: items,
          child: Text(items),
        );
      }).toList(),
      onChanged: (String? newValue) {
        setState(() {
          dropdownvalue = newValue!;
        });
      },
    );
  }

  Widget conversionField(String text) {
    return TextFormField(
      controller: textFieldConversionAmount,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        border: const UnderlineInputBorder(),
        labelText: text,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(children: <Widget>[
      textTitles("Conversão de moeda", fontsize: 30),
      Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
          child: textTitles("Converter de:")),
      dropdownButton(dropdownvalue),
      conversionField('Montante a ser convertido'),
      Row(children: [
        Expanded(child: percetageToConvertCoin(25)),
        Expanded(child: percetageToConvertCoin(50)),
        Expanded(child: percetageToConvertCoin(75)),
        Expanded(child: percetageToConvertCoin(100))
      ]),
      textTitles("Para receber em:"),
      dropdownButton(dropdownvalue),
      conversionField('Montante após conversão'),
      Row(children: [
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
                .elevatedButton(
          context,
          "Confirmar",
          width: double.infinity,
        )),
        Spacer(),
      ]),
    ]));
  }
}
