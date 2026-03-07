// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'maintenance_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(vehicleMaintenance)
final vehicleMaintenanceProvider = VehicleMaintenanceFamily._();

final class VehicleMaintenanceProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<MaintenanceRecord>>,
          List<MaintenanceRecord>,
          Stream<List<MaintenanceRecord>>
        >
    with
        $FutureModifier<List<MaintenanceRecord>>,
        $StreamProvider<List<MaintenanceRecord>> {
  VehicleMaintenanceProvider._({
    required VehicleMaintenanceFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'vehicleMaintenanceProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$vehicleMaintenanceHash();

  @override
  String toString() {
    return r'vehicleMaintenanceProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $StreamProviderElement<List<MaintenanceRecord>> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<List<MaintenanceRecord>> create(Ref ref) {
    final argument = this.argument as String;
    return vehicleMaintenance(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is VehicleMaintenanceProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$vehicleMaintenanceHash() =>
    r'5e5ab0f568808a962729fdc86a66bd9016866f38';

final class VehicleMaintenanceFamily extends $Family
    with $FunctionalFamilyOverride<Stream<List<MaintenanceRecord>>, String> {
  VehicleMaintenanceFamily._()
    : super(
        retry: null,
        name: r'vehicleMaintenanceProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  VehicleMaintenanceProvider call(String vehicleId) =>
      VehicleMaintenanceProvider._(argument: vehicleId, from: this);

  @override
  String toString() => r'vehicleMaintenanceProvider';
}

@ProviderFor(upcomingMaintenance)
final upcomingMaintenanceProvider = UpcomingMaintenanceFamily._();

final class UpcomingMaintenanceProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<MaintenanceRecord>>,
          List<MaintenanceRecord>,
          FutureOr<List<MaintenanceRecord>>
        >
    with
        $FutureModifier<List<MaintenanceRecord>>,
        $FutureProvider<List<MaintenanceRecord>> {
  UpcomingMaintenanceProvider._({
    required UpcomingMaintenanceFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'upcomingMaintenanceProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$upcomingMaintenanceHash();

  @override
  String toString() {
    return r'upcomingMaintenanceProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<MaintenanceRecord>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<MaintenanceRecord>> create(Ref ref) {
    final argument = this.argument as String;
    return upcomingMaintenance(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is UpcomingMaintenanceProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$upcomingMaintenanceHash() =>
    r'3c53e06fe210f6bfc2502f066144deb35309b362';

final class UpcomingMaintenanceFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<List<MaintenanceRecord>>, String> {
  UpcomingMaintenanceFamily._()
    : super(
        retry: null,
        name: r'upcomingMaintenanceProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  UpcomingMaintenanceProvider call(String userId) =>
      UpcomingMaintenanceProvider._(argument: userId, from: this);

  @override
  String toString() => r'upcomingMaintenanceProvider';
}
