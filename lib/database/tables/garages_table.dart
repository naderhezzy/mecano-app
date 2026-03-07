import 'package:drift/drift.dart';

class GaragesTable extends Table {
  @override
  String get tableName => 'garages';

  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get address => text()();
  TextColumn get city => text()();
  RealColumn get lat => real().nullable()();
  RealColumn get lng => real().nullable()();
  TextColumn get phone => text().nullable()();
  TextColumn get photoUrls => text().withDefault(const Constant('[]'))();
  RealColumn get averageRating =>
      real().withDefault(const Constant(0.0))();
  IntColumn get totalReviews =>
      integer().withDefault(const Constant(0))();
  BoolColumn get isVerified =>
      boolean().withDefault(const Constant(false))();
  TextColumn get workingHours => text().withDefault(const Constant('{}'))();
  DateTimeColumn get createdAt =>
      dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt =>
      dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}
