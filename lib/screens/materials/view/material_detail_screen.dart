import 'package:EPW_mobile/api/interface/login/login_response.dart';
import 'package:EPW_mobile/screens/materials/view/pdf_view.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../core/preference/app_preference.dart';
import '../../../custome_widgets/custom_style.dart';
import '../../../utils/color_resource.dart';
import '../../../utils/common_imports.dart';
import '../../../utils/string_resource.dart';
import 'audio_player.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
class MaterialDetailScreen extends StatefulWidget {
  final int? index;
  final dynamic info;

  MaterialDetailScreen(this.index, this.info);

  @override
  _MaterialDetailScreenState createState() => _MaterialDetailScreenState();
}

class _MaterialDetailScreenState extends State<MaterialDetailScreen> {

  late final ValueNotifier<String> audioLock;
  SharedPreferences? sharedPreferences;
  AppPreferences? appPreferences;
  LoginResponseModel? loginResponseModel;
  String? doc;
  bool isPlaying = false;

  @override
  void initState() {
    super.initState();
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
    final disabilityType = loginResponseModel?.student?.disablityType;

    // Determine the correct PDF path based on locale and disability type
    final pdfPath = (disabilityType == "3" && widget.info['type'] != "FLOWCHART")
        ? (locale == "ta_IN" ? widget.info['tamil_mild_doc'] : widget.info['english_mild_doc'])
        : (locale == "ta_IN" ? widget.info['tamil_pdf'] : widget.info['english_pdf']);

    // Load the PDF
    doc = pdfPath;
    print("Loaded PDF: $pdfPath");
  }

  @override
  Widget build(BuildContext context) {
    final locale = context.locale.toString();
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
                _buildPDFButton(locale),
              const SizedBox(height: 20),
              if (_isAudioAvailable()) _buildAudioPlayer(),
              // const SizedBox(height: 20),
              // if (_isVideoAvailable()) _buildVideoPlayer(),
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

  Widget _buildPDFButton(locale) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PDFViewerScreen(doc: doc,canShowVideo: loginResponseModel?.student?.disablityType == "2" ? true : false, videoUrl:locale == "ta_IN" ?  widget.info['tamil_video']  : widget.info['english_video']),
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
    return loginResponseModel?.student?.disablityType == null ? false : (loginResponseModel?.student?.disablityType == "1") ?
        (widget.info['tamil_audio'] != null || widget.info['english_audio'] != null) : ( loginResponseModel?.student?.disablityType == "3") ?
        (widget.info['tamil_mild_audio'] != null || widget.info['english_mild_audio'] != null) : false
    ;
  }

  Widget _buildAudioPlayer() {
    final audioUrl = context.locale.toString() == "ta_IN"
        ? (loginResponseModel?.student?.disablityType == "1") ? widget.info['tamil_audio'] : widget.info['tamil_mild_audio']
        : (loginResponseModel?.student?.disablityType == "1") ? widget.info['english_audio'] : widget.info['english_mild_audio'];
    print("##########AUDIO${widget.info['english_audio']}###########");
    return AudioContainer(url: audioUrl, audioLock: audioLock);
  }


  @override
  void dispose() {
    super.dispose();
  }
}
