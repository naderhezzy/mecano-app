import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:mecano_app/database/tables/bookings_table.dart';
import 'package:mecano_app/database/tables/garage_services_table.dart';
import 'package:mecano_app/database/tables/garages_table.dart';
import 'package:mecano_app/database/tables/maintenance_records_table.dart';
import 'package:mecano_app/database/tables/service_categories_table.dart';
import 'package:mecano_app/database/tables/user_profiles_table.dart';
import 'package:mecano_app/database/tables/vehicles_table.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

part 'app_database.g.dart';

@DriftDatabase(
  tables: [
    UserProfilesTable,
    VehiclesTable,
    MaintenanceRecordsTable,
    GaragesTable,
    GarageServicesTable,
    ServiceCategoriesTable,
    BookingsTable,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  AppDatabase.forTesting(super.e);

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (Migrator m) async {
        await m.createAll();
      },
    );
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'mecano.db'));
    return NativeDatabase.createInBackground(file);
  });
}
