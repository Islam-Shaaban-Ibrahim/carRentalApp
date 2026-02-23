import 'package:qent/core/domain/entities/location_entity.dart';

class LocationModel {
  final int id;
  final String name;
  final double lat;
  final double lng;

  const LocationModel({
    required this.id,
    required this.name,
    required this.lat,
    required this.lng,
  });

  factory LocationModel.fromJson(Map<String, dynamic> json) => LocationModel(
    id: json['id'],
    name: json['name'],
    lat: json['lat'],
    lng: json['lng'],
  );
}

extension LocationMapper on LocationModel {
  LocationEntity get fromModel =>
      LocationEntity(id: id, name: name, lat: lat, lng: lng);
}
