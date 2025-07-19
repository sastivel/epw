import 'dart:async';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:EPW_mobile/screens/materials/view/video_player.dart';

class PDFViewerScreen extends StatefulWidget {
  final String? doc;
  final String? videoUrl;
  final bool? canShowVideo;

  PDFViewerScreen({this.doc, this.videoUrl, this.canShowVideo});

  @override
  _PDFViewerScreenState createState() => _PDFViewerScreenState();
}

class _PDFViewerScreenState extends State<PDFViewerScreen> {
  late VideoPlayerController _videoController;
  bool _isVideoInitialized = false;

  @override
  void initState() {
    super.initState();
    if (widget.canShowVideo == true && widget.videoUrl != null && widget.videoUrl!.isNotEmpty) {
      _initializeVideoPlayer();
    }
  }

  Future<void> _initializeVideoPlayer() async {
    _videoController = VideoPlayerController.networkUrl(Uri.parse(widget.videoUrl!));
    await _videoController.initialize();
    setState(() {
      _isVideoInitialized = true;
    });
  }

  @override
  void dispose() {
    if (_isVideoInitialized) {
      _videoController.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final showVideo = widget.canShowVideo == true && widget.videoUrl != null && widget.videoUrl!.isNotEmpty;

    return Scaffold(
      appBar: AppBar(
        title: const Text('PDF Reader and Video Player'),
      ),
      body: Column(
        children: [
          // PDF Viewer takes remaining space if video is visible
          Expanded(
            flex: showVideo ? 2 : 1,
            child: widget.doc != null
                ? SfPdfViewer.asset(widget.doc!)
                : const Center(child: Text("PDF file not found")),
          ),

          // Video Player (only if available)
          if (showVideo)
            Flexible(
              flex: 1,
              child: _isVideoInitialized
                  ? Padding(
                padding: const EdgeInsets.all(8.0),
                child: VideoPlayerScreen(url: widget.videoUrl!),
              )
                  : const Center(child: CircularProgressIndicator()),
            ),
        ],
      ),
    );
  }
}
