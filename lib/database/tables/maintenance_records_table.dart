import 'package:drift/drift.dart';

class MaintenanceRecordsTable extends Table {
  @override
  String get tableName => 'maintenance_records';

  TextColumn get id => text()();
  TextColumn get vehicleId => text()();
  TextColumn get serviceType => text()();
  TextColumn get title => text()();
  IntColumn get mileageAtService => integer().nullable()();
  RealColumn get cost => real().nullable()();
  DateTimeColumn get serviceDate => dateTime()();
  TextColumn get garageId => text().nullable()();
  DateTimeColumn get nextServiceDate => dateTime().nullable()();
  IntColumn get nextServiceMileage => integer().nullable()();
  TextColumn get notes => text().nullable()();
  TextColumn get photoUrls => text().withDefault(const Constant('[]'))();
  DateTimeColumn get createdAt =>
      dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt =>
      dateTime().withDefault(currentDateAndTime)();
  BoolColumn get isSynced => boolean().withDefault(const Constant(true))();

  @override
  Set<Column> get primaryKey => {id};
}
