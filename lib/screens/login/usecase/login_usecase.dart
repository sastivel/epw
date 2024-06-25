import '../../../api/interface/login/login_response.dart';
import "package:dartz/dartz.dart";

import '../../../core/error/error_failure.dart';
import '../../../core/usecase/usecase.dart';
import '../../../repos/authentication/authentication_data_repository.dart';
import '../../../utils/common_imports.dart';

class LoginUseCase extends UseCase<LoginResponseModel, LoginParams> {
  final AuthendicationDataRepository repository;

  LoginUseCase({required this.repository});

  @override
  Future<Either<Failure, LoginResponseModel>> call({required LoginParams params}) {
    return repository.loginUser(params);
  }
}

class LoginParams extends Equatable {
  final String mobile;

  const LoginParams({
    required this.mobile,
  });

  @override
  List<Object?> get props => [mobile];
}
