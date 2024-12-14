import "package:dartz/dartz.dart";

import '../../../core/error/error_failure.dart';
import '../../../core/model/register_response_model.dart';
import '../../../core/usecase/usecase.dart';
import '../../../repos/authentication/authentication_data_repository.dart';
import '../../../utils/common_imports.dart';

class ProfileUseCase extends UseCase<RegisterResponseModel, ProfileParams> {
  final AuthendicationDataRepository repository;

  ProfileUseCase({required this.repository});

  @override
  Future<Either<Failure, RegisterResponseModel>> call(
      {required ProfileParams params}) {
    return repository.profileEdit(params);
  }
}

class ProfileParams extends Equatable {
  final int? id;
  final String name;
  final String className;
  final int? disablityType;

  const ProfileParams(
      {required this.id,
      required this.name,
      required this.className,
      this.disablityType});

  @override
  List<Object?> get props => [name, className, disablityType];
}
