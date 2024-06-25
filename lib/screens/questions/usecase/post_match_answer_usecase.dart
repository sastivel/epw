import 'package:EPW_mobile/core/model/exam/add_answer_response.dart';

import "package:dartz/dartz.dart";

import '../../../core/error/error_failure.dart';
import '../../../core/model/exam/base_add_answer_response.dart';
import '../../../core/usecase/usecase.dart';
import '../../../repos/authentication/authentication_data_repository.dart';
import '../../../utils/common_imports.dart';

class PostMatchAnswerUseCase extends UseCase<BaseAddAnswerResponse, PostMatchAnswerParams> {
  final AuthendicationDataRepository repository;

  PostMatchAnswerUseCase({required this.repository});

  @override
  Future<Either<Failure, BaseAddAnswerResponse>> call({required PostMatchAnswerParams params}) {
    return repository.postMatchAnswer(params);
  }
}

class PostMatchAnswerParams extends Equatable {
  final int examId;
    final String questionIds;
      final String answers;
        final String language;

  const PostMatchAnswerParams({
    required this.questionIds,
     required this.examId,
      required this.answers,
       required this.language,
  });

  @override
  List<Object?> get props => [examId,questionIds,answers,language];
}
