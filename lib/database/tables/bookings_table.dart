import 'package:drift/drift.dart';

class BookingsTable extends Table {
  @override
  String get tableName => 'bookings';

  TextColumn get id => text()();
  TextColumn get userId => text()();
  TextColumn get garageId => text()();
  TextColumn get vehicleId => text()();
  TextColumn get serviceCategoryId => text().nullable()();
  TextColumn get status => text().withDefault(const Constant('pending'))();
  DateTimeColumn get appointmentDate => dateTime()();
  TextColumn get appointmentTime => text()();
  TextColumn get notes => text().nullable()();
  RealColumn get estimatedCost => real().nullable()();
  DateTimeColumn get createdAt =>
      dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt =>
      dateTime().withDefault(currentDateAndTime)();
  BoolColumn get isSynced => boolean().withDefault(const Constant(true))();

  @override
  Set<Column> get primaryKey => {id};
}
