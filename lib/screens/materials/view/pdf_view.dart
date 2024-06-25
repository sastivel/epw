import 'package:EPW_mobile/screens/base/state/base_hook_consumer_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:easy_pdf_viewer/easy_pdf_viewer.dart';
import 'package:flutter/material.dart';

import '../../../utils/string_resource.dart';

class PDFViewerScreen extends BaseHookWidget {
  PDFDocument? doc;
  PDFViewerScreen({this.doc});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              title: Text(StringResource.DOCUMENT.tr()),
            ),
            body: SizedBox(
              child: PDFViewer(
                document: doc!,
                scrollDirection: Axis.vertical,
                showNavigation: false,
                showPicker: true,
               
              ),
            )));
  }
}
