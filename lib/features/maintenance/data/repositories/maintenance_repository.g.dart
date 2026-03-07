// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'maintenance_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(maintenanceRepository)
final maintenanceRepositoryProvider = MaintenanceRepositoryProvider._();

final class MaintenanceRepositoryProvider
    extends
        $FunctionalProvider<
          MaintenanceRepository,
          MaintenanceRepository,
          MaintenanceRepository
        >
    with $Provider<MaintenanceRepository> {
  MaintenanceRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'maintenanceRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$maintenanceRepositoryHash();

  @$internal
  @override
  $ProviderElement<MaintenanceRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  MaintenanceRepository create(Ref ref) {
    return maintenanceRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(MaintenanceRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<MaintenanceRepository>(value),
    );
  }
}

String _$maintenanceRepositoryHash() =>
    r'4436a59913a95e87e8a6da6db57656fd02c819e8';
