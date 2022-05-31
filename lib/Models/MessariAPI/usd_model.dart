class UsdModel {
  final num price;
  final num volume24h;
  final num percentChange_1h;
  final num percentChange_24h;

  UsdModel({
    required this.price,
    required this.volume24h,
    required this.percentChange_1h,
    required this.percentChange_24h,
  });

  factory UsdModel.fromJson(Map<String, dynamic> json) {
    return UsdModel(
      price: json["price_usd"] == null ? 0.0 : json["price_usd"],
      volume24h: json["volume_last_24_hours"] == null
          ? 0.0
          : json["volume_last_24_hours"],
      percentChange_1h: json["percent_change_usd_last_1_hour"] == null
          ? 0.0
          : json["percent_change_usd_last_1_hour"],
      percentChange_24h: json["percent_change_usd_last_24_hours"] == null
          ? 0.0
          : json["percent_change_usd_last_24_hours"],
    );
  }
}
