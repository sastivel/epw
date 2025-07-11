import 'package:EPW_mobile/screens/materials/view/video_player.dart';
import 'package:easy_pdf_viewer/easy_pdf_viewer.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class PDFViewerScreen extends StatefulWidget {
  PDFDocument? doc;
  String? videoUrl;
  bool? canShowVideo;

  PDFViewerScreen({this.doc,this.videoUrl,this.canShowVideo});

  @override
  _PDFViewerScreenState createState() => _PDFViewerScreenState();
}

class _PDFViewerScreenState extends State<PDFViewerScreen> {
  late VideoPlayerController _videoController;
  bool _isVideoInitialized = false;
  String pdfPath = 'assets/sample.pdf'; // Replace with your PDF path

  @override
  void initState() {
    super.initState();
    _initializeVideoPlayer();
  }

  Future<void> _initializeVideoPlayer() async {
    _videoController = VideoPlayerController.networkUrl(Uri.parse(widget.videoUrl!)); // Replace with your video path
    await _videoController.initialize();
    setState(() {
      _isVideoInitialized = true;
    });
  }

  @override
  void dispose() {
    _videoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PDF Reader and Video Player'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height:widget.canShowVideo == true && widget.videoUrl != null && widget.videoUrl != "" ?  MediaQuery.of(context).size.height/1.65 :MediaQuery.of(context).size.height ,
              child: PDFViewer(
                document: widget.doc!,
                scrollDirection: Axis.vertical,
                showNavigation: false,
                showPicker: true,
              ),
            ),
            SizedBox(height: 20),
            if(widget.canShowVideo == true && widget.videoUrl != null && widget.videoUrl != "")
            SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height/4,
                child: _buildVideoPlayer(widget.videoUrl,context))
          ],
        ),
      ),
    );
  }
  Widget _buildVideoPlayer(videoUrl,context) {
    return Container(
      margin: EdgeInsets.all(10),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height/4,
      child: VideoPlayerScreen(url: videoUrl),
    );
  }
}

