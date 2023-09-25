import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_file_downloader/flutter_file_downloader.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController idController = TextEditingController();
  String id = "";
  void getDocString() {
    setState(() {
      id = idController.text.trim();
    });

    log(id);

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
              onPressed: () {
                getDocString();
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
                        child: Text("Print"),
                        onPressed: () {
                          FileDownloader.downloadFile(
                              url: userMap["pdfurl"].toString());
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
