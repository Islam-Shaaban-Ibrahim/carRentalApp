import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qent/core/di/service_locator.dart';
import 'package:qent/core/domain/entities/country_entity.dart';
import 'package:qent/core/helpers/helper_methods.dart';
import 'package:qent/core/presentation/cubits/location_cubit/location_cubit.dart';
import 'package:qent/core/presentation/cubits/location_cubit/location_state.dart';
import 'package:qent/core/presentation/widgets/app_error_widget.dart';
import 'package:qent/core/presentation/widgets/loading_widget.dart';

Future<dynamic> showCountriesDialog(BuildContext context) {
  return showDialog(
    context: context,
    builder: (_) => Dialog(
      constraints: BoxConstraints(maxHeight: 400.h, maxWidth: 300.w),
      child: BlocProvider(
        create: (context) => serviceLocator<LocationCubit>()..getCountries(),
        child: const _SelectCountryDialog(),
      ),
    ),
  );
}

class _SelectCountryDialog extends StatelessWidget {
  const _SelectCountryDialog();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocationCubit, LocationState>(
      buildWhen: (prev, curr) => curr.isCountriesStates,
      builder: (context, state) {
        switch (state) {
          case CountriesLoading():
            return const LoadingWidget();
          case CountriesLoaded():
            return _CountriesList(countries: state.countries);
          case CountriesError():
            return AppErrorWidget(
              message: state.message,
              onRefresh: () => context.read<LocationCubit>().getCountries(),
            );
          default:
            return const SizedBox.shrink();
        }
      },
    );
  }
}

class _CountriesList extends StatelessWidget {
  const _CountriesList({required this.countries});
  final List<CountryEntity> countries;

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).textTheme.bodyLarge;
    return ListView.builder(
      padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 10.w),
      itemCount: countries.length,
      itemBuilder: (context, index) => ListTile(
        onTap: () {
          Navigator.pop(context, countries[index]);
        },
        leading: Text(
          getFlagEmoji(countries[index].abbreviation),
          style: style!.copyWith(fontSize: 25.sp),
        ),
        title: Text(countries[index].country),
      ),
    );
  }
}
