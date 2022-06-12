class AllAssetsStatusModel {
  final String timestamp;
  final int elapsed;

  AllAssetsStatusModel(
    this.timestamp,
    this.elapsed,
  );
  AllAssetsStatusModel.fromJson(Map<String, dynamic> json)
      : timestamp = json["timestamp"] == null ? "" : json["timestamp"],
        elapsed = json["elapsed"] == null ? 0 : json["elapsed"];
}
