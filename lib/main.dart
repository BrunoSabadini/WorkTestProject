import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:work_project/WalletPage/WalletBuild.dart';
import 'package:work_project/StateController.dart';

void main() {
  runApp(ChangeNotifierProvider(
      create: (context) => StateController(),
      child: const HomeScreenStructureWidget()));
}
