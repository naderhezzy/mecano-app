class Validators {
  Validators._();

  static final _emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
  static final _tunisianPhoneRegex = RegExp(r'^(\+216)?[2-9]\d{7}$');
  static final _tunisianPlateRegex = RegExp(
    r'^\d{1,3}\s?TU\s?\d{1,4}$|^\d{1,3}\s?تونس\s?\d{1,4}$',
    caseSensitive: false,
  );
  static final _vinRegex = RegExp(r'^[A-HJ-NPR-Z0-9]{17}$');

  static String? email(String? value) {
    if (value == null || value.isEmpty) return 'Email is required';
    if (!_emailRegex.hasMatch(value)) return 'Invalid email format';
    return null;
  }

  static String? password(String? value) {
    if (value == null || value.isEmpty) return 'Password is required';
    if (value.length < 8) return 'Password must be at least 8 characters';
    return null;
  }

  static String? required(String? value, [String field = 'This field']) {
    if (value == null || value.trim().isEmpty) return '$field is required';
    return null;
  }

  static String? phone(String? value) {
    if (value == null || value.isEmpty) return 'Phone number is required';
    final cleaned = value.replaceAll(RegExp(r'[\s-]'), '');
    if (!_tunisianPhoneRegex.hasMatch(cleaned)) {
      return 'Invalid Tunisian phone number';
    }
    return null;
  }

  static String? plateNumber(String? value) {
    if (value == null || value.isEmpty) return null; // Optional field
    if (!_tunisianPlateRegex.hasMatch(value.trim())) {
      return 'Invalid Tunisian plate format (e.g. 123 TU 4567)';
    }
    return null;
  }

  static String? vin(String? value) {
    if (value == null || value.isEmpty) return null; // Optional field
    if (!_vinRegex.hasMatch(value.toUpperCase())) {
      return 'Invalid VIN (must be 17 alphanumeric characters)';
    }
    return null;
  }

  static String? year(String? value) {
    if (value == null || value.isEmpty) return 'Year is required';
    final year = int.tryParse(value);
    if (year == null) return 'Invalid year';
    final currentYear = DateTime.now().year;
    if (year < 1970 || year > currentYear + 1) {
      return 'Year must be between 1970 and ${currentYear + 1}';
    }
    return null;
  }

  static String? mileage(String? value) {
    if (value == null || value.isEmpty) return 'Mileage is required';
    final mileage = int.tryParse(value.replaceAll(RegExp(r'[,\s]'), ''));
    if (mileage == null || mileage < 0) return 'Invalid mileage';
    if (mileage > 2000000) return 'Mileage seems too high';
    return null;
  }
}
