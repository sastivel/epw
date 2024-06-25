import 'package:EPW_mobile/core/model/register_response_model.dart';
import 'package:EPW_mobile/screens/home/usecase/student_usecase.dart';
import 'package:EPW_mobile/screens/register/usecase/register_usecase.dart';
import 'package:dartz/dartz.dart';

import '../../api/interface/login/login_response.dart';
import '../../core/error/error_failure.dart';
import '../../core/model/exam/add_answer_response.dart';
import '../../core/model/exam/base_add_answer_response.dart';
import '../../core/model/exam/getQuestionsResponse.dart';
import '../../core/model/exam/get_exam_id_response.dart';
import '../../core/model/exam/get_scorecard_response.dart';
import '../../core/model/exam/match_question_response.dart';
import '../../core/model/login/student_response.dart';
import '../../screens/exam/usecase/get_exam_id_usecase.dart';
import '../../screens/questions/usecase/get_match_question_response.dart';
import '../../screens/questions/usecase/get_question_response.dart';
import '../../screens/questions/usecase/post_match_answer_usecase.dart';
import '../../screens/scorecard/usecase/get_scorecard_response.dart';
import '../../screens/questions/usecase/post_answer_usecase.dart';
import '../../screens/login/usecase/login_usecase.dart';

abstract class AuthendicationRemoteDataSource<T> {
  Future<Either<Failure, LoginResponseModel>> loginUser(
      LoginParams loginParams);
  Future<Either<Failure, RegisterResponseModel>> register(
      RegisterParams registerParams);

  Future<Either<Failure, GetExamIdResponse>> getExamId(
      GetExamIdParams getExamIdParams);
  Future<Either<Failure, GetQuestionResponse>> getQuestion(
      GetQuestionParams getQuestionParams);
  Future<Either<Failure, AddAnswerResponse>> postAnswer(
      PostAnswerParams postAnswerParams);
  Future<Either<Failure, GetScroreCardResponse>> getScoreCard(
      GetScoreCardParams getScoreCardParams);
  Future<Either<Failure, MatchQuestionResponse>> getMatchQuestion(
      MatcQuestionParams getQuestionParams);
  Future<Either<Failure, BaseAddAnswerResponse>> postMatchAnswer(
      PostMatchAnswerParams postAnswerParams);
  Future<Either<Failure, StudentResponse>> getStudentList(
      StudentListParams studentListParams);
}
