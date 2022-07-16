import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'FirstScreen/MaterialAppAndProviderInstancesWidget.dart';

void main() {
  runApp(const ProviderScope(child: MaterialAppAndProviderInstancesWidget()));
}
