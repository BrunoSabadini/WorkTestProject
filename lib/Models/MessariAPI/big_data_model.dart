import 'fetch_coins_models.dart';

class BigDataModel {
  final StatusModel statusModel;
  final String? name;
  final String? symbol;
  final String? slug;
  final List? values;

  BigDataModel({
    this.name,
    this.symbol,
    this.slug,
    this.values,
    required this.statusModel,
  });

  factory BigDataModel.fromJson(Map<String, dynamic> json) {
    var dataDictionary = json['data'] as Map<String, dynamic>;
    String symbol = dataDictionary["symbol"];
    String name = dataDictionary["name"];
    String slug = dataDictionary["slug"];
    List values = dataDictionary["values"];

    // List<DataModel> dataModelList =
    //     dataList.map((e) => DataModel.fromJson(e)).toList();

    return BigDataModel(
        statusModel: StatusModel.fromJson(json["status"]),
        name: name,
        slug: slug,
        symbol: symbol,
        values: values);
  }
  BigDataModel.withError(String error, this.name, this.symbol, this.slug)
      : statusModel = StatusModel(error, 0),
        values = [];
}
