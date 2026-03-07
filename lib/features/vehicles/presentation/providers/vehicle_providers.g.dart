// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vehicle_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(vehicles)
final vehiclesProvider = VehiclesFamily._();

final class VehiclesProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Vehicle>>,
          List<Vehicle>,
          Stream<List<Vehicle>>
        >
    with $FutureModifier<List<Vehicle>>, $StreamProvider<List<Vehicle>> {
  VehiclesProvider._({
    required VehiclesFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'vehiclesProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$vehiclesHash();

  @override
  String toString() {
    return r'vehiclesProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $StreamProviderElement<List<Vehicle>> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<List<Vehicle>> create(Ref ref) {
    final argument = this.argument as String;
    return vehicles(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is VehiclesProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$vehiclesHash() => r'a5d794421d1fda98518086f2cd32791a5901908a';

final class VehiclesFamily extends $Family
    with $FunctionalFamilyOverride<Stream<List<Vehicle>>, String> {
  VehiclesFamily._()
    : super(
        retry: null,
        name: r'vehiclesProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  VehiclesProvider call(String userId) =>
      VehiclesProvider._(argument: userId, from: this);

  @override
  String toString() => r'vehiclesProvider';
}

@ProviderFor(vehicle)
final vehicleProvider = VehicleFamily._();

final class VehicleProvider
    extends $FunctionalProvider<AsyncValue<Vehicle>, Vehicle, FutureOr<Vehicle>>
    with $FutureModifier<Vehicle>, $FutureProvider<Vehicle> {
  VehicleProvider._({
    required VehicleFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'vehicleProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$vehicleHash();

  @override
  String toString() {
    return r'vehicleProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<Vehicle> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<Vehicle> create(Ref ref) {
    final argument = this.argument as String;
    return vehicle(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is VehicleProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$vehicleHash() => r'26aeaf03a0425e0d033dd9c119ff21e8a32074b6';

final class VehicleFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<Vehicle>, String> {
  VehicleFamily._()
    : super(
        retry: null,
        name: r'vehicleProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  VehicleProvider call(String id) =>
      VehicleProvider._(argument: id, from: this);

  @override
  String toString() => r'vehicleProvider';
}

@ProviderFor(primaryVehicle)
final primaryVehicleProvider = PrimaryVehicleFamily._();

final class PrimaryVehicleProvider
    extends
        $FunctionalProvider<AsyncValue<Vehicle?>, Vehicle?, Stream<Vehicle?>>
    with $FutureModifier<Vehicle?>, $StreamProvider<Vehicle?> {
  PrimaryVehicleProvider._({
    required PrimaryVehicleFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'primaryVehicleProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$primaryVehicleHash();

  @override
  String toString() {
    return r'primaryVehicleProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $StreamProviderElement<Vehicle?> $createElement($ProviderPointer pointer) =>
      $StreamProviderElement(pointer);

  @override
  Stream<Vehicle?> create(Ref ref) {
    final argument = this.argument as String;
    return primaryVehicle(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is PrimaryVehicleProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$primaryVehicleHash() => r'1d0ac3c609f1c93dd470ad91552664a17b6da632';

final class PrimaryVehicleFamily extends $Family
    with $FunctionalFamilyOverride<Stream<Vehicle?>, String> {
  PrimaryVehicleFamily._()
    : super(
        retry: null,
        name: r'primaryVehicleProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  PrimaryVehicleProvider call(String userId) =>
      PrimaryVehicleProvider._(argument: userId, from: this);

  @override
  String toString() => r'primaryVehicleProvider';
}
