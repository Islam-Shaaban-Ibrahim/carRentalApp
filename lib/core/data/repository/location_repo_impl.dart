import 'package:injectable/injectable.dart';
import 'package:qent/core/data/models/country_model.dart';
import 'package:qent/core/data/models/location_model.dart';
import 'package:qent/core/data/services/location_service.dart';
import 'package:qent/core/domain/entities/country_entity.dart';
import 'package:qent/core/domain/entities/location_entity.dart';
import 'package:qent/core/domain/repository/location_repo.dart';
import 'package:qent/core/helpers/helper_methods.dart';
import 'package:qent/core/helpers/result.dart';

@LazySingleton(as: LocationRepo)
class LocationRepoImpl implements LocationRepo {
  final LocationService _service;

  LocationRepoImpl(this._service);
  @override
  Future<Result<List<CountryEntity>>> getCountries() async {
    try {
      final response = await _service.getCountries();
      return Result.success(response.map((e) => e.fromModel).toList());
    } catch (e) {
      return Result.error(getErrorMessage(e));
    }
  }

  @override
  Future<Result<List<LocationEntity>>> getLocations() async {
    try {
      final response = await _service.getLocations();
      return Result.success(response.map((e) => e.fromModel).toList());
    } catch (e) {
      return Result.error(getErrorMessage(e));
    }
  }
}
