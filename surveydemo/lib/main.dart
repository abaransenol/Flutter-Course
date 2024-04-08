import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MaterialApp(home: SurveyList()));
}

class SurveyList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black87,
        title: Text("Firebase Survey Demo"),
      ),
      body: MyApp(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black87,
        child: Icon(Icons.add),
        onPressed: () {

        },
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    bool isPressed = false;
    return StreamBuilder(
        stream: FirebaseFirestore.instance.collection("langsurvey").snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text("Error: ${snapshot.error}");
          }

          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Center(child: CircularProgressIndicator());
            default:
              return ListView(
                children: snapshot.data!.docs.map((document) {
                  return Padding(
                    key: ValueKey(document["langName"]),
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(5)
                      ),
                      child: ListTile(
                        title: Text(document["langName"]),
                        subtitle: Text(document["vote"].toString()),
                        onLongPress: (){

                        },
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: Icon(Icons.add),
                              onPressed: () {
                                FirebaseFirestore.instance.runTransaction((transaction) async {
                                  final freshSnapshot = await transaction.get(document.reference);
                                  int vote = freshSnapshot["vote"];
                                  transaction.update(freshSnapshot.reference, {"vote": vote+1});
                                });
                                //document.reference.update({"vote":document["vote"] + 1});
                              },
                            ),
                            IconButton(
                              icon: Icon(Icons.remove),
                              onPressed: () {
                                if (document["vote"] > 0){
                                  FirebaseFirestore.instance.runTransaction((transaction) async {
                                    final freshSnapshot = await transaction.get(document.reference);
                                    int vote = freshSnapshot["vote"];
                                    transaction.update(freshSnapshot.reference, {"vote": vote-1});
                                  });
                                  //document.reference.update({"vote":document["vote"] - 1});
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }).toList(),
              );
          }
        });
  }
}

// class Survey {
//   late String langName;
//   late int vote;
//   late DocumentReference reference;
//
//   Survey.fromMap(Map<String,dynamic> map, {required this.reference}):
//         assert(map["langName"] != null), assert(map["vote"] != null),
//         langName = map["langName"],
//         vote = map["vote"];
//
//   Survey.fromSnapshot(DocumentSnapshot snapshot){
//    var data = snapshot.data();
//    print(data);
//   }
// }
// Widget buildBody(BuildContext context, DocumentSnapshot snapshot) {
//   return ListView(
//     padding: EdgeInsets.all(15),
//     children: [
//       snapshot.map()
//     ],
//   );
// }
