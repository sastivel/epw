import 'package:dartz/dartz.dart';
import '../error/error_failure.dart';
abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call({required Params params});
}
