import 'package:dio/dio.dart';
import 'package:intl/intl.dart';
import 'BigDataModel.dart';

class Repository {
  String endPoint;

  Repository(
    this.endPoint,
  );

  static String returnBTCdataFromAPI = "btc";
  static String returnETHdataFromAPI = "eth";
  static String returnLTCdataFromAPI = "ltc";

  var currencyListingAPI =
      '${mainUrl}v1/assets/${returnETHdataFromAPI}/metrics/price/time-series?end=2022-06-10&interval=1d';

  static String mainUrl = "https://data.messari.io/api/";
  final String apiKey = "8d38948c-555a-426f-bf5e-1b70abc6bea6";

  Dio _dio = Dio();
  Future<BigDataModel> getCoins() async {
    try {
      _dio.options.headers["x-messari-api-key"] = apiKey;
      Response response = await _dio.get(endPoint);
      return BigDataModel.fromJson((response.data));
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return BigDataModel.withError("", "", "", "");
    }
  }
}

// String filterEndPointEndDate() {
  //   final DateTime filterNinetyDays =
  //       DateTime.now().subtract(const Duration(days: 50));
  //   final DateFormat formatFilterNinetyDays = DateFormat('yyyy-MM-dd');
  //   final String ninetyDaysAgo =
  //       formatFilterNinetyDays.format(filterNinetyDays);
  //   return ninetyDaysAgo;
  // }

  // String filterEndPointStartDate() {
  //   final DateTime nowTime = DateTime.now();
  //   final DateFormat formatActualTime = DateFormat('yyyy-MM-dd');
  //   final String actualTime = formatActualTime.format(nowTime);
  //   return actualTime;
  // }