import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:individualproject/screens/UpdateDetails.dart';

class ViewPlantDetails extends StatefulWidget {
  const ViewPlantDetails({Key? key}) : super(key: key);
  @override
  _ViewPlantDetails createState() => _ViewPlantDetails();
}

class _ViewPlantDetails extends State<ViewPlantDetails> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(),
        body: Container(
          padding: EdgeInsets.all(15.0),
          decoration: BoxDecoration(
              color: Color.fromRGBO(255, 255, 255, 1),
              borderRadius: BorderRadius.circular(30.0)),
          child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("Plant Information")
                  .snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (snapshot.hasData) {
                  return ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        final DocumentSnapshot documentSnapshot =
                            snapshot.data!.docs[index];

                        Map<String, dynamic> profiledata =
                            documentSnapshot.data()! as Map<String, dynamic>;
                        print(profiledata.toString());

                        return Container(
                          margin: EdgeInsets.fromLTRB(10.0, 8.0, 0, 8.0),
                          decoration: BoxDecoration(
                              color: Color.fromARGB(255, 9, 192, 103),
                              borderRadius: BorderRadius.circular(25.0)),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            //  mainAxisAlignment: MainAxisAlignment.,
                            children: [
                              SizedBox(
                                width: 3,
                              ),
                              FutureBuilder(
                                  future: _getProfileImage(profiledata),
                                  builder: (context, AsyncSnapshot snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    }
                                    if (snapshot.hasData) {
                                      return ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(15.0),
                                          child: Image.network(
                                            snapshot.data.toString(),
                                            width: 100,
                                          ));
                                    }
                                    return Center(
                                      child: Text(
                                        "No Image Found",
                                        style: TextStyle(
                                            fontSize: 12,
                                            decoration: TextDecoration.none),
                                      ),
                                    );
                                  }),
                              SizedBox(
                                width: 15,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 25),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.text_format,
                                        color: Colors.deepOrangeAccent,
                                        size: 20,
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        profiledata['Plant Name'],
                                        style: TextStyle(
                                            decoration: TextDecoration.none,
                                            fontSize: 20,
                                            fontStyle: FontStyle.normal,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                      )
                                    ],
                                  ),
                                  SizedBox(height: 25),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.money,
                                        color: Colors.deepOrangeAccent,
                                        size: 20,
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        profiledata['Price'],
                                        style: TextStyle(
                                            decoration: TextDecoration.none,
                                            fontSize: 20,
                                            fontStyle: FontStyle.normal,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                      )
                                    ],
                                  ),
                                  SizedBox(height: 25),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.details_rounded,
                                        color: Colors.deepOrangeAccent,
                                        size: 20,
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      SizedBox(
                                          width: 200,
                                          child: Text(
                                            profiledata['Description'],
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 4,
                                            style: TextStyle(
                                                decoration: TextDecoration.none,
                                                fontSize: 18,
                                                fontStyle: FontStyle.normal,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white),
                                          )),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 25,
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      FloatingActionButton(
                                        onPressed: () {
                                          // _update(documentSnapshot);
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      UpdateDetails(
                                                        snapshot:
                                                            documentSnapshot,
                                                      )));
                                        },
                                        backgroundColor:
                                            Color.fromARGB(255, 9, 192, 103),
                                        child: Icon(
                                            Icons.edit), //edit garna plany list
                                      ),
                                      SizedBox(
                                        width: 35,
                                      ),
                                      FloatingActionButton(
                                        onPressed: () {
                                          _delete(documentSnapshot);
                                        },
                                        backgroundColor:
                                            Color.fromARGB(255, 9, 192, 103),
                                        child: Icon(
                                          Icons.delete,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 25,
                                  )
                                ],
                              )
                            ],
                          ),
                        );
                      });
                }

                return Center(
                  child: Text("No Data"),
                );
              }),
        ));
  }

  _getProfileImage(Map<String, dynamic> profiledata) async {
    String plant_name = profiledata['Plant Name'];
    print(plant_name);

    String _imageurl = await FirebaseStorage.instance
        .ref('${plant_name}/Image')
        .getDownloadURL();
    print(_imageurl);
    return _imageurl;
  }

  _update(DocumentSnapshot<Object?> documentSnapshot) {}

  _delete(DocumentSnapshot<Object?> documentSnapshot) async {
    await FirebaseFirestore.instance
        .collection("Plant Information")
        .doc(documentSnapshot.id)
        .delete();
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('You have successfully deleted a product')));
  }
}
