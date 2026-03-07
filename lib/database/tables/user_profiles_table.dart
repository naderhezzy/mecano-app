import 'package:drift/drift.dart';

class UserProfilesTable extends Table {
  @override
  String get tableName => 'user_profiles';

  TextColumn get id => text()();
  TextColumn get fullName => text().nullable()();
  TextColumn get phone => text().nullable()();
  TextColumn get location => text().nullable()();
  TextColumn get preferredLanguage => text().withDefault(const Constant('en'))();
  TextColumn get avatarUrl => text().nullable()();
  DateTimeColumn get createdAt =>
      dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt =>
      dateTime().withDefault(currentDateAndTime)();
  BoolColumn get isSynced => boolean().withDefault(const Constant(true))();

  @override
  Set<Column> get primaryKey => {id};
}
