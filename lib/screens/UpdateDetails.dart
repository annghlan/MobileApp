import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class UpdateDetails extends StatefulWidget {
  final DocumentSnapshot snapshot;
  const UpdateDetails({Key? key, required this.snapshot}) : super(key: key);
  @override
  _UpdateDetails createState() => _UpdateDetails();
}

class _UpdateDetails extends State<UpdateDetails> {
  Map<String, dynamic>? _plantData;
  TextEditingController _plantName = TextEditingController();
  TextEditingController _plantPrice = TextEditingController();
  TextEditingController _descriptionData = TextEditingController();
  @override
  void initState() {
    super.initState();
    _plantData = widget.snapshot.data()! as Map<String, dynamic>;
    _plantName.text = _plantData!['Plant Name'];
    _plantPrice.text = _plantData!['Price'];
    _descriptionData.text = _plantData!['Description'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Padding(
            padding: EdgeInsets.all(25.0),
            child: Container(
              padding: EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                  color: Colors.greenAccent,
                  borderRadius: BorderRadius.circular(30.0)),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // TextField(
                  //   controller: _plantName,
                  //   decoration: const InputDecoration(labelText: 'Plant Name'),
                  // ),
                  TextField(
                    keyboardType: TextInputType.number,
                    controller: _plantPrice,
                    decoration: const InputDecoration(
                      labelText: 'Plant Price',
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextField(
                    // keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    controller: _descriptionData,
                    decoration: const InputDecoration(
                      labelText: 'Description',
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    child: const Text('Update'),
                    onPressed: () async {
                      final String plant_name = _plantName.text;

                      final String plant_price = (_plantPrice.text);
                      final String description = _descriptionData.text;
                      if (
                          // plant_name.isNotEmpty &&
                          plant_price.isNotEmpty && description.isNotEmpty) {
                        // await _products
                        //     .doc(documentSnapshot!.id)
                        //     .update({"name": name, "price": price});
                        await FirebaseFirestore.instance
                            .collection("Plant Information")
                            .doc(widget.snapshot.id)
                            .update({
                          // "Plant Name": plant_name,
                          "Price": plant_price.toString(),
                          "Description": description.toString(),
                        }).then((value) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text(
                                      'You have successfully deleted a product')));
                        });
                        // _plantName.text = '';
                        _plantPrice.text = '';
                        _descriptionData.text = '';
                        Navigator.of(context).pop();
                      }
                    },
                  )
                ],
              ),
            )));
    // TODO: implement build
  }
}
