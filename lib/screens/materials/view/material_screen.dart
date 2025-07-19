import 'package:EPW_mobile/screens/materials/view/material_detail_screen.dart';
import 'package:EPW_mobile/utils/color_resource.dart';
import 'package:EPW_mobile/utils/string_resource.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gif_view/gif_view.dart';
import 'package:just_audio/just_audio.dart';
import 'package:flutter/services.dart';
import 'package:EPW_mobile/utils/material_details.dart';

class MaterialScreen extends StatefulWidget {
  @override
  _MaterialScreenState createState() => _MaterialScreenState();
}

class _MaterialScreenState extends State<MaterialScreen> {
  final List<dynamic> materialList = MaterialDetails().materialList1; // Cached MaterialDetails
  late AudioPlayer _player;

  @override
  void initState() {
    super.initState();
    _player = AudioPlayer();
  }

  @override
  void dispose() {
    _player.dispose(); // Dispose AudioPlayer to avoid memory leaks
    super.dispose();
  }

  Future<void> _playSound(audio) async {
    try {
      _player.play();
    } catch (e) {
      print("Error loading audio: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorResource.COLOR_APP_TEXT_FIELD_BORDER,
        title: Text(
          StringResource.STUDYMAT.tr(),
          style: const TextStyle(color: ColorResource.WHITEE5E5E5),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: GridView.builder(
          itemCount: materialList.length,
          itemBuilder: (ctx, i) {
            return _buildMaterialCard(context, i);
          },
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 1.0,
            crossAxisSpacing: 10.0,
            mainAxisSpacing: 10,
            mainAxisExtent: 264,
          ),
        ),
      ),
    );
  }

  Widget _buildMaterialCard(BuildContext context, int index) {
    final material = materialList[index]; // Access material only once
    return InkWell(
      onTap: () async {
        SystemSound.play(SystemSoundType.click);
        await _playSound(context.locale.toString() == "ta_IN" ? material["tamil_click_audio"] : material["english_click_audio"] ); // Play sound on tap
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MaterialDetailScreen(index, material),
          ),
        );
      },
      child: Card(
        child: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height/3,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
              ),
              margin: const EdgeInsets.only(top:5,left: 5,right: 5, bottom: 30),
              padding: const EdgeInsets.all(5),
              child: Container(
                width: 400,
                child: GifView.asset(
                  material['image'], // Load the GIF from asset
                  frameRate: 30,
                  fit: BoxFit.fill,
                ),
              ),
            ),
            _buildMaterialNameOverlay(material['name']),
          ],
        ),
      ),
    );
  }

  Widget _buildMaterialNameOverlay(String name) {
    return Positioned(
      bottom: 0,
      child: Column(
        children: [
          Container(
          height: 50,
            width: MediaQuery.of(context).size.width/2.06,
            color: Colors.black.withOpacity(0.4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  name,
                  textAlign: TextAlign.start,
                  maxLines: 2,
                  style: const TextStyle(
                    fontSize: 18,

                    overflow: TextOverflow.ellipsis,
                    fontWeight: FontWeight.w900,
                    color: ColorResource.WHITEFFFFFF,
                  ),
                ),
              //    const SizedBox(width: 10),
                // Icon(Icons.forward, color: Colors.white),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
