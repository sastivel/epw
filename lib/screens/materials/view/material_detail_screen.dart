import 'package:EPW_mobile/api/interface/login/login_response.dart';
import 'package:EPW_mobile/screens/materials/view/pdf_view.dart';
import 'package:EPW_mobile/screens/materials/view/video_player.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:easy_pdf_viewer/easy_pdf_viewer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../core/preference/app_preference.dart';
import '../../../custome_widgets/custom_style.dart';
import '../../../utils/color_resource.dart';
import '../../../utils/common_imports.dart';
import '../../../utils/image_resource.dart';
import '../../../utils/string_resource.dart';
import 'audio_player.dart';

class MaterialDetailScreen extends StatefulWidget {
  final int? index;
  final dynamic info;

  MaterialDetailScreen(this.index, this.info);

  @override
  _MaterialDetailScreenState createState() => _MaterialDetailScreenState();
}

class _MaterialDetailScreenState extends State<MaterialDetailScreen> {
  late final AssetsAudioPlayer assetPlayer;
  late final ValueNotifier<String> audioLock;
  SharedPreferences? sharedPreferences;
  AppPreferences? appPreferences;
  LoginResponseModel? loginResponseModel;
  PDFDocument? doc;
  bool isPlaying = false;

  @override
  void initState() {
    super.initState();
    assetPlayer = AssetsAudioPlayer.newPlayer();
    audioLock = ValueNotifier('');
    _initializeData();
  }

  Future<void> _initializeData() async {
    sharedPreferences = await SharedPreferences.getInstance();
    appPreferences = AppPreferences(sharedPreferences!);
    loginResponseModel = await appPreferences?.getUser();
    setState(() {
      loginResponseModel = loginResponseModel;
    });
    _loadPDF();
  }

  Future<void> _loadPDF() async {
    final locale = context.locale.toString();
    final pdfPath = locale == "ta_IN" ? widget.info['tamil_pdf'] : widget.info['english_pdf'];
    doc = await PDFDocument.fromAsset(pdfPath);
    print("Loaded PDF: $pdfPath");
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(StringResource.MATDETAIL.tr()),
          backgroundColor: ColorResource.COLOR_APP_TEXT_FIELD_BORDER,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              _buildImageCard(),
              const SizedBox(height: 50),
              if (widget.info['tamil_pdf'] != null || widget.info['english_pdf'] != null)
                _buildPDFButton(),
              const SizedBox(height: 20),
              if (_isAudioAvailable()) _buildAudioPlayer(),
              const SizedBox(height: 20),
              if (_isVideoAvailable()) _buildVideoPlayer(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImageCard() {
    return Card(
      child: Container(
        height: MediaQuery.of(context).size.height / 3,
        width: MediaQuery.of(context).size.width,
        margin: const EdgeInsets.all(5),
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Image.asset(
          widget.info['image'],
          fit: BoxFit.fill,
        ),
      ),
    );
  }

  Widget _buildPDFButton() {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PDFViewerScreen(doc: doc),
          ),
        );
      },
      child: Container(
        alignment: Alignment.center,
        height: 40,
        width: 150,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: ColorResource.COLOR_APP_BTN,
        ),
        padding: const EdgeInsets.all(10),
        child: Text(
          StringResource.OPNDOC.tr(),
          style: CustomStyle.size14w500white(),
        ),
      ),
    );
  }

  bool _isAudioAvailable() {
    return loginResponseModel?.student?.disablityType == "Visual Impairment" &&
        (widget.info['tamil_audio'] != null || widget.info['english_audio'] != null);
  }

  Widget _buildAudioPlayer() {
    final audioUrl = context.locale.toString() == "ta_IN"
        ? widget.info['tamil_audio']
        : widget.info['english_audio'];
    return AudioContainer(url: audioUrl, audioLock: audioLock);
  }

  bool _isVideoAvailable() {
    return loginResponseModel?.student?.disablityType != "Visual Impairment" &&
        (widget.info['tamil_video'] != null || widget.info['english_video'] != null);
  }

  Widget _buildVideoPlayer() {
    final videoUrl = context.locale.toString() == "ta_IN"
        ? widget.info['tamil_video']
        : widget.info['english_video'];
    return Container(
      margin: EdgeInsets.all(10),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height/4,
      child: VideoPlayerScreen(url: videoUrl),
    );
  }

  @override
  void dispose() {
    assetPlayer.dispose();
    super.dispose();
  }
}
