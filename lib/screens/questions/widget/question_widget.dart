import 'package:EPW_mobile/custome_widgets/custom_text_field.dart';
import 'package:EPW_mobile/screens/questions/bloc/question_bloc.dart';
import 'package:EPW_mobile/screens/questions/bloc/question_state.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../../custome_widgets/custom_style.dart';
import '../../../utils/color_resource.dart';
import '../../../utils/common_imports.dart';
import '../../../utils/string_resource.dart';
import '../bloc/question_event.dart';
import 'package:easy_localization/easy_localization.dart';

class QuestionWidgets {
  static Widget submitBtn(BuildContext context, QuestionsScreenBloc bloc) {
    return InkWell(
      onTap: () {
        bloc.add(QuestionSubmitEvent());
      },
      child: Container(
          alignment: FractionalOffset.center,
          height: 40,
          width: 150,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: ColorResource.COLOR_APP_BTN),
          padding:
              const EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 10),
          child: Text(
            StringResource.SUBMIT.tr(),
            style: CustomStyle.size14w500white(),
          )),
    );
  }

  static Widget nextBtn(BuildContext context, QuestionsScreenBloc bloc) {
    return InkWell(
      onTap: () {
        if (bloc.isLastQuestion == true) {
          bloc.add(GetMatchQuestionEvent());
        } else {
          bloc.add(QuestionsScreenInitialEvent(examId: bloc.examId));
        }
      },
      child: Container(
          alignment: FractionalOffset.center,
          height: 40,
          width: 150,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: ColorResource.COLOR_APP_BTN),
          padding:
              const EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 10),
          child: Text(
            StringResource.NXT.tr(),
            style: CustomStyle.size14w500white(),
          )),
    );
  }

  static Widget type1(BuildContext context, QuestionsScreenBloc bloc,
      QuestionsScreenState state) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height / 5,
          ),
          Container(
            margin: const EdgeInsets.only(left: 20, right: 20),
            child: Text(
              bloc.currentQuestion! ?? '',
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),

          SizedBox(
            height: MediaQuery.of(context).size.height / 8,
          ),

          SizedBox(
            height: MediaQuery.of(context).size.height / 3,
            width: MediaQuery.of(context).size.height / 2,
            child: ListView.builder(
                itemCount: bloc.currentOptions!.length,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    onTap: () {
                      if (bloc.isCurrentQuestionSubmitted == false) {
                        bloc.add(AnswerSelectEvent(
                            answer: bloc.currentOptions![index], index: index));
                      }
                    },
                    child: ListTile(
                        title: InkWell(
                            child: InputDecorator(
                      decoration: InputDecoration(
                        enabled: false,
                        fillColor: bloc.isCurrentQuestionSubmitted == true &&
                                index == bloc.currentQuestionAnswerIndex
                            ? Colors.green
                            : bloc.isCurrentQuestionSubmitted == true &&
                                    bloc.currentQuestionAnswer !=
                                        bloc.selectedAnswer &&
                                    index == bloc.selectedAnswerIndex
                                ? Colors.red
                                : index == bloc.selectedAnswerIndex
                                    ? ColorResource.BLUE03416C
                                    : Colors.white,
                        filled: true,
                        focusColor: ColorResource.COLOR_APP_TEXT_FIELD_BORDER,
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(4.0)),
                          borderSide: BorderSide(
                              color: ColorResource.COLOR_APP_TEXT_FIELD_BORDER),
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red),
                        ),
                        contentPadding: const EdgeInsets.all(5),
                      ),
                      child: Text(
                        bloc.currentOptions![index],
                        style: TextStyle(
                            color: (bloc.isCurrentQuestionSubmitted == true &&
                                        (index ==
                                                bloc
                                                    .currentQuestionAnswerIndex ||
                                            bloc.currentQuestionAnswer !=
                                                    bloc.selectedAnswer &&
                                                index ==
                                                    bloc.selectedAnswerIndex)) ||
                                    index == bloc.selectedAnswerIndex
                                ? Colors.white
                                : Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.normal),
                        textAlign: TextAlign.center,
                      ),
                    ))),
                  );
                }),
          ),
          state is QuestionsScreenBtnLoadingState
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : bloc.isCurrentQuestionSubmitted == true
                  ? nextBtn(context, bloc)
                  : submitBtn(context, bloc),
          SizedBox(
            height: MediaQuery.of(context).size.height / 4,
          ),
          //  Container(
          //   margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.width/3.5),
          //   child:  nextBtn(context,bloc))
        ],
      ),
    );
  }

  static Widget type0(BuildContext context, QuestionsScreenBloc bloc,
      QuestionsScreenState state) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height / 5,
          ),
          Container(
            margin: const EdgeInsets.only(left: 20, right: 20),
            child: Text(
              bloc.currentQuestion! ?? '',
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),

          SizedBox(
            height: MediaQuery.of(context).size.height / 4,
          ),

          Container(
            margin: const EdgeInsets.only(left: 30, right: 30, bottom: 20),
            child: CustomTextField(
                hint: 'answer', textController: bloc.fillInTheBlanksController),
          ),
            if (bloc.isCurrentQuestionSubmitted == true)
            Container(
              margin: const EdgeInsets.only(
                  left: 30, right: 30, top: 30, bottom: 20),
              child: Text(
                bloc.currentQuestionAnswer!,
                style: const TextStyle(
                    color: ColorResource.Color_3ACB2F,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),

          state is QuestionsScreenBtnLoadingState
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : bloc.isCurrentQuestionSubmitted == true
                  ? nextBtn(context, bloc)
                  : submitBtn(context, bloc),
        

          SizedBox(
            height: MediaQuery.of(context).size.height / 6,
          ),
          //  Container(
          //   margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.width/3.5),
          //   child:  nextBtn(context,bloc))
        ],
      ),
    );
  }

  static Widget type4(BuildContext context, QuestionsScreenBloc bloc,
      QuestionsScreenState state) {
    return Stack(
      children: [
        Container(
          margin: const EdgeInsets.only(top: 20),
          child: Column(
            children: [
              Text(StringResource.MATCH_FOLLOWING.tr(),
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center),
                  SizedBox(height: 5,),
              Text('('+StringResource.choose6.tr() + ")",
                  style: const TextStyle(
                      color: Colors.yellow,
                      fontSize: 16,
                      fontWeight: FontWeight.normal),
                  textAlign: TextAlign.center),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width / 2,
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 30,
                          ),
                          Expanded(
                            child: ListView.builder(
                                itemCount: bloc.matchOptions!.length,
                                shrinkWrap: true,
                                physics: const AlwaysScrollableScrollPhysics(),
                                itemBuilder: (BuildContext context, int index) {
                                  return ListTile(
                                    title: SizedBox(
                                        height: 50,
                                        child: Card(
                                            elevation: 10,
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: ColorResource
                                                          .COLOR_APP_TEXT_FIELD_BORDER)),
                                              child: Center(
                                                  child: Text(
                                                bloc.matchQuestion[index]
                                                    .toString(),
                                                textAlign: TextAlign.center,
                                              )),
                                            ))),
                                  );
                                }),
                          ),
                        ],
                      ),
                    ),
                    if (bloc.isMatchQuestionSubmitted == false)
                      SizedBox(
                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width / 2,
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 30,
                            ),
                            Expanded(
                              child: ReorderableListView(
                                //padding: const EdgeInsets.symmetric(horizontal: 40),
                                onReorder: (int oldIndex, int newIndex) {
                                  bloc.add(MatchOptionRearranegEvent(
                                      newIndex: newIndex, oldIndex: oldIndex));
                                },
                                children: [
                                  for (int index = 0;
                                      index < bloc.matchQuestion!.length;
                                      index += 1)
                                    ListTile(
                                      key: Key('$index'),
                                      title: SizedBox(
                                          height: 50,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              2,
                                          child: Card(
                                            elevation: 10,
                                            color: Colors.yellow,
                                            child: Container(
                                              // decoration: BoxDecoration(
                                              //     border: Border.all(
                                              //         color: ColorResource
                                              //             .COLOR_APP_TEXT_FIELD_BORDER)),
                                              child: Center(
                                                  child: Text(
                                                bloc.matchOptions[index]
                                                    .toString(),
                                                style: const TextStyle(
                                                    color: Colors.black),
                                                textAlign: TextAlign.center,
                                              )),
                                            ),
                                          )),
                                    )
                                ],
                              ),
                            ),
                          ],
                        ),
                      )
                    else
                      SizedBox(
                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width / 2,
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 30,
                            ),
                            Expanded(
                              child: ListView.builder(
                                  itemCount: bloc.matchAnswer.length,
                                  shrinkWrap: true,
                                  physics:
                                      const AlwaysScrollableScrollPhysics(),
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return ListTile(
                                      title: SizedBox(
                                          height: 50,
                                          child: Card(
                                              elevation: 10,
                                              color: bloc.isCorrectAnswer(index)
                                                  ? Colors.green
                                                  : Colors.red,
                                              child: Center(
                                                  child: Text(
                                                bloc.matchAnswer[index]
                                                    .toString(),
                                                style: const TextStyle(
                                                    color: Colors.white),
                                                textAlign: TextAlign.center,
                                              )))),
                                    );
                                  }),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Positioned(
            bottom: 0,
            child: SizedBox(
              height: 100,
              width: MediaQuery.of(context).size.width,
              child: Center(
                child: bloc.isMatchQuestionSubmitted == true
                    ? moveToScoreCard(context, bloc)
                    : matchSubmitBtn(context, bloc),
              ),
            ))
      ],
    );
  }

  static Widget matchSubmitBtn(BuildContext context, QuestionsScreenBloc bloc) {
    return InkWell(
      onTap: () {
        bloc.add(MatchSubmitEvent());
      },
      child: Container(
          alignment: FractionalOffset.center,
          height: 40,
          width: 150,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: ColorResource.COLOR_APP_BTN),
          padding:
              const EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 10),
          child: Text(
            StringResource.SUBMIT.tr(),
            style: CustomStyle.size14w500white(),
          )),
    );
  }

  static Widget moveToScoreCard(
      BuildContext context, QuestionsScreenBloc bloc) {
    return InkWell(
      onTap: () {
        bloc.add(MoveToScoreCardEvent());
      },
      child: Container(
          alignment: FractionalOffset.center,
          height: 40,
          width: 150,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: ColorResource.COLOR_APP_BTN),
          padding:
              const EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 10),
          child: Text(
            "ScoreCard",
            style: CustomStyle.size14w500white(),
          )),
    );
  }
}
