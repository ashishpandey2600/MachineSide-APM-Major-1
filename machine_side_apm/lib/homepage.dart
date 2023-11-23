import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

final doc = pw.Document();

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController idController = TextEditingController();

  String id = "";
  String pdfUrl = "";
  String getDocString() {
    setState(() {
      id = idController.text.trim();
      pdfUrl = id;
    });

    log(id);
    return id;
    //   FirebaseFirestore _firestore = await FirebaseFirestore.instance;
// //Fetching data from snapshot
//   QuerySnapshot snapshot = await _firestore
//       .collection('users')
//       .get(); //Go to users collection in firebase and get all users

//   for (var doc in snapshot.docs) {
//     log(doc.data().toString());
//   }
// //to only get user by id
    // DocumentSnapshot documentSnapshot =
    //     await _firestore.collection('users').doc("40pmuLO1k6weqRtl2ZxY").get();
    // log(documentSnapshot.data().toString());
  }

  Future<void> _printPdfFromUrl(BuildContext context, String pdfUrl) async {
    await Printing.layoutPdf(
      onLayout: (PdfPageFormat format) async {
        final doc = await Printing.convertHtml(
          format: format,
          html: '<iframe src="$pdfUrl"></iframe>',
        );
        return doc;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Enter PDF"),
      ),
      body: SafeArea(
          child: Column(
        children: [
          Text("Enter your pdf Id"),
          SizedBox(
            height: 20,
          ),
          TextField(
              controller: idController,
              decoration: InputDecoration(hintText: "Your Pdf Id")),
          CupertinoButton(
              child: const Text("Retrive pdf"),
              onPressed: () async {
                getDocString();
                // doc.addPage(pw.Page(
                //     pageFormat: PdfPageFormat.a4,
                //     build: (pw.Context context) {
                //       return pw.Center(
                //         child: pw.Image(pdfImage),
                //       ); // Center
                //     }));
                // await Printing.layoutPdf(
                //     onLayout: (PdfPageFormat format) => doc.save());
                // var data = await http.get(Uri.parse(url));
                // await Printing.sharePdf(
                //     bytes: data.bodyBytes, filename: 'my-document.pdf');
              }),
          SizedBox(
            height: 20,
          ),
          (id != "") ? showstatus(id) : Container(),
        ],
      )),
    );
  }
}

Widget showstatus(String id) {
  return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection("pdfs")
          .where("docid", isEqualTo: id)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          if (snapshot.hasData && snapshot.data != null) {
            return Expanded(
              child: ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    Map<String, dynamic> userMap = snapshot.data!.docs[index]
                        .data() as Map<String, dynamic>;

                    return ListTile(
                      title: Text(userMap["pdfurl"].toString()),
                      leading: Text(userMap["pagecount"].toString()),
                      trailing: CupertinoButton(
                        child: const Text("Print"),
                        onPressed: () async {
                          // FileDownloader.downloadFile(
                          //     url: userMap["pdfurl"].toString());

                          // Uri uri = Uri.parse(userMap["pdfurl"].toString());
                          // http.Response response = await http.get(uri);
                          // var pdfData = response.bodyBytes;
                          // await Printing.layoutPdf(
                          //     onLayout: (PdfPageFormat format) async =>
                          //         pdfData);
                          // var data = await http.get(uri);
                          // await Printing.layoutPdf(
                          //     onLayout: (_) => data.bodyBytes);

                          //for sharing
                          // var data = await http.get(uri);
                          // await Printing.sharePdf(
                          //     bytes: data.bodyBytes,
                          //     filename: 'my-document.pdf');

                          String pdfUrl = userMap["pdfurl"].toString();
                          // await Printing.layoutPdf(
                          //   onLayout: (PdfPageFormat format) async {
                          //     final doc = await Printing.convertHtml(
                          //       format: format,
                          //       html: '<iframe src="$pdfUrl"></iframe>',
                          //     );
                          //     return doc;
                          //   },
                          // );
                          downloadFile(pdfUrl);
                          // await Printing.layoutPdf(
                          //   onLayout: (PdfPageFormat format) async {
                          //     return await http
                          //         .get(Uri.parse(pdfUrl))
                          //         .then((response) => response.bodyBytes);
                          //   },
                          // );

                          runPythonScript();
                        },
                      ),
                    );
                  }),
            );
          } else {
            return Text("No data");
          }
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      });
}

void runPythonScript() async {
  log("run Python called");
  final result = await Process.run('python', ['AutoPrint/print1.py']);
  print(result.stdout);
  print(result.stderr);
}

Future<void> downloadFile(String url) async {
  log("Download File called");
  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    final Uint8List bytes = response.bodyBytes;

    final appDir = await getApplicationDocumentsDirectory();

    // Use current timestamp to create a unique file name
    final timestamp = DateFormat('yyyyMMdd_HHmmss').format(DateTime.now());
    final fileName = 'downloaded_file_$timestamp.pdf';

    final file = File('${appDir.path}/$fileName');

    await file.writeAsBytes(bytes);

    // Open the file or do whatever you want with it
    // You might want to use a PDF viewer or display it in your app
    // For example, you can use the 'open_file' package to open the PDF:
    // await OpenFile.open(file.path);
  } else {
    throw Exception('Failed to load PDF');
  }
}
