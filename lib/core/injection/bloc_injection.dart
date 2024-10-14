

import 'package:EPW_mobile/screens/exam/bloc/exam_bloc.dart';
import 'package:EPW_mobile/screens/home/bloc/home_bloc.dart';
import 'package:EPW_mobile/screens/profile/bloc/profile_bloc.dart';

import '../../screens/login/bloc/login_bloc.dart';
import '../../screens/questions/bloc/question_bloc.dart';
import '../../screens/register/bloc/register_bloc.dart';
import '../../screens/scorecard/bloc/scorecard_bloc.dart';
import 'injection.dart';

Future<void> injectBloc() async {
  dl.registerLazySingleton(
      () => LoginScreenBloc(loginUseCase: dl(), appPreferences: dl()));
       dl.registerLazySingleton(
      () => RegisterScreenBloc(registerUseCase: dl(), appPreferences: dl()));
         dl.registerLazySingleton(
      () => ProfileScreenBloc(profileUseCase: dl(), appPreferences: dl()));
      dl.registerLazySingleton(
      () => HomeScreenBloc(loginUseCase: dl(), appPreferences: dl(),studentUseCase: dl()));
       dl.registerLazySingleton(
      () => ExamScreenBloc(examIdUseCase: dl(), appPreferences: dl()));
        dl.registerLazySingleton(
      () => ScorecardScreenBloc(getScoreCardUseCase: dl(), appPreferences: dl()));
         dl.registerLazySingleton(
      () => QuestionsScreenBloc(getQuestionUseCase: dl(), postAnswerUseCase:dl(),getMatchQuestionUseCase: dl(),postMatchAnswerUseCase: dl(),  appPreferences: dl()));
}
