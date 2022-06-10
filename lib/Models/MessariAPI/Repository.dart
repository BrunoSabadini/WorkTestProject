import 'package:dio/dio.dart';
import 'package:intl/intl.dart';

import 'big_data_model.dart';

class Repository {
  String filterEndPointEndDate() {
    final DateTime filterNinetyDays =
        DateTime.now().subtract(const Duration(days: 50));
    final DateFormat formatFilterNinetyDays = DateFormat('yyyy-MM-dd');
    final String ninetyDaysAgo =
        formatFilterNinetyDays.format(filterNinetyDays);
    return ninetyDaysAgo;
  }

  String filterEndPointStartDate() {
    final DateTime nowTime = DateTime.now();
    final DateFormat formatActualTime = DateFormat('yyyy-MM-dd');
    final String actualTime = formatActualTime.format(nowTime);
    return actualTime;
  }

  static String mainUrl = "https://data.messari.io/api/";
  final String apiKey = "8d38948c-555a-426f-bf5e-1b70abc6bea6";
  String EndPoint = "";
  var currencyListingAPI =
      '${mainUrl}v1/assets/btc/metrics/price/time-series?end=2022-06-10&interval=1d';
  Dio _dio = Dio();
  Future<BigDataModel> getCoins() async {
    try {
      _dio.options.headers["x-messari-api-key"] = apiKey;
      Response response = await _dio.get(currencyListingAPI);
      return BigDataModel.fromJson((response.data));
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return BigDataModel.withError("", "", "", "");
    }
  }
}
