import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:pengajual_judul/app/core/custom_base_view_model.dart';
import 'package:pengajual_judul/models/mahasiswa_model.dart';

import '../../../app/app.locator.dart';
import '../../../app/app.logger.dart';
import '../../../models/judul_model.dart';
import '../../../services/auth_service.dart';
import '../../../services/dosen_service.dart';
import '../../../services/judul_service.dart';

class PdfPreviewViewModel extends CustomBaseViewModel {
  final log = getLogger('PdfPreviewViewModel');

  final _authService = locator<AuthService>();
  final _judulService = locator<JudulService>();
  final _dosenService = locator<DosenService>();

  MahasiswaModel? get mahasiswa => _authService.mahasiswa;
  JudulModel? get judul => _judulService.judulDiterima;

  Future<void> init() async {}

  Future<Uint8List> makePdf(PdfPageFormat format) async {
    final pdf = Document();

    final imageLogo = MemoryImage(
        (await rootBundle.load('assets/images/logo.png')).buffer.asUint8List());

    final pembimbings = [
      await _dosenService.get(judul!.pembimbing1!),
      await _dosenService.get(judul!.pembimbing2!)
    ];

    final textStyle = TextStyle(
      fontSize: 12,
      font: Font.times(),
      fontBold: Font.timesBold(),
      fontItalic: Font.timesItalic(),
    );

    for (var pembimbing in pembimbings) {
      pdf.addPage(Page(
        pageFormat: format,
        margin: const EdgeInsets.all(40),
        theme: ThemeData(
          defaultTextStyle: textStyle,
        ),
        build: (Context context) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 35,
                    width: 35,
                    child: Image(imageLogo),
                  ),
                  SizedBox(width: 4),
                  SizedBox(
                    height: 35,
                    child: VerticalDivider(
                      color: PdfColors.black,
                      thickness: 4,
                    ),
                  ),
                  SizedBox(width: 4),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'FAKULTAS TEKNIK',
                        style: TextStyle(
                          font: Font.helveticaBold(),
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text('UNIVERSITAS MUHAMMADIYAH PAREPARE',
                          style: TextStyle(font: Font.helvetica())),
                    ],
                  ),
                  Spacer(),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 150,
                        child: Divider(
                          color: PdfColors.grey,
                          thickness: 1,
                          height: 0,
                        ),
                      ),
                      Text(
                        'FT - UMPAR',
                        style: TextStyle(font: Font.helvetica(), fontSize: 24),
                      ),
                      SizedBox(
                        width: 150,
                        child: Divider(
                          color: PdfColors.grey,
                          thickness: 1,
                          height: 0,
                        ),
                      ),
                      SizedBox(height: 2),
                      Text(
                        'Gedung D Lantai 1 Kampus II',
                        style: const TextStyle(fontSize: 8),
                      ),
                      Text(
                        'Jln. Jend. A. Yani Km. 6 Kota Parepare',
                        style: const TextStyle(fontSize: 8),
                      ),
                      Text(
                        'Website:',
                        style: const TextStyle(fontSize: 8),
                      ),
                      Text(
                        'Email:',
                        style: const TextStyle(fontSize: 8),
                      ),
                    ],
                  )
                ],
              ),
              Center(
                child: SizedBox(
                  height: 50,
                  width: 50,
                  child: Image(imageLogo),
                ),
              ),
              SizedBox(height: 8),
              Center(
                child: Text('FORMULIR PERNYATAAN CALON DOSEN PEMBIMBING'),
              ),
              SizedBox(height: 4),
              Center(
                child: Text(
                  'SKRIPSI',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 16),
              Text('Yang bertanda tangan di bawah ini :', style: textStyle),
              SizedBox(height: 4),
              Padding(
                padding: const EdgeInsets.only(left: 32),
                child: Column(
                  children: [
                    Row(children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Nama'),
                          Text('NBM'),
                          Text('Jabatan'),
                        ],
                      ),
                      SizedBox(width: 84),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(':'),
                          Text(':'),
                          Text(':'),
                        ],
                      ),
                      SizedBox(width: 16),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(pembimbing.nama ?? ''),
                          Text(pembimbing.nbm ?? ''),
                          Text(pembimbing.jabatan ?? ''),
                        ],
                      ),
                    ]),
                  ],
                ),
              ),
              SizedBox(height: 8),
              RichText(
                text: TextSpan(text: 'Dengan ini menyatakan bahwa ', children: [
                  TextSpan(
                    text: 'menyetujui / tidak menyetujui',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const TextSpan(text: '*) Judul Skripsi dan '),
                  TextSpan(
                    text: 'Bersedia / Tidak Bersedia',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const TextSpan(
                      text:
                          '*) menjadi pembimbing skripsi untuk mahasiswa dan judul skripsi sebagai berikut:'),
                ]),
              ),
              SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.only(left: 32),
                child: Column(
                  children: [
                    Row(children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Nama Mahasiswa'),
                          Text('NIM'),
                          Text('Program Studi'),
                          Text('Judul Skripsi'),
                        ],
                      ),
                      SizedBox(width: 32),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(':'),
                          Text(':'),
                          Text(':'),
                          Text(':'),
                        ],
                      ),
                      SizedBox(width: 16),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(mahasiswa?.nama ?? ''),
                          Text(mahasiswa?.nim ?? ''),
                          Text('Teknik Informatika'),
                          Text(judul?.judul ?? ''),
                        ],
                      ),
                    ]),
                  ],
                ),
              ),
              SizedBox(height: 8),
              Text('Catatan dari Calon Dosen Pembimbing:'),
              SizedBox(height: 4),
              Container(
                height: 150,
                decoration: BoxDecoration(
                  border: Border.all(color: PdfColors.black),
                ),
              ),
              SizedBox(height: 8),
              Text(
                  'Demikian Pernyataan kami, atas perhatiannya kami ucapkan banyak terima kasih.'),
              SizedBox(height: 32),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Spacer(),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                          'Parepare, ${DateFormat('dd MMMM yyyy').format(DateTime.now())}'),
                      Text('Calon Dosen Pembimbing,'),
                      SizedBox(height: 45),
                      Text(
                        pembimbing.nama ?? '',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                      Text('NBM. ${pembimbing.nbm ?? ''}'),
                    ],
                  ),
                  SizedBox(width: 32),
                ],
              ),
              Spacer(),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: PdfColor.fromHex('#f0fcff'),
                  border: Border.all(
                    color: PdfColors.black,
                    width: 1,
                  ),
                ),
                padding: const EdgeInsets.all(4),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Keterangan :',
                        style: TextStyle(
                          font: Font.timesBold(),
                          fontWeight: FontWeight.bold,
                        )),
                    Text(
                      '*) Coret yang tidak perlu.',
                      style: TextStyle(
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                ),
              )
            ],
          );
        },
      ));
    }

    return pdf.save();
  }
}
