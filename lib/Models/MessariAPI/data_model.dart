import 'fetch_coins_models.dart';

class DataModel {
  final String id;
  final String name;
  final String symbol;
  final String slug;
  final MetricsModel metricsModel;

  DataModel(this.id, this.name, this.symbol, this.slug, this.metricsModel);
  factory DataModel.fromJson(Map<String, dynamic> json) {
    return DataModel(
      json["id"],
      json["name"],
      json["symbol"],
      json["slug"],
      MetricsModel.fromJson(json["metrics"]),
    );
  }
}
