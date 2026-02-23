import 'package:qent/core/data/models/country_model.dart';
import 'package:qent/core/data/models/location_model.dart';
import 'package:qent/features/auth/domain/entities/user_entity.dart';

class UserModel {
  final int id;
  final String fullName;
  final String email;
  final String phone;
  final bool phoneIsVerified;
  final CountryModel country;
  final LocationModel location;
  final double balance;
  final String? nationalId;
  final DateTime? dateOfBirth;

  UserModel({
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

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      fullName: json['full_name'],
      email: json['email'],
      phone: json['phone'],
      phoneIsVerified: json['phone_is_verified'],
      country: CountryModel.fromJson(json['country']),
      location: LocationModel.fromJson(json['location']),
      balance: json['balance'].toDouble(),
      nationalId: json['national_id']?.toString(),
      dateOfBirth: json['date_of_birth'] != null
          ? DateTime.parse(json['date_of_birth'])
          : null,
    );
  }
}

extension UserMapper on UserModel {
  UserEntity get fromModel => UserEntity(
    id: id,
    fullName: fullName,
    email: email,
    phone: phone,
    phoneIsVerified: phoneIsVerified,
    country: country.fromModel,
    location: location.fromModel,
    balance: balance,
    nationalId: nationalId,
    dateOfBirth: dateOfBirth,
  );
}
