// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../../features/auth/data/repository/auth_repo_impl.dart' as _i751;
import '../../features/auth/data/services/auth_service.dart' as _i449;
import '../../features/auth/domain/repository/auth_repo.dart' as _i976;
import '../../features/auth/presentation/cubit/auth_cubit.dart' as _i117;
import '../data/repository/location_repo_impl.dart' as _i947;
import '../data/services/location_service.dart' as _i475;
import '../domain/repository/location_repo.dart' as _i390;
import '../presentation/cubits/location_cubit/location_cubit.dart' as _i318;
import '../services/cache_service.dart' as _i717;
import '../services/internet_connection_service.dart' as _i350;
import 'register_module.dart' as _i291;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final registerModule = _$RegisterModule();
    gh.lazySingleton<_i361.Dio>(() => registerModule.dio);
    gh.lazySingleton<_i717.SecureStorage>(() => _i717.SecureStorage());
    gh.lazySingleton<_i449.AuthService>(
      () => _i449.AuthServiceImpl(gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i475.LocationService>(
      () => _i475.LocationServiceImpl(gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i350.InternetConnectionService>(
      () => _i350.InternetConnectionServiceImpl(),
    );
    gh.lazySingleton<_i390.LocationRepo>(
      () => _i947.LocationRepoImpl(gh<_i475.LocationService>()),
    );
    gh.lazySingleton<_i976.AuthRepo>(
      () => _i751.AuthRepoImpl(gh<_i449.AuthService>()),
    );
    gh.factory<_i318.LocationCubit>(
      () => _i318.LocationCubit(gh<_i390.LocationRepo>()),
    );
    gh.singleton<_i117.AuthCubit>(() => _i117.AuthCubit(gh<_i976.AuthRepo>()));
    return this;
  }
}

class _$RegisterModule extends _i291.RegisterModule {}
