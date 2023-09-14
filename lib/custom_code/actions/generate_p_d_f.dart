// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'dart:io';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:google_fonts/google_fonts.dart';
import '../../auth/firebase_auth/auth_util.dart';
import '../../backend/firebase_storage/storage.dart';
import 'dart:typed_data';
// Set your action name, define your arguments and return parameter,
// and then add the boilerplate code using the button on the right!

Future generatePDF(
  BuildContext context,
  String? sender,
  String? receiverPhone,
  String? packageType,
  String? breakable,
  String? qrCode,
  double? rev,
  String? destination,
) async {
  // null safety
  sender = sender ?? '';
  receiverPhone = receiverPhone ?? '';
  packageType = packageType ?? '';
  breakable = breakable ?? '';
  qrCode = qrCode ?? '';
  rev = rev ?? 0.0;
  destination = destination ?? '';

  final pdf = pw.Document();
  final now = DateTime.now();
  var font = await PdfGoogleFonts.cairoRegular();
  final bytes = (await rootBundle.load('assets/images/nazik_delivery.png'))
      .buffer
      .asUint8List();
  final image = pw.MemoryImage(bytes);
// add network image
  // final netImage = await networkImage('https://www.nfet.net/nfet.jpg');

  // add asset image, IMPORTANT! Using assets will not work in Test/Run mode you can only test it using Web Publishing mode or using an actual device!
  // final bytes =
  //     (await rootBundle.load('assets/images/demo.png')).buffer.asUint8List();
  // final image = pw.MemoryImage(bytes);

  pdf.addPage(
    pw.Page(
      pageFormat: PdfPageFormat.a6.landscape,
      build: (pw.Context context) {
        return pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.center,
          children: [
            pw.Container(width: 60.0, height: 60.0, child: pw.Image(image)),

            // pw.Text('Nazik', style: pw.TextStyle(fontSize: 18)),
            pw.Text('$now', style: pw.TextStyle(font: font, fontSize: 10)),
            pw.Text('$breakable',
                textDirection: pw.TextDirection.rtl,
                style: pw.TextStyle(font: font, fontSize: 10)),
            // pw.Text('Date: 2023-03-14'),
            // pw.SizedBox(height: 20),
            // pw.SizedBox(height: 20),
            // pw.Text('Bill To:', style: pw.TextStyle(fontSize: 18)),
            // pw.Text('John Doe'),
            // pw.Text('123 Main Street'),
            // pw.Text('City, State 12345'),
            // pw.SizedBox(height: 20),
            // pw.Text('Items:', style: pw.TextStyle(fontSize: 18)),
            // pw.Container(
            //   child: pw.Table.fromTextArray(
            //     headerStyle: pw.TextStyle(fontWeight: pw.FontWeight.bold),
            //     border: pw.TableBorder.all(width: 0, color: PdfColors.white),
            //     data: [
            //       ['Item', 'Total'],
            //       ['test', '50'],
            //
            //     ],
            //   ),
            // ),
            // pw.SizedBox(height: 20),
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.BarcodeWidget(
                  color: PdfColor.fromHex("#000000"),
                  barcode: pw.Barcode.qrCode(),
                  data: "$qrCode",
                  width: 100,
                  height: 100,
                ),
                pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.end,
                  mainAxisAlignment: pw.MainAxisAlignment.start,
                  children: [
                    pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.end,
                      children: [
                        pw.Text('$sender',
                            textDirection: pw.TextDirection.rtl,
                            style: pw.TextStyle(font: font, fontSize: 10)),
                        pw.Text('المرسل :   ',
                            textDirection: pw.TextDirection.rtl,
                            style: pw.TextStyle(font: font, fontSize: 10)),
                      ],
                    ),
                    pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.end,
                      children: [
                        pw.Text('$receiverPhone',
                            textDirection: pw.TextDirection.rtl,
                            style: pw.TextStyle(font: font, fontSize: 10)),
                        pw.Text('المستلم :   ',
                            textDirection: pw.TextDirection.rtl,
                            style: pw.TextStyle(font: font, fontSize: 10)),
                      ],
                    ),
                    pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.end,
                      children: [
                        pw.Text('$packageType',
                            textDirection: pw.TextDirection.rtl,
                            style: pw.TextStyle(font: font, fontSize: 10)),
                        pw.Text('نوع البضاعة:   ',
                            textDirection: pw.TextDirection.rtl,
                            style: pw.TextStyle(font: font, fontSize: 10)),
                      ],
                    ),
                    pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.end,
                      children: [
                        pw.Text('$destination',
                            textDirection: pw.TextDirection.rtl,
                            style: pw.TextStyle(font: font, fontSize: 10)),
                        pw.Text('الوجهة :   ',
                            textDirection: pw.TextDirection.rtl,
                            style: pw.TextStyle(font: font, fontSize: 10)),
                      ],
                    ),
                    pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.end,
                      children: [
                        pw.Text('$rev',
                            textDirection: pw.TextDirection.rtl,
                            style: pw.TextStyle(font: font, fontSize: 10)),
                        pw.Text('المبلغ:   ',
                            textDirection: pw.TextDirection.rtl,
                            style: pw.TextStyle(font: font, fontSize: 10)),
                      ],
                    ),
                  ],
                )
              ],
            ),
            // pw.Row(
            //   mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            //   children: [
            //     pw.Text('Tax (5%):'),
            //     pw.Text('6'),
            //   ],
            // ),
            // pw.Row(
            //   mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            //   children: [
            //     pw.Text('Total:'),
            //     pw.Text('126'),
            //     // pw.Image(netImage),
            //     // pw.Image(image),
            //   ],
            // ),
          ],
        );
      },
    ),
  );

  final pdfSaved = await pdf.save();

  // Get the current date and time
  // final now = DateTime.now();

// Format the date and time as a string
  // final formattedDateTime =
  //     '${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}_${now.hour.toString().padLeft(2, '0')}-${now.minute.toString().padLeft(2, '0')}-${now.second.toString().padLeft(2, '0')}';

// Set the file name to the formatted date and time string
  // final fileName = '$formattedDateTime.pdf';

// Set the directory where you want to store the file (e.g., a folder named 'pdfs' in your storage)
  // String directoryPath = '/users/' + currentUserUid + '/pdfs';

// Combine the directory path and file name to create the full storage path
  // final storagePath = '$directoryPath/$fileName';

  // SAVE IT TO FIREBASE STORE
  // final downloadUrl = await uploadData(storagePath, pdfSaved);
  // FFAppState().name = downloadUrl ?? '';

  // PRINT IT
  await Printing.layoutPdf(onLayout: (PdfPageFormat format) async => pdfSaved);
}
