import 'package:equatable/equatable.dart';

class CountryEntity extends Equatable {
  final int id;
  final String country;
  final String abbreviation;

  const CountryEntity({
    required this.id,
    required this.country,
    required this.abbreviation,
  });

  @override
  List<Object?> get props => [id, country, abbreviation];
}
