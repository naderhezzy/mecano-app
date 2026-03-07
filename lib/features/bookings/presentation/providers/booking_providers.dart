import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mecano_app/features/bookings/data/repositories/booking_repository.dart';
import 'package:mecano_app/features/bookings/domain/models/booking.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'booking_providers.g.dart';

@riverpod
Stream<List<Booking>> bookings(Ref ref, String userId) {
  final repo = ref.watch(bookingRepositoryProvider);
  return repo.watchBookings(userId);
}

@riverpod
Future<Booking> bookingDetail(Ref ref, String bookingId) async {
  final repo = ref.watch(bookingRepositoryProvider);
  final result = await repo.getBooking(bookingId);
  return result.fold(
    (error) => throw error,
    (booking) => booking,
  );
}

@riverpod
Future<List<Booking>> upcomingBookings(
  Ref ref,
  String userId,
) async {
  final repo = ref.watch(bookingRepositoryProvider);
  final result = await repo.getUpcomingBookings(userId);
  return result.fold(
    (error) => throw error,
    (bookings) => bookings,
  );
}
