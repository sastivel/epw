import 'package:EPW_mobile/core/model/exam/add_answer_response.dart';
import 'package:EPW_mobile/core/model/exam/getQuestionsResponse.dart';
import 'package:EPW_mobile/core/model/exam/get_scorecard_response.dart';
import 'package:EPW_mobile/screens/exam/usecase/get_exam_id_usecase.dart';
import 'package:EPW_mobile/screens/questions/usecase/get_question_response.dart';
import 'package:EPW_mobile/screens/scorecard/usecase/get_scorecard_response.dart';
import 'package:EPW_mobile/screens/questions/usecase/post_answer_usecase.dart';
import 'package:dartz/dartz.dart';
import '../../api/interface/login/login_response.dart';
import '../../core/error/error_failure.dart';
import '../../core/model/exam/base_add_answer_response.dart';
import '../../core/model/exam/get_exam_id_response.dart';
import '../../core/model/exam/match_question_response.dart';
import '../../core/model/login/student_response.dart';
import '../../core/model/register_response_model.dart';
import '../../screens/home/usecase/student_usecase.dart';
import '../../screens/login/usecase/login_usecase.dart';
import '../../screens/profile/usecase/profile_usecase.dart';
import '../../screens/questions/usecase/get_match_question_response.dart';
import '../../screens/questions/usecase/post_match_answer_usecase.dart';
import '../../screens/register/usecase/register_usecase.dart';
import 'authentication_remote_data_source.dart';
import 'authentication_remote_data_source_impl.dart';

class AuthendicationDataRepository implements AuthendicationRemoteDataSource {
  final AuthendicationRemoteDataSourceImpl remoteDataSource;

  AuthendicationDataRepository({required this.remoteDataSource});

  @override
  Future<Either<Failure, LoginResponseModel>> loginUser(LoginParams loginParams) {
    return remoteDataSource.loginUser(loginParams);
  }

    Future<Either<Failure, RegisterResponseModel>> register(RegisterParams registerParams) {
    return remoteDataSource.register(registerParams);
  }

   Future<Either<Failure, RegisterResponseModel>> profileEdit(ProfileParams profileParams) {
    return remoteDataSource.profileEdit(profileParams);
  }

     Future<Either<Failure, GetExamIdResponse>> getExamId(GetExamIdParams getExamIdParams) {
    return remoteDataSource.getExamId(getExamIdParams);
  }
       Future<Either<Failure, GetQuestionResponse>> getQuestion(GetQuestionParams getQuestionParams) {
    return remoteDataSource.getQuestion(getQuestionParams);
  }

      Future<Either<Failure, MatchQuestionResponse>> getMatchQuestion(MatcQuestionParams getQuestionParams) {
    return remoteDataSource.getMatchQuestion(getQuestionParams);
  }


     Future<Either<Failure, AddAnswerResponse>> postAnswer(PostAnswerParams postAnswerParams) {
    return remoteDataSource.postAnswer(postAnswerParams);
  }

     Future<Either<Failure, BaseAddAnswerResponse>> postMatchAnswer(PostMatchAnswerParams postAnswerParams) {
    return remoteDataSource.postMatchAnswer(postAnswerParams);
  }


     Future<Either<Failure, GetScroreCardResponse>> getScoreCard(GetScoreCardParams getScoreCardParams) {
    return remoteDataSource.getScoreCard(getScoreCardParams);
  }

  Future<Either<Failure, StudentResponse>> getStudentList(StudentListParams studentListParams) {
    return remoteDataSource.getStudentList(studentListParams);
  }

}
