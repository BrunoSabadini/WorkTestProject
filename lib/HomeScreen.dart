import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:work_project/WalletPage/WalletListOrganization.dart';
import 'package:work_project/TabBar.dart';
import 'package:work_project/l10n/app_localizations.dart';
import 'package:work_project/routeGenerator.dart';

class HomeScreenStructureState extends State<HomeScreenStructureWidget> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: L10n.all,
      onGenerateRoute: RouteGenerator.generateRoute,
      home: Scaffold(
          body: ListOrganizationWidget(),
          bottomNavigationBar: const TabBarWidget()),
    );
  }
}

class HomeScreenStructureWidget extends StatefulWidget {
  const HomeScreenStructureWidget({Key? key}) : super(key: key);

  @override
  State<HomeScreenStructureWidget> createState() => HomeScreenStructureState();
}

class L10n {
  static final all = [
    const Locale('en'),
    const Locale('pt'),
  ];
}
