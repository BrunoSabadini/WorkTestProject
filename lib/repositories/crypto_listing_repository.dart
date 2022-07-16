import '../Models/MessariAPI/AllAssetsBigDataModel.dart';
import '../Models/MessariAPI/BigDataModel.dart';
import '../crypto_listing_endpoint.dart';

class CryptoListingRepository {
  final CryptoListingEndpoint cryptoListingEndpoint;

  CryptoListingRepository({required this.cryptoListingEndpoint});

  Future<AllAssetsBigDataModel> getAllCryptoInfo() async {
    final result = await cryptoListingEndpoint.getAllCryptoInfo();
    return AllAssetsBigDataModel.fromJson((result.data));
  }

  Future<BigDataModel> getAllChartsInfo() async {
    final result = await cryptoListingEndpoint.getAllChartsInfo();
    return BigDataModel.fromJson(result.data);
  }
}
