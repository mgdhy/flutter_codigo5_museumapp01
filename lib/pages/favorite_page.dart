import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_codigo5_museumapp/models/museum_model.dart';
import 'package:flutter_codigo5_museumapp/services/api_service.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:open_file/open_file.dart';

class FavoritePage extends StatefulWidget {
  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  APIService _apiService = APIService();
  List<MuseumModel> museums = [];

  @override
  initState() {
    super.initState();
    _getData();
  }

  _getData() {
    _apiService.getMuseums().then((value) {
      museums = value;
    });
  }

  _generatePDF() async {
    ByteData bytesx = await rootBundle.load("assets/images/image1.png");
    Uint8List imageBytes = bytesx.buffer.asUint8List();

    pw.Document pdf = pw.Document();

    // pdf.addPage(
    //   pw.Page(
    //     pageFormat: PdfPageFormat.a4,
    //     build: (pw.Context context) {
    //       // return pw.Image(
    //       //   pw.MemoryImage(
    //       //     imageBytes,
    //       //   ),
    //       // );
    //       return pw.Table(
    //         children: [
    //           pw.TableRow(
    //             children: [
    //               pw.Row(
    //                 mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
    //                 children: [
    //                   pw.Image(
    //                     height: 100.0,
    //                     pw.MemoryImage(
    //                       imageBytes,
    //                     ),
    //                   ),
    //                   pw.Container(
    //                     child: pw.Column(
    //                       crossAxisAlignment: pw.CrossAxisAlignment.end,
    //                       children:[
    //                         pw.Text("Calle Los Portales 23232 - Cayma - Arequipa"),
    //                         pw.Text("Tlf: 43432232"),
    //                         pw.Text("E-mail: isdsd@gmail.com"),
    //                         pw.Text("Página web: www.sdsad.com"),
    //                       ]
    //                     ),
    //                   ),
    //                 ],
    //               ),
    //             ],
    //           ),
    //           pw.TableRow(
    //             children:[
    //               pw.Divider(),
    //             ],
    //           ),
    //           pw.TableRow(
    //             children: [
    //               pw.Column(
    //                 // children: museums.map((e) => pw.Text(e.name)).toList()
    //                 children: List.generate(60, (index) => pw.Text("wwww")),
    //               ),
    //             ],
    //           ),
    //         ],
    //       );
    //     },
    //   ),
    // );

    pdf.addPage(
      pw.MultiPage(
          pageFormat: PdfPageFormat.a4,
          build: (pw.Context context) {
            return [
              pw.Table(
                children: [
                  pw.TableRow(
                    children: [
                      pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                        children: [
                          pw.Image(
                            height: 100.0,
                            pw.MemoryImage(
                              imageBytes,
                            ),
                          ),
                          pw.Container(
                            child: pw.Column(
                                crossAxisAlignment: pw.CrossAxisAlignment.end,
                                children: [
                                  pw.Text(
                                      "Calle Los Portales 23232 - Cayma - Arequipa"),
                                  pw.Text("Tlf: 43432232"),
                                  pw.Text("E-mail: isdsd@gmail.com"),
                                  pw.Text("Página web: www.sdsad.com"),
                                ]),
                          ),
                        ],
                      ),
                    ],
                  ),
                  pw.TableRow(
                    children: [
                      pw.Divider(),
                    ],
                  ),
                ],
              ),
              pw.Table(
                children: List.generate(
                  300,
                  (index) => pw.TableRow(
                    children: [
                      pw.Text("wwwwwwwwww"),
                    ],
                  ),
                ),
              ),
            ];
          }),
    );

    Uint8List bytes = await pdf.save();
    Directory dir = await getApplicationDocumentsDirectory();

    File _file = File("${dir.path}/example2PDF.pdf");

    _file.writeAsBytes(bytes);
    await OpenFile.open(_file.path);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () {
              _generatePDF();
            },
            child: Text(
              "Generar PDF",
            ),
          ),
        ],
      ),
    );
  }
}
