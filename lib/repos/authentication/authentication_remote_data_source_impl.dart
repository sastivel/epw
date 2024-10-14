import 'dart:async';

import 'package:EPW_mobile/core/model/exam/add_answer_response.dart';
import 'package:EPW_mobile/core/model/exam/getQuestionsResponse.dart';
import 'package:EPW_mobile/core/model/exam/get_exam_id_response.dart';
import 'package:EPW_mobile/core/model/exam/get_scorecard_response.dart';
import 'package:EPW_mobile/core/model/exam/match_question_response.dart';
import 'package:EPW_mobile/core/model/login/student_response.dart';
import 'package:EPW_mobile/screens/exam/usecase/get_exam_id_usecase.dart';
import 'package:EPW_mobile/screens/questions/usecase/get_question_response.dart';
import 'package:EPW_mobile/screens/scorecard/usecase/get_scorecard_response.dart';
import 'package:EPW_mobile/screens/questions/usecase/post_answer_usecase.dart';
import 'package:EPW_mobile/screens/profile/usecase/profile_usecase.dart';
import 'package:dartz/dartz.dart';
import '../../api/dio.dart';
import '../../api/interface/login/login_response.dart';
import '../../constants/API_constants.dart';
import '../../core/error/error_failure.dart';
import '../../core/model/exam/base_add_answer_response.dart';
import '../../core/model/register_response_model.dart';
import '../../core/preference/app_preference.dart';

import '../../screens/home/usecase/student_usecase.dart';
import '../../screens/login/usecase/login_usecase.dart';
import '../../screens/questions/usecase/get_match_question_response.dart';
import '../../screens/questions/usecase/post_match_answer_usecase.dart';
import '../../screens/register/usecase/register_usecase.dart';
import 'authentication_remote_data_source.dart';

class AuthendicationRemoteDataSourceImpl
    implements AuthendicationRemoteDataSource {
  final DioHelper dioHelper;
  final AppPreferences appPreferences;
  AuthendicationRemoteDataSourceImpl({
    required this.dioHelper,
    required this.appPreferences,
  });
  @override
  Future<Either<Failure, LoginResponseModel>> loginUser(
      LoginParams loginParams) async {
    try {
      Map<String, dynamic> body = {
        'mobile': loginParams.mobile,
      };

      Response response = await dioHelper.dio.post(
          Uri.parse("${ApiConstants.baseURL}/api/login").toString(),
          data: body);

      final LoginResponseModel loginResponse =
          LoginResponseModel.fromJson(response.data as Map<String, dynamic>);
      print('statusCode  login-> ${loginResponse.toJson()}');
      if (loginResponse.success == 0) {
        return Left(InvalidUserFailure());
      } else {
        return Right(loginResponse);
      }
    } catch (e) {
      return Left(LocalError(message: e.toString()));
    }
  }

  Future<Either<Failure, RegisterResponseModel>> register(
      RegisterParams registerParams) async {
    try {
      LoginResponseModel? responseModel = await appPreferences.getUser();

      Map<String, dynamic> body = {
        'user_id': responseModel?.user?.id,
        'name': registerParams.name,
        'class': registerParams.className,
        'disability_type': registerParams.disablityType
      };

      Response response = await dioHelper.dio.post(
          Uri.parse("${ApiConstants.baseURL}/api/register").toString(),
          data: body);

      final RegisterResponseModel registerResponseModel =
          RegisterResponseModel.fromJson(response.data as Map<String, dynamic>);
      print('statusCode  login-> ${response}');
      if (registerResponseModel?.success == 0) {
        return Left(InvalidUserFailure());
      } else {
        return Right(registerResponseModel);
      }
      // if (loginResponse.statusCode == 200) {
      //   return Right(loginResponse);
      // } else if (loginResponse.statusCode == 400) {
      //   return Left(InvalidUserFailure());
      // } else {
      //   return Left(InvalidUserFailure());
      // }
    } catch (e) {
      return Left(LocalError(message: e.toString()));
    }
  }

  Future<Either<Failure, RegisterResponseModel>> profileEdit(
      ProfileParams profileParams) async {
    try {
      // LoginResponseModel? responseModel = await appPreferences.getUser();

      Map<String, dynamic> body = {
        'id': profileParams.id,
        'name': profileParams.name,
        'class': profileParams.className,
        'disability_type': profileParams.disablityType
      };
      print('******************id*****************');
      print(body.toString());
      Response response = await dioHelper.dio.post(
          Uri.parse("${ApiConstants.baseURL}/api/edit").toString(),
          data: body);

      final RegisterResponseModel registerResponseModel =
          RegisterResponseModel.fromJson(response.data as Map<String, dynamic>);
      print('statusCode  login-> ${registerResponseModel}');
      if (registerResponseModel?.success == 0) {
        return Left(InvalidUserFailure());
      } else {
        return Right(registerResponseModel);
      }
      // if (loginResponse.statusCode == 200) {
      //   return Right(loginResponse);
      // } else if (loginResponse.statusCode == 400) {
      //   return Left(InvalidUserFailure());
      // } else {
      //   return Left(InvalidUserFailure());
      // }
    } catch (e) {
      return Left(LocalError(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, GetExamIdResponse>> getExamId(
      GetExamIdParams getExamIdParams) async {
    try {
      Map<String, dynamic> body = {
        'student_id': getExamIdParams.studentId,
      };

      Response response = await dioHelper.dio.post(
          Uri.parse("${ApiConstants.baseURL}/api/exam/store").toString(),
          data: body);

      final GetExamIdResponse getExamIdResponse =
          GetExamIdResponse.fromJson(response.data as Map<String, dynamic>);
      print('statusCode  login-> ${getExamIdResponse.toJson()}');
      if (getExamIdResponse?.success == 0) {
        return Left(InvalidUserFailure());
      } else {
        return Right(getExamIdResponse);
      }
    } catch (e) {
      return Left(LocalError(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, GetQuestionResponse>> getQuestion(
      GetQuestionParams getQuestionParams) async {
    try {
      Map<String, dynamic> body = {'exam_id': getQuestionParams.examId};

      Response response = await dioHelper.dio.post(
          Uri.parse("${ApiConstants.baseURL}/api/next-question").toString(),
          data: body);

      final GetQuestionResponse getQuestionResponse =
          GetQuestionResponse.fromJson(response.data as Map<String, dynamic>);
      print('statusCode  login-> ${getQuestionResponse.toJson()}');
      if (getQuestionResponse?.success == 0) {
        return Left(InvalidUserFailure());
      } else {
        return Right(getQuestionResponse);
      }
    } catch (e) {
      return Left(LocalError(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, GetScroreCardResponse>> getScoreCard(
      GetScoreCardParams getScoreCardParams) async {
    try {
      Map<String, dynamic> body = {
        'exam_id': getScoreCardParams.examId,
      };

      Response response = await dioHelper.dio.post(
          Uri.parse("${ApiConstants.baseURL}/api/scorecard").toString(),
          data: body);
      print('statusCode  login-> ${response.data as Map<String, dynamic>}');
      final GetScroreCardResponse getScroreCardResponse =
          GetScroreCardResponse.fromJson(response.data as Map<String, dynamic>);

      if (getScroreCardResponse?.success == 0) {
        return Left(InvalidUserFailure());
      } else {
        return Right(getScroreCardResponse);
      }
    } catch (e) {
      return Left(LocalError(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, AddAnswerResponse>> postAnswer(
      PostAnswerParams postAnswerParams) async {
    try {
      Map<String, dynamic> body = {
        'exam_id': postAnswerParams.examId,
        'question_id': postAnswerParams.questionId,
        'answer': postAnswerParams.answer,
        'language': postAnswerParams.language
      };

      Response response = await dioHelper.dio.post(
          Uri.parse("${ApiConstants.baseURL}/api/add/student_response")
              .toString(),
          data: body);

      final AddAnswerResponse addAnswerResponse =
          AddAnswerResponse.fromJson(response.data as Map<String, dynamic>);
      print('statusCode  login-> ${body}');
      print('statusCode  login-> ${response.data}');
      if (addAnswerResponse?.success == 0) {
        return Left(InvalidUserFailure());
      } else {
        return Right(addAnswerResponse);
      }
    } catch (e) {
      return Left(LocalError(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, BaseAddAnswerResponse>> postMatchAnswer(
      PostMatchAnswerParams postAnswerParams) async {
    try {
      Map<String, dynamic> body = {
        'exam_id': postAnswerParams.examId,
        'question_ids': postAnswerParams.questionIds,
        'answers': postAnswerParams.answers,
        'language': postAnswerParams.language
      };
      print('answerrr-> ${postAnswerParams.answers}');
      print('optionsss-> ${postAnswerParams.questionIds}');
      Response response = await dioHelper.dio.post(
          Uri.parse("${ApiConstants.baseURL}/api/match/student_response")
              .toString(),
          data: body);
      print('statusCode  login-> ${response.data as Map<String, dynamic>}');
      final BaseAddAnswerResponse addAnswerResponse =
          BaseAddAnswerResponse.fromJson(response.data as Map<String, dynamic>);

      print('statusCode  login-> ${response.data}');
      if (addAnswerResponse?.success == 0) {
        return Left(InvalidUserFailure());
      } else {
        return Right(addAnswerResponse);
      }
    } catch (e) {
      return Left(LocalError(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, MatchQuestionResponse>> getMatchQuestion(
      MatcQuestionParams getQuestionParams) async {
    try {
      Map<String, dynamic> body = {
        'exam_id': getQuestionParams.examId,
      };

      Response response = await dioHelper.dio.post(
          Uri.parse("${ApiConstants.baseURL}/api/match/next-question")
              .toString(),
          data: body);

      final MatchQuestionResponse getQuestionResponse =
          MatchQuestionResponse.fromJson(response.data as Map<String, dynamic>);
      print('statusCode  login-> ${getQuestionResponse.toJson()}');
      if (getQuestionResponse?.success == 0) {
        return Left(InvalidUserFailure());
      } else {
        return Right(getQuestionResponse);
      }
    } catch (e) {
      return Left(LocalError(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, StudentResponse>> getStudentList(
      StudentListParams studentListParams) async {
    try {
      Response response = await dioHelper.dio.get(
        Uri.parse("${ApiConstants.baseURL}/api/students").toString(),
      );

      final StudentResponse studentResponse =
          StudentResponse.fromJson(response.data as Map<String, dynamic>);
      print('statusCode  login-> ${studentResponse.toJson()}');
      if (studentResponse?.success == 0) {
        return Left(InvalidUserFailure());
      } else {
        return Right(studentResponse);
      }
    } catch (e) {
      return Left(LocalError(message: e.toString()));
    }
  }
}
