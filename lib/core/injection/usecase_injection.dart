import 'package:EPW_mobile/screens/exam/usecase/get_exam_id_usecase.dart';
import 'package:EPW_mobile/screens/home/usecase/student_usecase.dart';
import 'package:EPW_mobile/screens/profile/usecase/profile_usecase.dart';
import 'package:EPW_mobile/screens/questions/bloc/question_event.dart';
import 'package:EPW_mobile/screens/questions/usecase/get_match_question_response.dart';
import 'package:EPW_mobile/screens/questions/usecase/get_question_response.dart';
import 'package:EPW_mobile/screens/questions/usecase/post_answer_usecase.dart';
import 'package:EPW_mobile/screens/questions/usecase/post_match_answer_usecase.dart';
import 'package:EPW_mobile/screens/scorecard/usecase/get_scorecard_response.dart';

import '../../screens/login/usecase/login_usecase.dart';
import '../../screens/register/usecase/register_usecase.dart';
import 'injection.dart';

Future<void> injectUseCases() async {
  dl.registerLazySingleton(() => LoginUseCase(repository: dl()));
  dl.registerLazySingleton(() => RegisterUseCase(repository: dl()));
  dl.registerLazySingleton(() => ProfileUseCase(repository: dl()));
  dl.registerLazySingleton(() => GetExamIdUseCase(repository: dl()));
  dl.registerLazySingleton(() => GetScoreCardUseCase(repository: dl()));
  dl.registerLazySingleton(() => GetQuestionUseCase(repository: dl()));
  dl.registerLazySingleton(() => PostAnswerUseCase(repository: dl()));
  dl.registerLazySingleton(() => PostMatchAnswerUseCase(repository: dl()));
  dl.registerLazySingleton(() => GetMatchQuestionUseCase(repository: dl()));
  dl.registerLazySingleton(() => StudentUseCase(repository: dl()));
}
