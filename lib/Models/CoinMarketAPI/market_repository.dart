import 'package:dio/dio.dart';

import 'market_big_data_model.dart';

class MarketRepository {
  static String mainUrl = "https://pro-api.coinmarketcap.com/v1/";
  final String apiKey = "18010805-13a2-41e1-b5a8-dd90897ad118";
  var currencyListingAPI = '${mainUrl}cryptocurrency/listings/latest';
  Dio _dio = Dio();
  Future<MarketBigDataModel> getCoins() async {
    try {
      _dio.options.headers["X-CMC_PRO_API_KEY"] = apiKey;
      Response response = await _dio.get(currencyListingAPI);
      return MarketBigDataModel.fromJson((response.data));
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return MarketBigDataModel.withError("error");
    }
  }
}
