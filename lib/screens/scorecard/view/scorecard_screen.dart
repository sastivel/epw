import 'package:EPW_mobile/core/model/exam/get_scorecard_response.dart';
import 'package:EPW_mobile/utils/string_resource.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:just_audio/just_audio.dart';

import '../../../utils/common_imports.dart';
import '../../../utils/image_resource.dart';
import '../../base/state/base_hook_consumer_widget.dart';
import '../../home/screens/home_screen.dart';
import '../bloc/Scorecard_state.dart';
import '../bloc/scorecard_bloc.dart';
import '../widget/scorecard_widget.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ScoreCardScreen extends BaseHookWidget {
  ScoreCardScreen({Key? key}) : super(key: key);

  ScorecardScreenBloc? scorecardScreenBloc;

  @override
  Widget build(BuildContext context) {
    scorecardScreenBloc = useBloc<ScorecardScreenBloc>(closeOnDispose: false);
    final state = useBlocBuilder(scorecardScreenBloc!);

    final AudioPlayer _player = AudioPlayer();
    _player.setLoopMode(LoopMode.off);
    _player.setAsset("assets/images/winner_click.mp3");
    _player.play();

    final screenSize = MediaQuery.of(context).size;
    final isTablet = screenSize.shortestSide >= 600; // Basic tablet check

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: ExactAssetImage(ImageResource.APPBG4),
              fit: BoxFit.fill,
              alignment: Alignment.topCenter,
            ),
          ),
          child: state is ScorecardScreenLoadingState
              ? const Center(child: CircularProgressIndicator())
              : LayoutBuilder(
                  builder: (context, constraints) {
                    double imageHeight = isTablet
                        ? screenSize.height * 0.6
                        : screenSize.height * 0.5;
                    double buttonSpacing = isTablet ? 40 : 20;
                    double scoreTopMargin = isTablet
                        ? screenSize.height * 0.30
                        : screenSize.height * 0.3;
                    double fontSize = isTablet ? 28 : 24;

                    return Stack(
                      children: [
                        Center(
                          child: SizedBox(
                            height: imageHeight,
                            width: screenSize.width * 0.9,
                            child: SvgPicture.asset(
                              ImageResource.IMAGE_SCORE_CARD,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: screenSize.height * 0.2,
                          left: screenSize.width * 0.25,
                          right: screenSize.width * 0.25,
                          child: Column(
                            children: [
                              InkWell(
                                onTap: () {
                                  _player.dispose();
                                  pushReplacement(context, HomeScreen());
                                },
                                child: ScoreCardWidgets.homeBtn(context),
                              ),
                              SizedBox(height: buttonSpacing),
                              InkWell(
                                onTap: () {
                                  showPopup(
                                      context,
                                      scorecardScreenBloc?.scorecard,
                                      scorecardScreenBloc!);
                                },
                                child: ScoreCardWidgets.detailBtn(context),
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          top: scoreTopMargin,
                          left: 20,
                          child: Text(
                            '${scorecardScreenBloc?.answerCount}/${scorecardScreenBloc?.diaAbilityType == 'Mild Intellectual Disability' ? 25 : 60}',
                            style: TextStyle(
                              fontSize: fontSize,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
        ),
      ),
    );
  }

  void showPopup(
      BuildContext context, Scorecard? scorecard, ScorecardScreenBloc bloc) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            StringResource.correctAnswerCount.tr(),
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          content: Column(mainAxisSize: MainAxisSize.min, children: [
            ListTile(
              title: Text(StringResource.correctAnswerCount.tr(),
                  style: TextStyle(fontWeight: FontWeight.bold)),
              trailing: Text(scorecard!.correctAnswerCount.toString()),
            ),
            ListTile(
              title: Text(StringResource.correctFillups.tr(),
                  style: TextStyle(fontWeight: FontWeight.bold)),
              trailing: Text(scorecard.fillUpCount.toString()),
            ),
            ListTile(
              title: Text(StringResource.correctChooseOneCount.tr(),
                  style: TextStyle(fontWeight: FontWeight.bold)),
              trailing: Text(scorecard.chooseOneCount.toString()),
            ),
            ListTile(
              title: Text(StringResource.correctOneWordCount.tr(),
                  style: TextStyle(fontWeight: FontWeight.bold)),
              trailing: Text(scorecard.oneWordCount.toString()),
            ),
            ListTile(
              title: Text(StringResource.correctTrueFalseCount.tr(),
                  style: TextStyle(fontWeight: FontWeight.bold)),
              trailing: Text(scorecard.trueFalseCount.toString()),
            ),
            if (bloc.diaAbilityType != "3")
              ListTile(
                title: Text(StringResource.correctMatchCount.tr(),
                    style: TextStyle(fontWeight: FontWeight.bold)),
                trailing: Text(scorecard.matchFollowingCount.toString()),
              ),
          ]),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }
}
