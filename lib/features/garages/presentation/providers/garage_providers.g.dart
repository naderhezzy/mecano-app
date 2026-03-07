// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'garage_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(garages)
final garagesProvider = GaragesFamily._();

final class GaragesProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Garage>>,
          List<Garage>,
          FutureOr<List<Garage>>
        >
    with $FutureModifier<List<Garage>>, $FutureProvider<List<Garage>> {
  GaragesProvider._({
    required GaragesFamily super.from,
    required (String?, String?) super.argument,
  }) : super(
         retry: null,
         name: r'garagesProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$garagesHash();

  @override
  String toString() {
    return r'garagesProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  $FutureProviderElement<List<Garage>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<Garage>> create(Ref ref) {
    final argument = this.argument as (String?, String?);
    return garages(ref, argument.$1, argument.$2);
  }

  @override
  bool operator ==(Object other) {
    return other is GaragesProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$garagesHash() => r'a2beb68f7d363f5371274dd142f1e4c227381658';

final class GaragesFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<List<Garage>>, (String?, String?)> {
  GaragesFamily._()
    : super(
        retry: null,
        name: r'garagesProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  GaragesProvider call(String? city, String? search) =>
      GaragesProvider._(argument: (city, search), from: this);

  @override
  String toString() => r'garagesProvider';
}

@ProviderFor(garageDetail)
final garageDetailProvider = GarageDetailFamily._();

final class GarageDetailProvider
    extends $FunctionalProvider<AsyncValue<Garage>, Garage, FutureOr<Garage>>
    with $FutureModifier<Garage>, $FutureProvider<Garage> {
  GarageDetailProvider._({
    required GarageDetailFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'garageDetailProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$garageDetailHash();

  @override
  String toString() {
    return r'garageDetailProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<Garage> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<Garage> create(Ref ref) {
    final argument = this.argument as String;
    return garageDetail(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is GarageDetailProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$garageDetailHash() => r'52d0968d9b59221495770e5f6b126d6a88d438a9';

final class GarageDetailFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<Garage>, String> {
  GarageDetailFamily._()
    : super(
        retry: null,
        name: r'garageDetailProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  GarageDetailProvider call(String garageId) =>
      GarageDetailProvider._(argument: garageId, from: this);

  @override
  String toString() => r'garageDetailProvider';
}

@ProviderFor(garageServices)
final garageServicesProvider = GarageServicesFamily._();

final class GarageServicesProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<GarageService>>,
          List<GarageService>,
          FutureOr<List<GarageService>>
        >
    with
        $FutureModifier<List<GarageService>>,
        $FutureProvider<List<GarageService>> {
  GarageServicesProvider._({
    required GarageServicesFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'garageServicesProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$garageServicesHash();

  @override
  String toString() {
    return r'garageServicesProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<GarageService>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<GarageService>> create(Ref ref) {
    final argument = this.argument as String;
    return garageServices(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is GarageServicesProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$garageServicesHash() => r'35e8b390d3de20c8d6509d2f97e4cbe5206df8dc';

final class GarageServicesFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<List<GarageService>>, String> {
  GarageServicesFamily._()
    : super(
        retry: null,
        name: r'garageServicesProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  GarageServicesProvider call(String garageId) =>
      GarageServicesProvider._(argument: garageId, from: this);

  @override
  String toString() => r'garageServicesProvider';
}

@ProviderFor(garageReviews)
final garageReviewsProvider = GarageReviewsFamily._();

final class GarageReviewsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<GarageReview>>,
          List<GarageReview>,
          FutureOr<List<GarageReview>>
        >
    with
        $FutureModifier<List<GarageReview>>,
        $FutureProvider<List<GarageReview>> {
  GarageReviewsProvider._({
    required GarageReviewsFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'garageReviewsProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$garageReviewsHash();

  @override
  String toString() {
    return r'garageReviewsProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<GarageReview>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<GarageReview>> create(Ref ref) {
    final argument = this.argument as String;
    return garageReviews(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is GarageReviewsProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$garageReviewsHash() => r'ed6ae055b0cee17d919d9a3444614acf32fe6115';

final class GarageReviewsFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<List<GarageReview>>, String> {
  GarageReviewsFamily._()
    : super(
        retry: null,
        name: r'garageReviewsProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  GarageReviewsProvider call(String garageId) =>
      GarageReviewsProvider._(argument: garageId, from: this);

  @override
  String toString() => r'garageReviewsProvider';
}

@ProviderFor(garageCities)
final garageCitiesProvider = GarageCitiesProvider._();

final class GarageCitiesProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<String>>,
          List<String>,
          FutureOr<List<String>>
        >
    with $FutureModifier<List<String>>, $FutureProvider<List<String>> {
  GarageCitiesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'garageCitiesProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$garageCitiesHash();

  @$internal
  @override
  $FutureProviderElement<List<String>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<String>> create(Ref ref) {
    return garageCities(ref);
  }
}

String _$garageCitiesHash() => r'c3070c8acfd42bcc7d6217fe269396055254b70a';
