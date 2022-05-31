class StatusModel {
  final String timestamp;

  final int elapsed;

  StatusModel(
    this.timestamp,
    this.elapsed,
  );
  StatusModel.fromJson(Map<String, dynamic> json)
      : timestamp = json["timestamp"] == null ? "" : json["timestamp"],
        elapsed = json["elapsed"] == null ? 0 : json["elapsed"];
}
