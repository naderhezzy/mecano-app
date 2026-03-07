import 'package:fpdart/fpdart.dart';
import 'package:mecano_app/core/errors/app_exception.dart';

typedef FutureEither<T> = Future<Either<AppException, T>>;
typedef FutureVoid = FutureEither<void>;
typedef JsonMap = Map<String, dynamic>;
