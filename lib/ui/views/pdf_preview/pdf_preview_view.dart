import 'package:flutter/material.dart';
import 'package:printing/printing.dart';
import 'package:stacked/stacked.dart';
import './pdf_preview_view_model.dart';

class PdfPreviewView extends StatelessWidget {
  const PdfPreviewView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<PdfPreviewViewModel>.reactive(
      viewModelBuilder: () => PdfPreviewViewModel(),
      onModelReady: (PdfPreviewViewModel model) async {
        await model.init();
      },
      builder: (
        BuildContext context,
        PdfPreviewViewModel model,
        Widget? child,
      ) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Formulir pernyataan pembimbing'),
          ),
          body: PdfPreview(
            build: (format) => model.makePdf(format),
            canDebug: false,
            canChangeOrientation: false,
            pdfFileName: 'formulir-pernyataan-pembimbing.pdf',
          ),
        );
      },
    );
  }
}
