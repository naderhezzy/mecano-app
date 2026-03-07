import 'package:drift/drift.dart';

class VehiclesTable extends Table {
  @override
  String get tableName => 'vehicles';

  TextColumn get id => text()();
  TextColumn get userId => text()();
  TextColumn get make => text()();
  TextColumn get model => text()();
  IntColumn get year => integer()();
  IntColumn get mileage => integer()();
  TextColumn get vin => text().nullable()();
  TextColumn get fuelType => text()();
  TextColumn get plateNumber => text().nullable()();
  TextColumn get color => text().nullable()();
  TextColumn get photoUrls => text().withDefault(const Constant('[]'))();
  TextColumn get notes => text().nullable()();
  BoolColumn get isPrimary => boolean().withDefault(const Constant(false))();
  DateTimeColumn get createdAt =>
      dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt =>
      dateTime().withDefault(currentDateAndTime)();
  BoolColumn get isSynced => boolean().withDefault(const Constant(true))();

  @override
  Set<Column> get primaryKey => {id};
}
