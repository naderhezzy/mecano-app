// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'garage_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(garageRepository)
final garageRepositoryProvider = GarageRepositoryProvider._();

final class GarageRepositoryProvider
    extends
        $FunctionalProvider<
          GarageRepository,
          GarageRepository,
          GarageRepository
        >
    with $Provider<GarageRepository> {
  GarageRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'garageRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$garageRepositoryHash();

  @$internal
  @override
  $ProviderElement<GarageRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  GarageRepository create(Ref ref) {
    return garageRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GarageRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GarageRepository>(value),
    );
  }
}

String _$garageRepositoryHash() => r'31f131c0569aa314c842547c64a11502ac83c523';
