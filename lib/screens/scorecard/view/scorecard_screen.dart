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

    final state = useBlocBuilder(
      scorecardScreenBloc!,
    );
    ValueNotifier<String> audioLock = ValueNotifier('');
    // AudioContainer(
    //   url: "assets/images/winner_click.mp3",
    //   audioLock: audioLock,
    //   canAutoPlay: true,
    // );
    final AudioPlayer _player = AudioPlayer();
    _player.setLoopMode(LoopMode.off);
    _player.setAsset("assets/images/winner_click.mp3");
    //_player.setUrl();
    _player.play();

    return SafeArea(
        child: Scaffold(
            resizeToAvoidBottomInset: false,
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
              child: state is ScorecardScreenLoadingState
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : Stack(
                      children: [
                        Center(
                          child: Container(
                            height: MediaQuery.of(context).size.height / 1.5,
                            width: MediaQuery.of(context).size.width,
                            child: SvgPicture.asset(
                              ImageResource.IMAGE_SCORE_CARD,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: MediaQuery.of(context).size.width / 2,
                          left: MediaQuery.of(context).size.width / 3,
                          child: Center(
                            child: InkWell(
                              onTap: () {
                                _player.dispose();
                                pushReplacement(context, HomeScreen());
                              },
                              child: ScoreCardWidgets.homeBtn(context),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: MediaQuery.of(context).size.width / 2.8,
                          left: MediaQuery.of(context).size.width / 3,
                          child: Center(
                            child: InkWell(
                              onTap: () {
                                showPopup(context, scorecardScreenBloc?.scorecard,scorecardScreenBloc!);
                              },
                              child: ScoreCardWidgets.detailBtn(context),
                            ),
                          ),
                        ),
                        Center(
                          child: Container(
                              margin: EdgeInsets.only(
                                  top: MediaQuery.of(context).size.width / 3.4,
                                  left: 20,
                                  bottom: 10),
                              child: scorecardScreenBloc?.diaAbilityType != null && scorecardScreenBloc?.diaAbilityType == 'Mild Intellectual Disability' ? Text(
                                '${scorecardScreenBloc?.answerCount}/25',
                                style: const TextStyle(
                                    fontSize: 24,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ) : Text(
                                '${scorecardScreenBloc?.answerCount}/60',
                                style: const TextStyle(
                                    fontSize: 24,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              )),
                        ),

                        //   ),
                        //  Container(
                        //   height: 100,
                        //   width: 100,
                        //   margin:  EdgeInsets.only(top: 0,left: MediaQuery.of(context).size.width/5,right:  MediaQuery.of(context).size.width/5,bottom: MediaQuery.of(context).size.width/5),
                        //   child: Image.asset(ImageResource.EXPLORE_IMAGE,

                        //   ),
                        // ),
                      ],
                    ),
            )));
  }

  void showPopup(BuildContext context, Scorecard? scorecard,ScorecardScreenBloc bloc) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title:  Text(StringResource.correctAnswerCount.tr(),style: TextStyle(fontWeight: FontWeight.bold),),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
           ListTile(title: Text(StringResource.correctAnswerCount.tr(),style: TextStyle(fontWeight: FontWeight.bold)),
            trailing: Text(scorecard!.correctAnswerCount.toString()),
         ),
              ListTile(title: Text(StringResource.correctFillups.tr(),style: TextStyle(fontWeight: FontWeight.bold)),
                trailing: Text(scorecard.fillUpCount.toString()),
              ),
              ListTile(title: Text(StringResource.correctChooseOneCount.tr(),style: TextStyle(fontWeight: FontWeight.bold)),
                trailing: Text(scorecard.chooseOneCount.toString()),
              ),
              ListTile(title: Text(StringResource.correctOneWordCount.tr(),style: TextStyle(fontWeight: FontWeight.bold)),
                trailing: Text(scorecard.oneWordCount.toString()),
              ),
              ListTile(title: Text(StringResource.correctTrueFalseCount.tr(),style: TextStyle(fontWeight: FontWeight.bold)),
                trailing: Text(scorecard.trueFalseCount.toString()),
              ),
              if(bloc.diaAbilityType != "3")
              ListTile(title: Text(StringResource.correctMatchCount.tr(),style: TextStyle(fontWeight: FontWeight.bold)),
                trailing: Text(scorecard.matchFollowingCount.toString()),
              ),
            ]
          ),
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
