import 'package:qent/core/domain/entities/country_entity.dart';
import 'package:qent/core/domain/entities/location_entity.dart';
import 'package:qent/core/helpers/result.dart';

abstract class LocationRepo {
  Future<Result<List<CountryEntity>>> getCountries();
  Future<Result<List<LocationEntity>>> getLocations();
}
