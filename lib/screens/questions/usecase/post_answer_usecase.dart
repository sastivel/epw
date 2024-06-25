import 'package:EPW_mobile/core/model/exam/add_answer_response.dart';

import "package:dartz/dartz.dart";

import '../../../core/error/error_failure.dart';
import '../../../core/usecase/usecase.dart';
import '../../../repos/authentication/authentication_data_repository.dart';
import '../../../utils/common_imports.dart';

class PostAnswerUseCase extends UseCase<AddAnswerResponse, PostAnswerParams> {
  final AuthendicationDataRepository repository;

  PostAnswerUseCase({required this.repository});

  @override
  Future<Either<Failure, AddAnswerResponse>> call({required PostAnswerParams params}) {
    return repository.postAnswer(params);
  }
}

class PostAnswerParams extends Equatable {
  final int examId;
    final int questionId;
      final String answer;
        final String language;

  const PostAnswerParams({
    required this.questionId,
     required this.examId,
      required this.answer,
       required this.language,
  });

  @override
  List<Object?> get props => [examId,questionId,answer,language];
}
