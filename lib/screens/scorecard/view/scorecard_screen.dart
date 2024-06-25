import 'package:just_audio/just_audio.dart';

import '../../../utils/common_imports.dart';
import '../../../utils/image_resource.dart';
import '../../base/state/base_hook_consumer_widget.dart';
import '../../home/screens/home_screen.dart';
import '../../materials/view/audio_player.dart';
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

    print("reloadingggg");
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
                        Center(
                          child: Container(
                              margin: EdgeInsets.only(
                                  top: MediaQuery.of(context).size.width / 3.4,
                                  left: 20,
                                  bottom: 10),
                              child: Text(
                                '${scorecardScreenBloc?.answerCount}/60',
                                style: TextStyle(
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
}
