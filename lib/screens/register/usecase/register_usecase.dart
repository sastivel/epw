
import "package:dartz/dartz.dart";

import '../../../core/error/error_failure.dart';
import '../../../core/model/register_response_model.dart';
import '../../../core/usecase/usecase.dart';
import '../../../repos/authentication/authentication_data_repository.dart';
import '../../../utils/common_imports.dart';

class RegisterUseCase extends UseCase<RegisterResponseModel, RegisterParams> {
  final AuthendicationDataRepository repository;

  RegisterUseCase({required this.repository});

  @override
  Future<Either<Failure, RegisterResponseModel>> call(
      {required RegisterParams params}) {
    return repository.register(params);
  }
}

class RegisterParams extends Equatable {
  final String name;
  final String className;
  final int? disablityType;

  const RegisterParams({
    required this.name,
    required this.className,
    this.disablityType,
  });

  @override
  List<Object?> get props => [name, className, disablityType];
}
