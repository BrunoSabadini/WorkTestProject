import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:work_project/TabBar.dart';
import 'package:work_project/l10n/app_localizations.dart';
import 'package:work_project/routeGenerator.dart';

import '../../StateController.dart';

class MaterialAppAndProviderInstancesWidget extends StatefulWidget {
  const MaterialAppAndProviderInstancesWidget({Key? key}) : super(key: key);

  @override
  State<MaterialAppAndProviderInstancesWidget> createState() =>
      MaterialAppAndProviderInstancesState();
}

class MaterialAppAndProviderInstancesState
    extends State<MaterialAppAndProviderInstancesWidget> {
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
      home: ChangeNotifierProvider(
        create: (context) => StoreStateController(),
        child: const BottomNavigationBarWidget(),
      ),
    );
  }
}

class L10n {
  static final all = [
    const Locale('en'),
    const Locale('pt'),
  ];
}
