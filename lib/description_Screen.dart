import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import 'controllers/imageController.dart';
import 'helpers/function.dart';
import 'models/tripModel.dart';

class DescriptionScreen extends StatefulWidget {
  @override
  _DescriptionScreenState createState() => _DescriptionScreenState();
  final TripModel trip;

  DescriptionScreen({required this.trip});
}

class _DescriptionScreenState extends State<DescriptionScreen> {
  final ImageController controller = Get.put(ImageController());

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: null,
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            color: Color(0xFFFFFFFF),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
            ),
            padding: const EdgeInsets.only(top: 16),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(25),
                  child: Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.arrow_back),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      const SizedBox(width: 8),

                      Padding(padding: EdgeInsets.symmetric(horizontal: 20),

                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: const Text(
                            "Reisedetails",
                            style: TextStyle(
                              fontSize: 20,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),

                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 10),

                // Wrap scrollable content in Expanded
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        // Reisedetails block
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Card(
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    _buildDataCard("Status", widget.trip.status),
                                    _buildDataCard("ID Nr", widget.trip.idNumber),
                                    _buildDataCard("Auftragsdatum",widget.trip.orderDate),
                                  ],
                                ),
                                Row(
                                  children: [
                                    _buildDataCard("Auftraggeberauswahl", widget.trip.client),
                                    _buildDataCard("Kunde", ""),
                                    _buildDataCard("Entfernung", '${widget.trip.distance} km'),
                                  ],
                                ),
                                Row(
                                  children: [
                                    _buildDataCard("Zeitdauer",formatDuration(widget.trip.duration)),
                                    _buildDataCard("Positionspreis", widget.trip.positionPrice),
                                    _buildDataCard("Klasse", widget.trip.tripClass),
                                  ],
                                ),
                                Row(
                                  children: [
                                    _buildDataCard("AKZ", widget.trip.akz),
                                    _buildDataCard("Marke", widget.trip.brand),
                                    _buildDataCard("Modell", widget.trip.model),
                                  ],
                                ),
                                Row(
                                  children: [
                                    _buildDataCard("FIN","N/A" ),
                                    _buildDataCard("Einheitennummer", widget.trip.unitNumber),
                                    _buildDataCard("Auftragsnummer", widget.trip.orderNumber),
                                  ],
                                ),
                                Row(
                                  children: [
                                    _buildDataCard("Bestellnummer",widget.trip.orderNumber),
                                    _buildDataCard("Bewertung",widget.trip.rating),
                                    _buildDataCard("Besonderheiten","N/A"),
                                  ],
                                ),
                                Row(
                                  children: [
                                    _buildDataCard("Bitte Beachten", "N/A"),
                                    _buildDataCard("Rote Kennzeichen Reinhardt", "N/A"),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),

                        const SizedBox(width: 8),
                        const Text(
                          "Abholldaten",
                          style: TextStyle(
                            fontSize: 20,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w600,
                          ),
                        ),

                        const SizedBox(width: 8),
                        // Abholldaten block
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Card(
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    _buildDataCard("Abholung-Von", widget.trip.pickupFrom),
                                    _buildDataCard("Ziel", 'N/A'),
                                    _buildDataCard("Abholung", widget.trip.pickup),
                                  ],
                                ),

                                Row(
                                  children: [
                                    _buildDataCard("Lieferort", widget.trip.deliveryLocation),
                                    _buildDataCard("Strasse Lieferadresse", widget.trip.deliveryStreetAddress),
                                    _buildDataCard("Ziel (PLZ)", widget.trip.destinationZipCode),
                                  ],
                                ),

                                Row(
                                  children: [
                                    _buildDataCard("Ziel (ORT)", widget.trip.destinationLocation),
                                    _buildDataCard("Ziel", 'N/A'),
                                    _buildDataCard("Abholung", ''),
                                  ],
                                ),

                              ],
                            ),
                          ),
                        ),


                        const SizedBox(width: 8),

                        Padding(padding: EdgeInsets.symmetric(horizontal: 20),

                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: const Text(
                              "Fahrerauswahl",
                              style: TextStyle(
                                fontSize: 20,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),

                        ),


                        const SizedBox(width: 8),
                        // Abholldaten block
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Card(
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child:  Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          children: [
                                            Text('Auftrag/Abholvollmacht', style: TextStyle(
                                              fontSize: 10,
                                              fontFamily: 'Inter',
                                              fontWeight: FontWeight.w400,
                                            ),),

                                            SizedBox(height: 5),
                                            GestureDetector(
                                              onTap: () async {
                                                showImagePickerDialog(context);

                                              },
                                              child: Container(
                                                width: double.infinity,
                                                color: Color(0xff2147a9),
                                                padding: const EdgeInsets.symmetric(vertical:50,horizontal: 8 ),
                                                child: Center(
                                                  child: Text(
                                                    'Klicken Sie hier, um ein\n Foto hochzuladen',
                                                    style: TextStyle(
                                                      fontSize: 10,
                                                      fontFamily: 'Inter',
                                                      color: Color(0xffffffff),
                                                      fontWeight: FontWeight.w400,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child:  Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          children: [
                                            Text('Lieferschein', style: TextStyle(
                                              fontSize: 10,
                                              fontFamily: 'Inter',
                                              fontWeight: FontWeight.w400,
                                            ),),

                                            SizedBox(height: 5),
                                            Container(
                                              width: double.infinity,
                                              color: Color(0xff2147a9),
                                              padding: const EdgeInsets.symmetric(vertical:50,horizontal: 8 ),
                                              child:Center(
                                                child: Text(
                                                  'Klicken Sie hier, um ein\n Foto hochzuladen',
                                                  style: TextStyle(
                                                    fontSize: 10,
                                                    fontFamily: 'Inter',
                                                    color: Color(0xffffffff),
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),



                              ],
                            ),
                          ),
                        ),

                        // Fahrerauswahl block
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Obx(() {
                                return GridView.builder(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3,
                                  ),
                                  itemCount: controller.selectedImages.length,
                                  itemBuilder: (context, index) {
                                    final image = controller.selectedImages[index];
                                    return Stack(
                                      children: [
                                        Positioned(
                                          child: Image.file(image, fit: BoxFit.cover),
                                        ),
                                        Positioned(
                                          top: 0,
                                          right: 0,
                                          child: IconButton(
                                            icon: Icon(Icons.close, color: Colors.red),
                                            onPressed: () {
                                              controller.removeImage(image);
                                            },
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              }),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  Widget _buildDataCard(String title, String value) {
    return Expanded(
      child:  Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text(title, style: TextStyle(
              fontSize: 10,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w400,
            ),),

            SizedBox(height: 5),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: Color(0xff2147a9),
                borderRadius: BorderRadius.circular(6), // Adjust radius as needed
              ),
              child: Center(
                child: Text(
                  convertIfNotPureNumber(value),
                  style: TextStyle(
                    fontSize: 10,
                    fontFamily: 'Inter',
                    color: Color(0xffffffff),
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
  void showImagePickerDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (_) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        backgroundColor: Colors.blue,
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 4,
                blurRadius: 10,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                ),
                onPressed: () async {
                  Navigator.pop(context);
                  await controller.pickImageFromCamera();
                },
                icon: const Icon(Icons.camera_alt),
                label: const Text("Camera"),
              ),
              const SizedBox(height: 10),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue.shade900,
                  foregroundColor: Colors.white,
                ),
                onPressed: () async {
                  Navigator.pop(context);
                  await controller.pickImages();
                },
                icon: const Icon(Icons.photo),
                label: const Text("Gallery"),
              ),
            ],
          ),
        ),
      ),
    );
  }

}