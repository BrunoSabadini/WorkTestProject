import 'package:flutter/material.dart';

class CompletedConversionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: ListView(
                shrinkWrap: true,
                padding: const EdgeInsets.all(20.0),
                children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: Color.fromARGB(82, 98, 255, 0),
            child: IconButton(
              icon: const Icon(
                Icons.check,
                color: Colors.black,
              ),
              onPressed: () {
                Navigator.of(context, rootNavigator: true).pushNamed("/");
              },
            ),
          ),
          ListTile(
              title: Row(
                children: const [
                  Text(
                    "Conversão efetuada",
                    style:
                        TextStyle(fontWeight: FontWeight.w500, fontSize: 25.0),
                  )
                ],
                mainAxisAlignment: MainAxisAlignment.center,
              ),
              subtitle: Row(
                children: const [
                  Text("Conversão de moeda efetuada com sucesso!")
                ],
                mainAxisAlignment: MainAxisAlignment.center,
              ))
        ])));
  }
}