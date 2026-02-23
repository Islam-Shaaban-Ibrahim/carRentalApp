import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qent/core/di/service_locator.dart';
import 'package:qent/core/domain/entities/location_entity.dart';
import 'package:qent/core/presentation/cubits/location_cubit/location_cubit.dart';
import 'package:qent/core/presentation/cubits/location_cubit/location_state.dart';
import 'package:qent/core/presentation/widgets/app_error_widget.dart';
import 'package:qent/core/presentation/widgets/loading_widget.dart';

Future<dynamic> showLocationDialog(BuildContext context) {
  return showDialog(
    context: context,
    builder: (_) => Dialog(
      constraints: BoxConstraints(maxHeight: 400.h, maxWidth: 300.w),
      child: BlocProvider(
        create: (context) => serviceLocator<LocationCubit>()..getLocations(),
        child: const _SelectLocationDialog(),
      ),
    ),
  );
}

class _SelectLocationDialog extends StatelessWidget {
  const _SelectLocationDialog();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocationCubit, LocationState>(
      buildWhen: (prev, curr) => curr.isLocationStates,
      builder: (context, state) {
        switch (state) {
          case LocationLoading():
            return const LoadingWidget();
          case LocationLoaded():
            return _LocationsList(locations: state.locations);
          case LocationError():
            return AppErrorWidget(
              message: state.message,
              onRefresh: () => context.read<LocationCubit>().getLocations(),
            );
          default:
            return const SizedBox.shrink();
        }
      },
    );
  }
}

class _LocationsList extends StatelessWidget {
  const _LocationsList({required this.locations});
  final List<LocationEntity> locations;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 10.w),
      itemCount: locations.length,
      itemBuilder: (context, index) => ListTile(
        onTap: () {
          Navigator.pop(context, locations[index]);
        },
        leading: const Icon(Icons.location_on),
        title: Text(locations[index].name),
      ),
    );
  }
}
