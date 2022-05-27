import 'package:dio/dio.dart';

import 'fetchCoins_models/big_data_model.dart';

class Repository {
  static String mainUrl = "https://pro-api.coinmarketcap.com/v1/";
  final String apiKey = "18010805-13a2-41e1-b5a8-dd90897ad118";
  var currencyListingAPI = '${mainUrl}cryptocurrency/listings/latest';
  Dio _dio = Dio();
  Future<BigDataModel> getCoins() async {
    try {
      _dio.options.headers["X-CMC_PRO_API_KEY"] = apiKey;
      Response response = await _dio.get(currencyListingAPI);
      return BigDataModel.fromJson((response.data));
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return BigDataModel.withError("error");
    }
  }
}
