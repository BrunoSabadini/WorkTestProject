import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:work_project/Models/MessariAPI/AllAssetsBigDataModel.dart';

import '../Models/MessariAPI/BigDataModel.dart';
import '../crypto_listing_endpoint_provider.dart';
import '../repositories/crypto_listing_repository.dart';

class GetCryptoListingUseCase {
  final CryptoListingRepository repository;
  GetCryptoListingUseCase({required this.repository});

  Future<AllAssetsBigDataModel> execute() async {
    await Future.delayed(const Duration(seconds: 2));
    final response = await repository.getAllCryptoInfo();

    return response;
  }

  Future<BigDataModel> start() async {
    await Future.delayed(const Duration(seconds: 2));
    final response = await repository.getAllChartsInfo();

    return response;
  }
}

final cryptoListingRepositoryProvider = Provider((ref) {
  return CryptoListingRepository(
      cryptoListingEndpoint: ref.read(cryptoListingEndpointProvider));
});

final getCryptoListingUseCase = Provider((ref) {
  return GetCryptoListingUseCase(
      repository: ref.read(cryptoListingRepositoryProvider));
});

final cryptoListingProvider =
    FutureProvider<AllAssetsBigDataModel>((ref, arg) async {
  return ref.read(getCryptoListingUseCase(arg)).execute();
});

final chartsListingProvider = FutureProvider<BigDataModel>((ref) async {
  return ref.read(getCryptoListingUseCase).start();
});
