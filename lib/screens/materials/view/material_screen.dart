import 'package:EPW_mobile/screens/base/state/base_hook_consumer_widget.dart';
import 'package:EPW_mobile/screens/materials/view/material_detail_screen.dart';
import 'package:EPW_mobile/utils/color_resource.dart';
import 'package:EPW_mobile/utils/common_imports.dart';
import 'package:EPW_mobile/utils/image_resource.dart';
import 'package:EPW_mobile/utils/material_details.dart';
import 'package:EPW_mobile/utils/string_resource.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gif_view/gif_view.dart';
import 'package:just_audio/just_audio.dart';

// ignore: must_be_immutable
class MatrialScreen extends StatelessWidget {
  MatrialScreen({super.key});

  List<dynamic> materialList = [
    {"image": ImageResource.INTRO_IMAGE},
    {"image": ImageResource.ALAGE_IMAGE},
    {"image": ImageResource.FUNGI_IMAGE},
    {"image": ImageResource.BYRO_IMAGE},
    {"image": ImageResource.PTER_IMAGE},
    {"image": ImageResource.GYMNO_IMAGE},
    {"image": ImageResource.ANGIO_IMAGE},
    {"image": ImageResource.FLOWCHART_IMAGE},
  ];
  var MaterialDetailsss = MaterialDetails().materialList1;
  // final AudioPlayer _player = AudioPlayer();
  late AudioPlayer player = AudioPlayer();
  @override
  Widget build(BuildContext context) {
    // _player.setLoopMode(LoopMode.off);
    // _player.setAsset("assets/images/mouse_click.mp3");

    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorResource.COLOR_APP_TEXT_FIELD_BORDER,
        title: Text(
          StringResource.STUDYMAT.tr(),
          style: const TextStyle(color: ColorResource.WHITEE5E5E5),
        ),
      ),
      body: Container(
        child: GridView.builder(
          shrinkWrap: true,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          itemCount: materialList.length,
          itemBuilder: (ctx, i) {
            return InkWell(
              onTap: () async {
                SystemSound.play(SystemSoundType.click);
                //  _player.play();
                await player.setAsset('assets/images/mouse_click.mp3');
                player.play();

                Future.delayed(const Duration(milliseconds: 500), () {
// Here you can write your code

                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MaterialDetailScreen(
                              i, MaterialDetails().materialList1[i])));
                });
                ;
                // _player.dispose();
              },
              child: Card(
                child: Stack(
                  children: [
                    Container(
                        height: 290,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20)),
                        margin: const EdgeInsets.all(5),
                        padding: const EdgeInsets.all(5),
                        child: GifView.asset(
                          MaterialDetails().materialList1[i]['image'],

                          frameRate: 30, // default is 15 FPS
                        )
                        // Image.asset(
                        //   MaterialDetails().materialList1[i]['image'],
                        //   fit: BoxFit.fill,
                        // ),
                        ),
                    Positioned(
                        bottom: 0,
                        child: Container(
                          height: 40,
                          width: 175,
                          color: Colors.black.withOpacity(0.4),
                          child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                            MaterialDetails().materialList1[i]['name'],
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w900,
                                    color: ColorResource.WHITEFFFFFF),
                          ),
                          SizedBox(width: 10,),
                          Icon(Icons.forward,color: Colors.white,)
                                ],
                              )),
                        ))
                  ],
                ),
              ),
            );
          },
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 1.0,
            crossAxisSpacing: 0.0,
            mainAxisSpacing: 5,
            mainAxisExtent: 264,
          ),
        ),
      ),
    );
  }
}
