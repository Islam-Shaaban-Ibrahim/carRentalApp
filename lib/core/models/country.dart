class Country {
  final String name;
  final String flag;
  final String dialCode;

  final int minLength;
  final int maxLength;

  const Country({
    required this.name,
    required this.flag,
    required this.dialCode,

    required this.minLength,
    required this.maxLength,
  });
}

const List<Country> countries = [
  Country(
    name: 'Egypt',
    flag: '🇪🇬',
    dialCode: '+20',
    minLength: 10,
    maxLength: 10,
  ),
  Country(
    name: 'Saudi Arabia',
    flag: '🇸🇦',
    dialCode: '+966',
    minLength: 9,
    maxLength: 9,
  ),
  Country(
    name: 'United Arab Emirates',
    flag: '🇦🇪',
    dialCode: '+971',
    minLength: 9,
    maxLength: 9,
  ),
  Country(
    name: 'United States',
    flag: '🇺🇸',
    dialCode: '+1',
    minLength: 10,
    maxLength: 10,
  ),
  Country(
    name: 'United Kingdom',
    flag: '🇬🇧',
    dialCode: '+44',
    minLength: 10,
    maxLength: 10,
  ),
  Country(
    name: 'India',
    flag: '🇮🇳',
    dialCode: '+91',
    minLength: 10,
    maxLength: 10,
  ),
];
