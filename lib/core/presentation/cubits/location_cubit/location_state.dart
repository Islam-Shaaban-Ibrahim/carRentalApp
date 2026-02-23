import 'package:equatable/equatable.dart';
import 'package:qent/core/domain/entities/country_entity.dart';
import 'package:qent/core/domain/entities/location_entity.dart';

extension LocationStateX on LocationState {
  bool get isLocationStates =>
      this is LocationLoading ||
      this is LocationLoaded ||
      this is LocationError;

  bool get isCountriesStates =>
      this is CountriesLoading ||
      this is CountriesLoaded ||
      this is CountriesError;
}

sealed class LocationState extends Equatable {
  const LocationState();

  @override
  List<Object> get props => [];
}

final class LocationInitial extends LocationState {
  const LocationInitial();
}

final class LocationLoading extends LocationState {
  const LocationLoading();
}

final class LocationLoaded extends LocationState {
  const LocationLoaded(this.locations);
  final List<LocationEntity> locations;

  @override
  List<Object> get props => [locations];
}

final class LocationError extends LocationState {
  const LocationError(this.message);
  final String message;

  @override
  List<Object> get props => [message];
}

final class CountriesLoading extends LocationState {
  const CountriesLoading();
}

final class CountriesLoaded extends LocationState {
  const CountriesLoaded(this.countries);
  final List<CountryEntity> countries;

  @override
  List<Object> get props => [countries];
}

final class CountriesError extends LocationState {
  const CountriesError(this.message);
  final String message;

  @override
  List<Object> get props => [message];
}
