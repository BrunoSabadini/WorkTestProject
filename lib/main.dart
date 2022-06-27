import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:work_project/StateController.dart';

import 'FirstScreen/MaterialAppAndProviderInstancesWidget.dart';

void main() {
  runApp(ChangeNotifierProvider(
      create: (context) => StateController(),
      child: const MaterialAppAndProviderInstancesWidget()));
}
