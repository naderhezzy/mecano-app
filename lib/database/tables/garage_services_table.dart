import 'package:drift/drift.dart';

class GarageServicesTable extends Table {
  @override
  String get tableName => 'garage_services';

  TextColumn get id => text()();
  TextColumn get garageId => text()();
  TextColumn get serviceCategoryId => text()();
  RealColumn get priceMin => real().nullable()();
  RealColumn get priceMax => real().nullable()();
  IntColumn get estimatedDuration => integer().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}
