import 'package:dio/dio.dart';

import 'big_data_model.dart';

class Repository {
  static String mainUrl = "https://data.messari.io/api/v2/assets";
  final String apiKey = "8d38948c-555a-426f-bf5e-1b70abc6bea6";
  var currencyListingAPI = mainUrl;
  Dio _dio = Dio();
  Future<BigDataModel> getCoins() async {
    try {
      _dio.options.headers["x-messari-api-key"] = apiKey;
      Response response = await _dio.get(currencyListingAPI);
      return BigDataModel.fromJson((response.data));
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return BigDataModel.withError("error");
    }
  }
}
