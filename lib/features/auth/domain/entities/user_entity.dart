import 'package:equatable/equatable.dart';
import 'package:qent/core/domain/entities/country_entity.dart';
import 'package:qent/core/domain/entities/location_entity.dart';

class UserEntity extends Equatable {
  final int id;
  final String fullName;
  final String email;
  final String phone;
  final bool phoneIsVerified;
  final CountryEntity country;
  final LocationEntity location;
  final double balance;
  final String? nationalId;
  final DateTime? dateOfBirth;

  const UserEntity({
    required this.id,
    required this.fullName,
    required this.email,
    required this.phone,
    required this.phoneIsVerified,
    required this.country,
    required this.location,
    required this.balance,
    this.nationalId,
    this.dateOfBirth,
  });

  @override
  List<Object?> get props => [
    id,
    fullName,
    email,
    phone,
    phoneIsVerified,
    country,
    location,
    balance,
    nationalId,
    dateOfBirth,
  ];
}
