import 'usd_model.dart';

class MetricsModel {
  final MarketDataModel usdModel;

  MetricsModel({
    required this.usdModel,
  });
  factory MetricsModel.fromJson(Map<String, dynamic> json) {
    return MetricsModel(
      usdModel: MarketDataModel.fromJson(json["market_data"]),
    );
  }
}
