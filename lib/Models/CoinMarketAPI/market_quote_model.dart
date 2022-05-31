import 'market_usd_model.dart';

class MarketQuoteModel {
  final MarketUsdModel usdModel;

  MarketQuoteModel({
    required this.usdModel,
  });
  factory MarketQuoteModel.fromJson(Map<String, dynamic> json) {
    return MarketQuoteModel(
      usdModel: MarketUsdModel.fromJson(json["USD"]),
    );
  }
}
