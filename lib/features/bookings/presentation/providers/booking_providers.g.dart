// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'booking_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(bookings)
final bookingsProvider = BookingsFamily._();

final class BookingsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Booking>>,
          List<Booking>,
          Stream<List<Booking>>
        >
    with $FutureModifier<List<Booking>>, $StreamProvider<List<Booking>> {
  BookingsProvider._({
    required BookingsFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'bookingsProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$bookingsHash();

  @override
  String toString() {
    return r'bookingsProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $StreamProviderElement<List<Booking>> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<List<Booking>> create(Ref ref) {
    final argument = this.argument as String;
    return bookings(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is BookingsProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$bookingsHash() => r'a190d028472a019d4d988571719bec09debeed2e';

final class BookingsFamily extends $Family
    with $FunctionalFamilyOverride<Stream<List<Booking>>, String> {
  BookingsFamily._()
    : super(
        retry: null,
        name: r'bookingsProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  BookingsProvider call(String userId) =>
      BookingsProvider._(argument: userId, from: this);

  @override
  String toString() => r'bookingsProvider';
}

@ProviderFor(bookingDetail)
final bookingDetailProvider = BookingDetailFamily._();

final class BookingDetailProvider
    extends $FunctionalProvider<AsyncValue<Booking>, Booking, FutureOr<Booking>>
    with $FutureModifier<Booking>, $FutureProvider<Booking> {
  BookingDetailProvider._({
    required BookingDetailFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'bookingDetailProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$bookingDetailHash();

  @override
  String toString() {
    return r'bookingDetailProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<Booking> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<Booking> create(Ref ref) {
    final argument = this.argument as String;
    return bookingDetail(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is BookingDetailProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$bookingDetailHash() => r'e8f3d0d5a99f8741d0853a37ab42b81a0d191ae9';

final class BookingDetailFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<Booking>, String> {
  BookingDetailFamily._()
    : super(
        retry: null,
        name: r'bookingDetailProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  BookingDetailProvider call(String bookingId) =>
      BookingDetailProvider._(argument: bookingId, from: this);

  @override
  String toString() => r'bookingDetailProvider';
}

@ProviderFor(upcomingBookings)
final upcomingBookingsProvider = UpcomingBookingsFamily._();

final class UpcomingBookingsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Booking>>,
          List<Booking>,
          FutureOr<List<Booking>>
        >
    with $FutureModifier<List<Booking>>, $FutureProvider<List<Booking>> {
  UpcomingBookingsProvider._({
    required UpcomingBookingsFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'upcomingBookingsProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$upcomingBookingsHash();

  @override
  String toString() {
    return r'upcomingBookingsProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<Booking>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<Booking>> create(Ref ref) {
    final argument = this.argument as String;
    return upcomingBookings(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is UpcomingBookingsProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$upcomingBookingsHash() => r'19220687ef42b9b202d5d3be2fa43cf2ca8bd8b9';

final class UpcomingBookingsFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<List<Booking>>, String> {
  UpcomingBookingsFamily._()
    : super(
        retry: null,
        name: r'upcomingBookingsProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  UpcomingBookingsProvider call(String userId) =>
      UpcomingBookingsProvider._(argument: userId, from: this);

  @override
  String toString() => r'upcomingBookingsProvider';
}
