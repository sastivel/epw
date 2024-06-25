import 'package:EPW_mobile/core/model/exam/getQuestionsResponse.dart';

import "package:dartz/dartz.dart";

import '../../../core/error/error_failure.dart';
import '../../../core/usecase/usecase.dart';
import '../../../repos/authentication/authentication_data_repository.dart';
import '../../../utils/common_imports.dart';

class GetQuestionUseCase extends UseCase<GetQuestionResponse, GetQuestionParams> {
  final AuthendicationDataRepository repository;

  GetQuestionUseCase({required this.repository});

  @override
  Future<Either<Failure, GetQuestionResponse>> call({required GetQuestionParams params}) {
    return repository.getQuestion(params);
  }
}

class GetQuestionParams extends Equatable {
  final int examId;

  const GetQuestionParams({
    required this.examId,
  });

  @override
  List<Object?> get props => [examId];
}
