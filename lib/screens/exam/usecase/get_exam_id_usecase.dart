import 'package:EPW_mobile/core/model/exam/get_exam_id_response.dart';

import "package:dartz/dartz.dart";

import '../../../core/error/error_failure.dart';
import '../../../core/usecase/usecase.dart';
import '../../../repos/authentication/authentication_data_repository.dart';
import '../../../utils/common_imports.dart';

class GetExamIdUseCase extends UseCase<GetExamIdResponse, GetExamIdParams> {
  final AuthendicationDataRepository repository;

  GetExamIdUseCase({required this.repository});

  @override
  Future<Either<Failure, GetExamIdResponse>> call({required GetExamIdParams params}) {
    return repository.getExamId(params);
  }
}

class GetExamIdParams extends Equatable {
  final int? studentId;

  const GetExamIdParams({
    required this.studentId,
  });

  @override
  List<Object?> get props => [studentId];
}
