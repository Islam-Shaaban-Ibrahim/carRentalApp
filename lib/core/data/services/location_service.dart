import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:qent/core/constants.dart';
import 'package:qent/core/data/models/country_model.dart';
import 'package:qent/core/data/models/location_model.dart';

abstract class LocationService {
  Future<List<CountryModel>> getCountries();
  Future<List<LocationModel>> getLocations();
}

@LazySingleton(as: LocationService)
class LocationServiceImpl implements LocationService {
  final Dio _dio;

  const LocationServiceImpl(this._dio);
  @override
  Future<List<CountryModel>> getCountries() async {
    final response = await _dio.get(APIConstants.getAllCountriesEndPoint);
    return (response.data['data'] as List)
        .map((e) => CountryModel.fromJson(e))
        .toList();
  }

  @override
  Future<List<LocationModel>> getLocations() async {
    final response = await _dio.get(APIConstants.getLocationsEndPoint);
    return (response.data['data'] as List)
        .map((e) => LocationModel.fromJson(e))
        .toList();
  }
}
