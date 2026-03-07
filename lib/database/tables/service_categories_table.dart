import 'package:drift/drift.dart';

class ServiceCategoriesTable extends Table {
  @override
  String get tableName => 'service_categories';

  TextColumn get id => text()();
  TextColumn get nameEn => text()();
  TextColumn get nameFr => text()();
  TextColumn get iconName => text()();
  TextColumn get serviceType => text()();
  DateTimeColumn get createdAt =>
      dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}
