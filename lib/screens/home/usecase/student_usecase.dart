import 'package:EPW_mobile/core/model/login/student_response.dart';

import '../../../api/interface/login/login_response.dart';
import "package:dartz/dartz.dart";

import '../../../core/error/error_failure.dart';
import '../../../core/usecase/usecase.dart';
import '../../../repos/authentication/authentication_data_repository.dart';
import '../../../utils/common_imports.dart';

class StudentUseCase extends UseCase<StudentResponse, StudentListParams> {
  final AuthendicationDataRepository repository;

  StudentUseCase({required this.repository});

  @override
  Future<Either<Failure, StudentResponse>> call(
      {required StudentListParams params}) {
    return repository.getStudentList(params);
  }
}

class StudentListParams extends Equatable {
  StudentListParams();

  @override
  List<Object?> get props => [];
}
