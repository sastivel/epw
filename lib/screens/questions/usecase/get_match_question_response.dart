import 'package:EPW_mobile/core/model/exam/getQuestionsResponse.dart';
import 'package:EPW_mobile/core/model/exam/match_question_response.dart';

import "package:dartz/dartz.dart";

import '../../../core/error/error_failure.dart';
import '../../../core/usecase/usecase.dart';
import '../../../repos/authentication/authentication_data_repository.dart';
import '../../../utils/common_imports.dart';

class GetMatchQuestionUseCase extends UseCase<MatchQuestionResponse, MatcQuestionParams> {
  final AuthendicationDataRepository repository;

  GetMatchQuestionUseCase({required this.repository});

  @override
  Future<Either<Failure, MatchQuestionResponse>> call({required MatcQuestionParams params}) {
    return repository.getMatchQuestion(params);
  }
}

class MatcQuestionParams extends Equatable {
  final int examId;

  const MatcQuestionParams({
    required this.examId,
  });

  @override
  List<Object?> get props => [examId];
}
