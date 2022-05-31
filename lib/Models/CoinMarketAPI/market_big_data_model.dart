import 'market_fetch_coins_models.dart';

class MarketBigDataModel {
  final MarketStatusModel statusModel;
  final List<MarketDataModel> dataModel;

  MarketBigDataModel({
    required this.statusModel,
    required this.dataModel,
  });
  factory MarketBigDataModel.fromJson(Map<String, dynamic> json) {
    var dataList = json['data'] as List;
    List<MarketDataModel> dataModelList =
        dataList.map((e) => MarketDataModel.fromJson(e)).toList();
    return MarketBigDataModel(
      statusModel: MarketStatusModel.fromJson(json["status"]),
      dataModel: dataModelList,
    );
  }
  MarketBigDataModel.withError(String error)
      : statusModel = MarketStatusModel(error, 0, error, 0, 0, error, 0),
        dataModel = [];
}
