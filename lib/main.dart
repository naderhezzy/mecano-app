import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mecano_app/app.dart';
import 'package:mecano_app/bootstrap.dart';

void main() {
  bootstrap(
    () => const ProviderScope(child: MecanoApp()),
  );
}
