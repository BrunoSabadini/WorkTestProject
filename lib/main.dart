import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:work_project/HomeScreen.dart';
import 'package:work_project/StateController.dart';

void main() {
  runApp(ChangeNotifierProvider(
      create: (context) => ShowHideController(),
      child: HomeScreenStructureWidget()));
}
