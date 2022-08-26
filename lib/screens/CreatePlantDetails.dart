import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:individualproject/screens/ViewPlantDetails.dart';

class CreatePlantDetails extends StatefulWidget {
  const CreatePlantDetails({Key? key}) : super(key: key);
  @override
  _CreatePlantDetails createState() => _CreatePlantDetails();
}

class _CreatePlantDetails extends State<CreatePlantDetails> {
  TextEditingController _plantName = TextEditingController();
  TextEditingController _plantPrice = TextEditingController();
  TextEditingController _descriptionData = TextEditingController();
  UploadTask? uploadtofirebase;

  File? plant_image_file;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    // var _descriptionData;
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        decoration: BoxDecoration(color: Color.fromARGB(255, 231, 226, 211)),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    color: Colors.grey.shade200,
                    width: 2.0,
                  ),
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Plant Information",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 17,
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'please enter the value';
                        }
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Plant Name",
                      ),
                      keyboardType: TextInputType.text,
                      controller: _plantName,
                    ),
                    SizedBox(
                      height: 17,
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'please enter the value';
                        }
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Price",
                      ),
                      keyboardType: TextInputType.number,
                      controller: _plantPrice,
                    ),
                    SizedBox(
                      height: 17,
                    ),
                    TextFormField(
                      minLines: 1,
                      maxLines: 8,
                      controller: _descriptionData,
                      keyboardType: TextInputType.multiline,
                      decoration: InputDecoration(
                        hintText: 'Description',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      width: 400,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.0),
                        color: Colors.blue,
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                  ],
                ),
              ),
              Column(
                // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextButton(
                      onPressed: () {
                        pickFile();
                      },
                      child: Container(
                          width: 250,
                          padding: EdgeInsets.all(10.0),
                          margin: EdgeInsets.all(3.0),
                          decoration:
                              BoxDecoration(color: Colors.lightGreenAccent),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            // mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.save_as_rounded,
                                size: 40,
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              Text("Pick Plant Picture",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  )),
                            ],
                          )))
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                  width: 150,
                  padding: EdgeInsets.all(5.0),
                  decoration: BoxDecoration(
                      color: Colors.teal,
                      borderRadius: BorderRadius.circular(15.0),
                      border:
                          Border.all(color: Colors.grey.shade700, width: 2.0)),
                  child: TextButton(
                      onPressed: () {
                        _storeInformation();
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.storage_sharp,
                            color: Colors.white,
                          ),
                          Text(
                            " SAVE ",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.w700),
                          )
                        ],
                      ))),
              SizedBox(
                height: 15,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _storeInformation() async {
    final plant_name = _plantName.text.trim();
    final plant_price = _plantPrice.text.trim();
    final desctiption = _descriptionData.text.trim();

    final plant_img_destination = '${plant_name}/Image';
    if (plant_name.isNotEmpty &&
        plant_price.isNotEmpty &&
        desctiption.isNotEmpty) {
      await FirebaseFirestore.instance.collection("Plant Information").add({
        "Plant Name": plant_name,
        "Price": plant_price.toString(),
        "Description": desctiption,
        // "Image Path": plant_image_file!.toString()
      }).then((value) {
        FirebaseStorage.instance
            .ref(plant_img_destination)
            .putFile(plant_image_file!);
            Navigator.push(
              context, MaterialPageRoute(builder: (context) => ViewPlantDetails()));
      });
    }
  }

  Future<void> pickFile() async {
    final result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.image,
    );
    if (result != null) {
      final file_path = result.files.single.path!;
      print(file_path);
      setState(() {
        plant_image_file = File(file_path);
        print(plant_image_file);
      });
    }
  }
}
