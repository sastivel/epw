import 'package:EPW_mobile/screens/exam/bloc/exam_bloc.dart';
import 'package:EPW_mobile/screens/exam/widgets/exam_screen_widgets.dart';
import 'package:EPW_mobile/screens/home/bloc/home_bloc.dart';
import 'package:EPW_mobile/screens/questions/bloc/question_bloc.dart';
import 'package:EPW_mobile/screens/questions/view/question_screen.dart';
import 'package:EPW_mobile/screens/scorecard/view/scorecard_screen.dart';
import 'package:EPW_mobile/utils/string_resource.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../../utils/common_imports.dart';
import '../../../utils/image_resource.dart';
import '../../base/state/base_hook_consumer_widget.dart';
import '../../questions/bloc/question_event.dart';
import '../../scorecard/bloc/Scorecard_event.dart';
import '../../scorecard/bloc/scorecard_bloc.dart';
import '../bloc/exam_state.dart';

class ExamScreen extends BaseHookWidget {
  ExamScreenBloc? examScreenBloc;
  QuestionsScreenBloc? questionsScreenBloc;
  ExamScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    examScreenBloc = useBloc<ExamScreenBloc>(closeOnDispose: false);
    questionsScreenBloc = useBloc<QuestionsScreenBloc>(closeOnDispose: false);

    useBlocListener(examScreenBloc!, (examScreenBloc, value, context) {
      if (value is ExamScreenErrorState) {
        showToast(context: context, message: (value).error.toString());
      }
      if (value is ExamScreenSuccessState) {
        Future.delayed(const Duration(milliseconds: 200));
        questionsScreenBloc?.add(QuestionsScreenInitialEvent(
            examId: value.examId, locale: context.locale));
        pushNamed(context, QuestionScreen());
      }
    });

    final state = useBlocBuilder(
      examScreenBloc!,
    );
    final appLifecycleState = useAppLifecycleState();

    return SafeArea(
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            body: state is ExamScreenLoadingState
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : examScreenBloc!.diaAbilityType != null &&
                        examScreenBloc!.diaAbilityType ==
                            'Mild Intellectual Disability'
                    ? Container(
                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: ExactAssetImage(ImageResource.APPBG4),
                            fit: BoxFit.fill,
                            alignment: Alignment.topCenter,
                          ),
                        ),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 90,
                            ),
                            Text(
                              StringResource.choose7.tr(),
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              StringResource.choose8.tr(),
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              StringResource.choose9.tr(),
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Spacer(),
                            Container(
                                margin: EdgeInsets.only(
                                    bottom: MediaQuery.of(context).size.width /
                                        3.5),
                                child: state is ExamScreenLoadingState
                                    ? const Center(
                                        child: CircularProgressIndicator(),
                                      )
                                    : ExamWidgets.StartExamBtn(
                                        context, examScreenBloc!))
                          ],
                        ))
                    : Container(
                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: ExactAssetImage(ImageResource.APPBG4),
                            fit: BoxFit.fill,
                            alignment: Alignment.topCenter,
                          ),
                        ),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 90,
                            ),
                            Text(
                              StringResource.choose1.tr(),
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              StringResource.choose2.tr(),
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              StringResource.choose3.tr(),
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              StringResource.choose4.tr(),
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              StringResource.choose5.tr(),
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            ),
                            Spacer(),
                            Container(
                                margin: EdgeInsets.only(
                                    bottom: MediaQuery.of(context).size.width /
                                        3.5),
                                child: state is ExamScreenLoadingState
                                    ? const Center(
                                        child: CircularProgressIndicator(),
                                      )
                                    : ExamWidgets.StartExamBtn(
                                        context, examScreenBloc!))
                          ],
                        ))));
  }
}
