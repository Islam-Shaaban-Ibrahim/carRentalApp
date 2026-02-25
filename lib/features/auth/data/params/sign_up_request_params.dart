class SignUpRequestParams {
  final String fullName;
  final String email;
  final String phone;
  final String password;
  final int countryId;
  final int locationId;
  final bool availableToCreateCar;
  final String? nationalId;
  final String? dateOfBirth;

  SignUpRequestParams({
    required this.fullName,
    required this.email,
    required this.phone,
    required this.password,
    required this.countryId,
    required this.locationId,
    required this.availableToCreateCar,
    this.nationalId,
    this.dateOfBirth,
  });

  Map<String, dynamic> toJson() {
    return {
      'full_name': fullName,
      'email': email,
      'phone': phone,
      'password': password,
      'country_id': countryId,
      'location_id': locationId,
      'available_to_create_car': availableToCreateCar,
      if (availableToCreateCar) ...{
        'national_id': nationalId,
        'date_of_birth': dateOfBirth,
      },
    };
  }
}
