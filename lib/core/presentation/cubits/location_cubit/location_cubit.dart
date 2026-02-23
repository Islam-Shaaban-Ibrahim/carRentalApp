import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:qent/core/domain/repository/location_repo.dart';
import 'package:qent/core/presentation/cubits/location_cubit/location_state.dart';

@injectable
class LocationCubit extends Cubit<LocationState> {
  final LocationRepo _repo;
  LocationCubit(this._repo) : super(const LocationInitial());

  Future<void> getCountries() async {
    emit(const CountriesLoading());
    final result = await _repo.getCountries();
    result.when(
      (failure) => emit(CountriesError(failure)),
      (countries) => emit(CountriesLoaded(countries)),
    );
  }

  Future<void> getLocations() async {
    emit(const LocationLoading());
    final result = await _repo.getLocations();
    result.when(
      (failure) => emit(LocationError(failure)),
      (locations) => emit(LocationLoaded(locations)),
    );
  }
}
