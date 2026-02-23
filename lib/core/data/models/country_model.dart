import 'package:qent/core/domain/entities/country_entity.dart';

class CountryModel {
  final int id;
  final String country;
  final String abbreviation;

  const CountryModel({
    required this.id,
    required this.country,
    required this.abbreviation,
  });

  factory CountryModel.fromJson(Map<String, dynamic> json) => CountryModel(
    id: json['id'],
    country: json['country'],
    abbreviation: json['abbreviation'],
  );
}

extension CountryMapper on CountryModel {
  CountryEntity get fromModel =>
      CountryEntity(id: id, country: country, abbreviation: abbreviation);
}
