import 'internationalization.dart';

/// The translations for Spanish Castilian (`es`).
class InternationalizationEs extends PedroLouco {
  InternationalizationEs([String locale = 'es']) : super(locale);

  @override
  String get language => 'español';

  @override
  String get wallet => 'cartera';
}
