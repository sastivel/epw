import 'package:EPW_mobile/core/model/exam/get_scorecard_response.dart';

import "package:dartz/dartz.dart";

import '../../../core/error/error_failure.dart';
import '../../../core/usecase/usecase.dart';
import '../../../repos/authentication/authentication_data_repository.dart';
import '../../../utils/common_imports.dart';

class GetScoreCardUseCase extends UseCase<GetScroreCardResponse, GetScoreCardParams> {
  final AuthendicationDataRepository repository;

  GetScoreCardUseCase({required this.repository});

  @override
  Future<Either<Failure, GetScroreCardResponse>> call({required GetScoreCardParams params}) {
    return repository.getScoreCard(params);
  }
}

class GetScoreCardParams extends Equatable {
  final int? examId;

  const GetScoreCardParams({
    required this.examId,
  });

  @override
  List<Object?> get props => [examId];
}
