class AllAssetsDataModel {
  final String name;
  final String symbol;
  final String slug;
  // final MetricsModel metricsModel;

  AllAssetsDataModel(this.name, this.symbol, this.slug);

  factory AllAssetsDataModel.fromJson(Map<String, dynamic> json) {
    return AllAssetsDataModel(
      json["name"],
      json["symbol"],
      json["slug"],
      // MetricsModel.fromJson(json["metrics"]),
    );
  }
}
