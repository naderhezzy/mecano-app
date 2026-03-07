enum FuelType {
  gasoline,
  diesel,
  electric,
  hybrid,
  lpg;

  String get label {
    switch (this) {
      case FuelType.gasoline:
        return 'Gasoline';
      case FuelType.diesel:
        return 'Diesel';
      case FuelType.electric:
        return 'Electric';
      case FuelType.hybrid:
        return 'Hybrid';
      case FuelType.lpg:
        return 'LPG';
    }
  }
}
