import 'package:dartz/dartz.dart';

import '../errors/errors.dart';

// * Generic FutureEither
typedef FutureEither<T> = Future<Either<Failure, T>>;

typedef FutureEitherVoid = FutureEither<void>;
typedef FutureVoid = Future<void>;
typedef StreamList<T> = Stream<List<T>>;
