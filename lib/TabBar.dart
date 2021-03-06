import 'package:flutter/material.dart';
import 'package:work_project/WalletPage/WalletListOrganization.dart';
import 'Models/Transactions.dart';
import 'l10n/app_localizations.dart';

class TabBarState extends State<TabBarWidget> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static final List<Widget> _widgetOptions = <Widget>[
    ListOrganizationWidget(),
    const Text(
      'Home',
      style: optionStyle,
    ),
    const TransactionsWidget(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: const Color.fromARGB(255, 3, 0, 0),
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.card_travel),
            // ImageIcon(AssetImage("lib/Icon/warren.png"),
            //       color: Color.fromARGB(255, 254, 4, 4)),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.card_travel),
            label: AppLocalizations.of(context)?.wallets ??
                "Rever Internationalization",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.toll_outlined),
            label: AppLocalizations.of(context)?.transactions ??
                "Rever Internationalization",
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}

class TabBarWidget extends StatefulWidget {
  const TabBarWidget({Key? key}) : super(key: key);

  @override
  State<TabBarWidget> createState() => TabBarState();
}
