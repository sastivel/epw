import 'package:EPW_mobile/screens/base/state/base_hook_consumer_widget.dart';
import 'package:EPW_mobile/screens/materials/view/pdf_view.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:easy_pdf_viewer/easy_pdf_viewer.dart';

import '../../../custome_widgets/custom_style.dart';
import '../../../utils/color_resource.dart';
import '../../../utils/common_imports.dart';
import '../../../utils/image_resource.dart';
import '../../../utils/string_resource.dart';

import 'package:open_file/open_file.dart';

import 'audio_player.dart';

class MaterialDetailScreen extends StatefulWidget {
  int? index;
  var info;
  MaterialDetailScreen(this.index, this.info);

  @override
  State<MaterialDetailScreen> createState() => _MaterialDetailScreen();
}

class _MaterialDetailScreen extends State<MaterialDetailScreen> {
  // List<dynamic> dataList = [
  //   {
  //     "image": ImageResource.INTRO_IMAGE,
  //     "engDoc": ImageResource.INTRO_DOC_ENGLISH,
  //     "engAudio": ImageResource.INTRO_AUDIO_ENG,
  //     "tamilDoc": ImageResource.INTRO_DOC_TAMIL,
  //     "tamilAudio": ImageResource.INTRO_AUDIO_TAMIL
  //   }
  // ];
  late final userLang = context.locale;
  AssetsAudioPlayer assetPlayer = AssetsAudioPlayer.newPlayer();
  ValueNotifier<String> audioLock = ValueNotifier('');

  PDFDocument? doc;
  loadAsset() async {
    // convert before check the language use * ? * operator..
    if (context.locale.toString() == "ta_IN") {
      doc = await PDFDocument.fromAsset(widget.info['tamil_pdf']);
    } else {
      doc = await PDFDocument.fromAsset(widget.info['english_pdf']);
    }

    print("testtt<<<<--" +
        " <doc> " +
        doc.toString() +
        " <lang> s" +
        context.locale.toString() +
        " <file> " +
        widget.info['english_pdf']);
  }

  bool isPlaying = false;
  @override
  Widget build(BuildContext context) {
    loadAsset();
    print('***************docu***********${widget.info["tamil_pdf"]}');
    print('***************docu***********${widget.info["english_pdf"]}');
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(StringResource.MATDETAIL.tr()),
          backgroundColor: ColorResource.COLOR_APP_TEXT_FIELD_BORDER,
        ),
        body: Column(
          children: [
            Card(
              child: Container(
                height: MediaQuery.of(context).size.height / 3,
                width: MediaQuery.of(context).size.width,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(20)),
                margin: const EdgeInsets.all(5),
                padding: const EdgeInsets.all(5),
                child: Image.asset(
                  widget.info['image'],
                  fit: BoxFit.fill,
                ),
              ),
            ),
            SizedBox(
              height: 50,
            ),
            if (widget.info['tamil_pdf'] != null ||
                widget.info['english_pdf'] != null)
              InkWell(
                onTap: () {
                  // Load from assets
                  //     OpenFile.open(widget.info['']);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PDFViewerScreen(
                                doc: doc,
                              )));
                },
                child: Container(
                    alignment: FractionalOffset.center,
                    height: 40,
                    width: 150,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: ColorResource.COLOR_APP_BTN),
                    padding: const EdgeInsets.only(
                        top: 10, bottom: 10, left: 10, right: 10),
                    child: Text(
                      StringResource.OPNDOC.tr(),
                      style: CustomStyle.size14w500white(),
                    )),
              ),
            if (widget.info['tamil_audio'] != null ||
                widget.info['english_audio'] != null)
              AudioContainer(
                  url: context.locale.toString() == "ta_IN"
                      ? widget.info['tamil_audio']
                      : widget.info['english_audio'],
                  audioLock: audioLock),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
//                 if (widget.info['tamil_audio'] != null ||
//                     widget.info['english_audio'] != null)
//                   InkWell(
//                     onTap: () async {
//                       if (isPlaying == true) {
//                         assetPlayer.playOrPause();
//                         setState(() {
//                           isPlaying = false;
//                         });
//                       } else {
//                         //check the condition for  language is tamil or eng..
//                         if (context.locale.toString() == "ta_IN") {
//                           assetPlayer.open(
//                             Audio(widget.info['tamil_audio']),
//                             showNotification: true,
//                           );
//                         } else {
//                           assetPlayer.open(
//                             Audio(widget.info['english_audio']),
//                             showNotification: true,
//                           );
//                         }
//                         // }
//                         // else{
//                         //   assetPlayer.open(
//                         //   Audio(widget.info['tamil_audio']),
//                         //   showNotification: true,
//                         // );
//                         // }

// // );
// //      }else{
// //  assetPlayer.open(
// //     Audio(dataList[widget.index!]['tamilAudio']),
// //     showNotification: true,
// // );
// //      }

//                         assetPlayer.play();
//                         setState(() {
//                           isPlaying = true;
//                         });
//                       }
//                     },
//                     child: Container(
//                         alignment: FractionalOffset.center,
//                         height: 40,
//                         decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(10),
//                             color: ColorResource.COLOR_APP_BTN),
//                         padding: const EdgeInsets.only(
//                             top: 10, bottom: 10, left: 10, right: 10),
//                         child: Text(
//                           isPlaying
//                               ? StringResource.PAUSEAUD.tr()
//                               : StringResource.PLAYAUD.tr(),
//                           style: CustomStyle.size14w500white(),
//                         )),
//                   ),
              ],
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    assetPlayer.dispose();
    super.dispose();
  }
}
