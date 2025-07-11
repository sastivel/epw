import 'package:EPW_mobile/screens/home/screens/home_screen.dart';
import 'package:EPW_mobile/screens/questions/bloc/question_bloc.dart';
import 'package:EPW_mobile/screens/questions/widget/question_widget.dart';
import 'package:EPW_mobile/screens/scorecard/bloc/scorecard_bloc.dart';
import 'package:EPW_mobile/screens/scorecard/view/scorecard_screen.dart';
import 'package:EPW_mobile/utils/string_resource.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../../utils/common_imports.dart';
import '../../../utils/image_resource.dart';
import '../../base/state/base_hook_consumer_widget.dart';
import '../../scorecard/bloc/Scorecard_event.dart';
import '../bloc/question_state.dart';

class QuestionScreen extends BaseHookWidget {
  QuestionsScreenBloc? questionsScreenBloc;
  ScorecardScreenBloc? scorecardScreenBloc;
  QuestionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    questionsScreenBloc = useBloc<QuestionsScreenBloc>(closeOnDispose: false);
scorecardScreenBloc = useBloc<ScorecardScreenBloc>(closeOnDispose: false);
    useBlocListener(questionsScreenBloc!,
        (questionsScreenBloc, value, context) {
      if (value is QuestionsScreenErrorState) {
        showToast(context: context, message: (value).error.toString());
      }
      if (value is QuestionsScreenSuccessState) {}
      if(value is MoveToScoreCardState){
        scorecardScreenBloc?.add(ScorecardScreenInitialEvent(examId:questionsScreenBloc.examId!));
        pushReplacement(context, ScoreCardScreen());
      }
    });

    final state = useBlocBuilder(
      questionsScreenBloc!,
    );

    Widget cancelButton = TextButton(
      child: Text(StringResource.CANCEL.tr()),
      onPressed: () {
        pushReplacement(context, HomeScreen());
      },
    );
    Widget continueButton = TextButton(
      child: Text(StringResource.CONTINUE.tr()),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    Widget homeButton = TextButton(
      child: Text(StringResource.HOME.tr()),
      onPressed: () {
         pushReplacement(context, HomeScreen());
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(StringResource.WARNING.tr()),
      content: Text(StringResource.EXAMALERTWARNING.tr()),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    AlertDialog alert1 = AlertDialog(
      title: Text(StringResource.WARNING.tr()),
      content: Text(StringResource.EXAMALERTEXIT.tr()),
      actions: [
        homeButton,
      ],
    );

    Future<bool> _onBackPressed() async {
      return await showDialog(context: context, builder: (context) => alert);
    }

    Future<bool> onCancelExam() async {
      return await showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) => alert1);
    }

    final appLifecycleState = useAppLifecycleState();

    useEffect(() {
      if (appLifecycleState == AppLifecycleState.paused) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          onCancelExam();
        });
      }
      return null;
    }, [appLifecycleState]);

    return WillPopScope(
      onWillPop: _onBackPressed,
      child: SafeArea(
          child: Scaffold(
              resizeToAvoidBottomInset: true,
              body: Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: ExactAssetImage(ImageResource.APPBG4),
                      fit: BoxFit.fill,
                      alignment: Alignment.topCenter,
                    ),
                  ),
                  child: state is QuestionsScreenLoadingState
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : questionsScreenBloc!.currentQuestionType == 0 ||
                              questionsScreenBloc!.currentQuestionType == 2
                          ? QuestionWidgets.type0(
                              context, questionsScreenBloc!, state)
                          : questionsScreenBloc!.currentQuestionType == 1 ||
                                  questionsScreenBloc!.currentQuestionType == 3
                              ? QuestionWidgets.type1(
                                  context, questionsScreenBloc!, state)
                              : questionsScreenBloc!.currentQuestionType == 4  ?
                               QuestionWidgets.type4(context, questionsScreenBloc!, state)
                              :Container(
                                  child: Text(questionsScreenBloc!
                                      .currentQuestionType!
                                      .toString()),
                                )))),
    );
  }
}
