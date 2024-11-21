import 'package:athendat/core/error/failure.dart';
import 'package:fpdart/fpdart.dart';

abstract class Usecase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}
