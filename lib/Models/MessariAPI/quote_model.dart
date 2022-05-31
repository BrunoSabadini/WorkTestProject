import 'usd_model.dart';

class MetricsModel {
  final UsdModel usdModel;

  MetricsModel({
    required this.usdModel,
  });
  factory MetricsModel.fromJson(Map<String, dynamic> json) {
    return MetricsModel(
      usdModel: UsdModel.fromJson(json["market_data"]),
    );
  }
}
