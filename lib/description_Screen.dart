import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'controllers/imageController.dart';
import 'helpers/function.dart';
import 'models/picturedata_model.dart';
import 'models/tripModel.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:signature/signature.dart';
import 'dart:typed_data';
import 'controllers/protocol_controller.dart';

class DescriptionScreen extends StatefulWidget {
  @override
  _DescriptionScreenState createState() => _DescriptionScreenState();
  final TripModel trip;

  DescriptionScreen({required this.trip});
}

class _DescriptionScreenState extends State<DescriptionScreen> with TickerProviderStateMixin {
  final ImageController controller = Get.put(ImageController());
  final ProtocolController protocolController = Get.put(ProtocolController());
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

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
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
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

                // Tab Bar
                TabBar(
                  controller: _tabController,
                  labelColor: Color(0xff2147a9),
                  unselectedLabelColor: Colors.grey,
                  indicatorColor: Color(0xff2147a9),
                  tabs: [
                    Tab(text: "Trip Details"),
                    Tab(text: "Protocol"),
                  ],
                ),

                // Tab Bar View
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      _buildTripDetailsTab(),
                      _buildProtocolTab(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTripDetailsTab() {
    return SingleChildScrollView(
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
                      _buildDataCard("Quelle", 'N/A'),
                      _buildDataCard("Abholung", widget.trip.pickup),
                    ],
                  ),

                  Row(
                    children: [
                      _buildDataCard("Abholort", widget.trip.pickupLocation),
                      _buildDataCard("Straße Abholadresse", widget.trip.pickupStreetAddress),
                      _buildDataCard("Quelle (PLZ)", widget.trip.sourceZipCode),
                    ],
                  ),

                  Row(
                    children: [
                      _buildDataCard("Quelle (ORT)", widget.trip.sourceLocation),
                      _buildDataCard("Zusatzinformation", ''),
                      _buildDataCard("Abholung", ''),
                    ],
                  ),

                ],
              ),
            ),
          ),

          const SizedBox(width: 8),
          const Text(
            "Lieferdaten",
            style: TextStyle(
              fontSize: 20,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w600,
            ),
          ),

          const SizedBox(width: 8),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              child: Column(
                children: [
                  Row(
                    children: [
                      _buildDataCard("Auslieferung-Bis", widget.trip.pickupFrom),
                      _buildDataCard("Ziel", 'N/A'),
                      _buildDataCard("Lieferung", widget.trip.pickup),
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
  Widget _buildProtocolTab() {
    return Obx(() =>
        SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. Pickup Date + Time
              _buildSectionTitle("1. Pickup Date + Time"),
              GestureDetector(
                onTap: () => _selectDateTime(true),
                child: Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.calendar_today, color: Color(0xff2147a9)),
                      SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          protocolController.pickupDateTime.value.isEmpty
                              ? "Select Date & Time"
                              : protocolController.pickupDateTime.value,
                          style: TextStyle(
                            fontSize: 16,
                            color: protocolController.pickupDateTime.value.isEmpty
                                ? Colors.grey
                                : Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 16),

              // 2. Pickup KM
              _buildSectionTitle("2. Pickup KM"),
              TextField(
                controller: protocolController.pickupKmController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: "Enter KM",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.speed, color: Color(0xff2147a9)),
                ),
              ),
              SizedBox(height: 16),

              // 3. Photo Pickup Speedometer
              _buildSectionTitle("3. Photo Pickup Speedometer"),
              _buildImagePickerSection(
                protocolController.pickupSpeedometerImages,
                    () => _pickImage(protocolController.pickupSpeedometerImages),
              ),
              SizedBox(height: 16),

              // 4. Tank Pickup
              _buildSectionTitle("4. Tank Pickup"),
              _buildDropdown(
                protocolController.selectedTankPickup.value,
                ['0','1/8','1/4', '3/8', '1/2', '5/8', '3/4','5/8','7/8','1'],
                    (value) => protocolController.selectedTankPickup.value = value!,
                "Select tank level",
              ),
              SizedBox(height: 16),

              // 5. Pickup AdBlue
              _buildSectionTitle("5. Pickup AdBlue"),
              _buildDropdown(
                protocolController.selectedAdBluePickup.value,
                ['0','1/4', '1/2', '3/4','1z'],
                    (value) => protocolController.selectedAdBluePickup.value = value!,
                "Select AdBlue level",
              ),
              SizedBox(height: 16),

              // 6. Default Takeover
              _buildSectionTitle("6. Default Takeover"),
              _buildMultiSelectCheckbox(
                protocolController.defaultTakeoverOptions,
                protocolController.selectedDefaultTakeover,
              ),
              SizedBox(height: 16),

              // 7. Pickup Dirt - Where?
              _buildSectionTitle("7. Pickup Dirt - Where?"),
              _buildMultiSelectCheckbox(
                protocolController.pickupDirtOptions,
                protocolController.selectedPickupDirt,
              ),
              SizedBox(height: 16),

              // 8. Equipment + Accessories
              _buildSectionTitle("8. Equipment + Accessories"),
              _buildMultiSelectCheckbox(
                protocolController.equipmentOptions,
                protocolController.selectedEquipment,
              ),
              SizedBox(height: 16),

              // 9. Remark and Damage
              _buildSectionTitle("9. Remark and Damage"),
              TextField(
                controller: protocolController.remarkController,
                maxLines: 3,
                decoration: InputDecoration(
                  hintText: "Enter remarks and damage details",
                  border: OutlineInputBorder(),
                  prefixIcon: Padding(
                    padding: EdgeInsets.only(bottom: 60),
                    child: Icon(Icons.note_add, color: Color(0xff2147a9)),
                  ),
                ),
              ),
              SizedBox(height: 16),

              // 10. Picture Pickup
              _buildSectionTitle("10. Picture Pickup"),
              _buildPictureSection(protocolController.pickupPictures),
              SizedBox(height: 16),

              // 11. Signature Driver Pickup
              _buildSectionTitle("11. Signature Driver Pickup"),
              _buildSignatureSection(protocolController.driverPickupSignature),
              SizedBox(height: 16),

              // 12. Signature Handover
              _buildSectionTitle("12. Signature Handover"),
              _buildSignatureSection(protocolController.handoverSignature),
              SizedBox(height: 16),

              // 13. Image Delivery Speedometer
              _buildSectionTitle("13. Image Delivery Speedometer"),
              _buildImagePickerSection(
                protocolController.deliverySpeedometerImages,
                    () => _pickImage(protocolController.deliverySpeedometerImages),
              ),
              SizedBox(height: 16),

              // 14. Delivery Date Time
              _buildSectionTitle("14. Delivery Date Time"),
              GestureDetector(
                onTap: () => _selectDateTime(false),
                child: Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.calendar_today, color: Color(0xff2147a9)),
                      SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          protocolController.deliveryDateTime.value.isEmpty
                              ? "Select Date & Time"
                              : protocolController.deliveryDateTime.value,
                          style: TextStyle(
                            fontSize: 16,
                            color: protocolController.deliveryDateTime.value.isEmpty
                                ? Colors.grey
                                : Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 16),

              // 15. Delivery KM Stand
              _buildSectionTitle("15. Delivery KM Stand"),
              TextField(
                controller: protocolController.deliveryKmController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: "Enter KM",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.speed, color: Color(0xff2147a9)),
                ),
              ),
              SizedBox(height: 16),

              // 16. Delivery Tank
              _buildSectionTitle("16. Delivery Tank"),
              _buildDropdown(
                protocolController.selectedTankDelivery.value,
                ['0','1/8','1/4', '3/8', '1/2', '5/8', '3/4','5/8','7/8','1'],
                    (value) => protocolController.selectedTankDelivery.value = value!,
                "Select tank level",
              ),
              SizedBox(height: 16),

              // 17. Delivery AdBlue
              _buildSectionTitle("17. Delivery AdBlue"),
              _buildDropdown(
                protocolController.selectedAdBlueDelivery.value,
                ['0','1/4', '1/2', '3/4', '1'],
                    (value) => protocolController.selectedAdBlueDelivery.value = value!,
                "Select AdBlue level",
              ),
              SizedBox(height: 16),

              // 18. Picture Delivery
              _buildSectionTitle("18. Picture Delivery"),
              _buildPictureSection(protocolController.deliveryPictures),
              SizedBox(height: 16),

              // 19. Signature Delivery Vehicle
              _buildSectionTitle("19. Signature Delivery Vehicle"),
              _buildSignatureSection(protocolController.deliveryVehicleSignature),
              SizedBox(height: 32),

              // Submit Button
              Container(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => _submitForm(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xff2147a9),
                    padding: EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    "Submit Protocol",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 32),
            ],
          ),
        ));
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: Color(0xff2147a9),
        ),
      ),
    );
  }

  Widget _buildDropdown(String selectedValue, List<String> options, Function(String?) onChanged, String hint) {
    return DropdownButtonFormField<String>(
      value: selectedValue.isEmpty ? null : selectedValue,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        hintText: hint,
        prefixIcon: Icon(Icons.arrow_drop_down_circle, color: Color(0xff2147a9)),
      ),
      items: options.map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      onChanged: onChanged,
    );
  }


  Widget _buildImagePickerSection(RxList<File> images, VoidCallback onTap) {
    return Column(
      children: [
        GestureDetector(
          onTap: onTap,
          child: Container(
            width: double.infinity,
            height: 120,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey, style: BorderStyle.solid),
              borderRadius: BorderRadius.circular(8),
              color: Color(0xff2147a9),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.camera_alt, color: Colors.white, size: 40),
                  SizedBox(height: 8),
                  Text(
                    "Tap to capture image",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(height: 8),
        Obx(() =>
        images.isNotEmpty
            ? Container(
          height: 100,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: images.length,
            itemBuilder: (context, index) {
              return Container(
                margin: EdgeInsets.only(right: 8),
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.file(
                        images[index],
                        width: 80,
                        height: 80,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                      top: 0,
                      right: 0,
                      child: GestureDetector(
                        onTap: () => images.removeAt(index),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.red,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.close,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        )
            : Container()),
      ],
    );
  }

  Widget _buildPictureSection(RxList<PictureData> pictures) {
    return Column(
      children: [
        ElevatedButton.icon(
          onPressed: () => _showPictureDialog(pictures),
          icon: Icon(Icons.add_a_photo),
          label: Text("Add Picture"),
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xff2147a9),
            foregroundColor: Colors.white,
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          ),
        ),
        SizedBox(height: 8),
        Obx(() =>
        pictures.isNotEmpty
            ? Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            children: [
              // Table Header
              Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Color(0xff2147a9).withOpacity(0.1),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8),
                    topRight: Radius.circular(8),
                  ),
                ),
                child: Row(
                  children: [
                    Expanded(flex: 2, child: Text("Picture", style: TextStyle(fontWeight: FontWeight.bold))),
                    Expanded(flex: 3, child: Text("Date - Time", style: TextStyle(fontWeight: FontWeight.bold))),
                    Expanded(flex: 3, child: Text("Location", style: TextStyle(fontWeight: FontWeight.bold))),
                    Expanded(flex: 1, child: Text("Action", style: TextStyle(fontWeight: FontWeight.bold))),
                  ],
                ),
              ),
              // Table Rows
              ...pictures
                  .asMap()
                  .entries
                  .map((entry) {
                int index = entry.key;
                PictureData picture = entry.value;
                return Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: Colors.grey.shade300),
                    ),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.file(
                            picture.image,
                            width: 50,
                            height: 50,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8),
                          child: Text(
                            picture.dateTime,
                            style: TextStyle(fontSize: 12),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8),
                          child: Text(
                            picture.location,
                            style: TextStyle(fontSize: 12),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: IconButton(
                          icon: Icon(Icons.delete, color: Colors.red, size: 20),
                          onPressed: () => pictures.removeAt(index),
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ],
          ),
        )
            : Container()),
      ],
    );
  }

  Widget _buildSignatureSection(Rx<Uint8List?> signatureData) {
    return Column(
      children: [
        Container(
          height: 200,
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Obx(() =>
          signatureData.value != null
              ? Stack(
            children: [
              Container(
                width: double.infinity,
                height: double.infinity,
                child: Image.memory(
                  signatureData.value!,
                  fit: BoxFit.contain,
                ),
              ),
              Positioned(
                top: 8,
                right: 8,
                child: GestureDetector(
                  onTap: () => signatureData.value = null,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.close,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                ),
              ),
            ],
          )
              : Center(
            child: ElevatedButton.icon(
              onPressed: () => _showSignatureDialog(signatureData),
              icon: Icon(Icons.edit),
              label: Text("Add Signature"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xff2147a9),
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              ),
            ),
          )),
        ),
      ],
    );
  }

  Widget _buildDataCard(String title, String value) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 10,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(height: 5),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: Color(0xff2147a9),
                borderRadius: BorderRadius.circular(6),
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

  Future<void> _selectDateTime(bool isPickup) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null) {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );

      if (pickedTime != null) {
        final DateTime combinedDateTime = DateTime(
          pickedDate.year,
          pickedDate.month,
          pickedDate.day,
          pickedTime.hour,
          pickedTime.minute,
        );

        final String formattedDateTime = "${pickedDate.day}/${pickedDate.month}/${pickedDate.year} ${pickedTime.format(context)}";

        if (isPickup) {
          protocolController.pickupDateTime.value = formattedDateTime;
        } else {
          protocolController.deliveryDateTime.value = formattedDateTime;
        }
      }
    }
  }

  Future<void> _pickImage(RxList<File> imageList) async {
    showDialog(
      context: context,
      builder: (context) =>
          AlertDialog(
            title: Text("Select Image Source"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  leading: Icon(Icons.camera_alt, color: Color(0xff2147a9)),
                  title: Text("Camera"),
                  onTap: () async {
                    Navigator.pop(context);
                    final ImagePicker picker = ImagePicker();
                    final XFile? image = await picker.pickImage(source: ImageSource.camera);
                    if (image != null) {
                      imageList.add(File(image.path));
                    }
                  },
                ),
                ListTile(
                  leading: Icon(Icons.photo, color: Color(0xff2147a9)),
                  title: Text("Gallery"),
                  onTap: () async {
                    Navigator.pop(context);
                    final ImagePicker picker = ImagePicker();
                    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
                    if (image != null) {
                      imageList.add(File(image.path));
                    }
                  },
                ),
              ],
            ),
          ),
    );
  }

  void _showPictureDialog(RxList<PictureData> pictures) {
    final TextEditingController locationController = TextEditingController();
    DateTime selectedDateTime = DateTime.now();

    showDialog(
      context: context,
      builder: (context) =>
          StatefulBuilder(
            builder: (context, setState) =>
                AlertDialog(
                  title: Text("Add Picture"),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Image picker buttons
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton.icon(
                            onPressed: () async {
                              final ImagePicker picker = ImagePicker();
                              final XFile? image = await picker.pickImage(source: ImageSource.camera);
                              if (image != null) {
                                Navigator.pop(context);
                                _showPictureDetailsDialog(pictures, File(image.path));
                              }
                            },
                            icon: Icon(Icons.camera_alt),
                            label: Text("Camera"),
                          ),
                          ElevatedButton.icon(
                            onPressed: () async {
                              final ImagePicker picker = ImagePicker();
                              final XFile? image = await picker.pickImage(source: ImageSource.gallery);
                              if (image != null) {
                                Navigator.pop(context);
                                _showPictureDetailsDialog(pictures, File(image.path));
                              }
                            },
                            icon: Icon(Icons.photo),
                            label: Text("Gallery"),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
          ),
    );
  }

  // Add these missing methods to your _DescriptionScreenState class

// Method to show picture details dialog (missing from your code)
  void _showPictureDetailsDialog(RxList<PictureData> pictures, File imageFile) {
    final TextEditingController dateTimeController = TextEditingController();
    final TextEditingController locationController = TextEditingController();

    // Set current date time as default
    final now = DateTime.now();
    dateTimeController.text = "${now.day}/${now.month}/${now.year} ${now.hour}:${now.minute.toString().padLeft(2, '0')}";

    showDialog(
      context: context,
      builder: (context) =>
          AlertDialog(
            title: Text("Picture Details"),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Show selected image
                  Container(
                    height: 150,
                    width: double.infinity,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.file(
                        imageFile,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(height: 16),

                  // Date Time input
                  GestureDetector(
                    onTap: () async {
                      final DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2101),
                      );

                      if (pickedDate != null) {
                        final TimeOfDay? pickedTime = await showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.now(),
                        );

                        if (pickedTime != null) {
                          final String formattedDateTime = "${pickedDate.day}/${pickedDate.month}/${pickedDate.year} ${pickedTime.format(context)}";
                          dateTimeController.text = formattedDateTime;
                        }
                      }
                    },
                    child: AbsorbPointer(
                      child: TextField(
                        controller: dateTimeController,
                        decoration: InputDecoration(
                          labelText: "Date & Time",
                          hintText: "Select date and time",
                          prefixIcon: Icon(Icons.calendar_today, color: Color(0xff2147a9)),
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 16),

                  // Location input
                  TextField(
                    controller: locationController,
                    decoration: InputDecoration(
                      labelText: "Location",
                      hintText: "Enter location",
                      prefixIcon: Icon(Icons.location_on, color: Color(0xff2147a9)),
                      border: OutlineInputBorder(),
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text("Cancel"),
              ),
              ElevatedButton(
                onPressed: () {
                  if (dateTimeController.text.isNotEmpty && locationController.text.isNotEmpty) {
                    final pictureData = PictureData(
                      image: imageFile,
                      dateTime: dateTimeController.text,
                      location: locationController.text,
                    );
                    pictures.add(pictureData);
                    Navigator.pop(context);
                  } else {
                    Get.snackbar('Error', 'Please fill all fields');
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xff2147a9),
                  foregroundColor: Colors.white,
                ),
                child: Text("Add Picture"),
              ),
            ],
          ),
    );
  }

// Method to show signature dialog
  void _showSignatureDialog(Rx<Uint8List?> signatureData) {
    final SignatureController signatureController = SignatureController(
      penStrokeWidth: 2,
      penColor: Colors.black,
      exportBackgroundColor: Colors.white,
    );

    showDialog(
      context: context,
      builder: (context) =>
          AlertDialog(
            title: Text("Add Signature"),
            content: Container(
              height: 300,
              width: double.maxFinite,
              child: Column(
                children: [
                  Container(
                    height: 200,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Signature(
                      controller: signatureController,
                      backgroundColor: Colors.white,
                    ),
                  ),
                  SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          signatureController.clear();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey,
                          foregroundColor: Colors.white,
                        ),
                        child: Text("Clear"),
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          if (signatureController.isNotEmpty) {
                            final Uint8List? signature = await signatureController.toPngBytes();
                            if (signature != null) {
                              signatureData.value = signature;
                              Navigator.pop(context);
                            }
                          } else {
                            Get.snackbar('Error', 'Please provide signature');
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xff2147a9),
                          foregroundColor: Colors.white,
                        ),
                        child: Text("Save"),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text("Cancel"),
              ),
            ],
          ),
    );
  }

// Method to handle form submission
  Future<void> _submitForm() async {
    try {
      // Show loading dialog
      Get.dialog(
        AlertDialog(
          content: Row(
            children: [
              CircularProgressIndicator(),
              SizedBox(width: 16),
              Text("Submitting protocol..."),
            ],
          ),
        ),
        barrierDismissible: false,
      );

      // Submit the protocol using the controller
      await protocolController.submitProtocol();

      // Close loading dialog
      Get.back();

      // Show success message and navigate back
      Get.snackbar(
        'Success',
        'Protocol submitted successfully!',
        backgroundColor: Colors.green,
        colorText: Colors.white,
        duration: Duration(seconds: 3),
      );

      // Navigate back to previous screen
      Navigator.pop(context);
    } catch (e) {
      // Close loading dialog
      Get.back();

      // Show error message
      Get.snackbar(
        'Error',
        'Failed to submit protocol: ${e.toString()}',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        duration: Duration(seconds: 5),
      );
    }
  }

// Fix for multi-select checkbox (single select)
// Fix for the _buildMultiSelectCheckbox method in DescriptionScreen
// Replace the existing method with this corrected version

  Widget _buildMultiSelectCheckbox(List<String> options, dynamic selected) {
    // Check if it's a multi-select (RxList) or single-select (RxString)
    if (selected is RxList<String>) {
      // Multi-select implementation
      return Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: options.map((option) {
            return Obx(() => CheckboxListTile(
              title: Text(option),
              value: selected.contains(option),
              onChanged: (bool? value) {
                if (value == true) {
                  selected.add(option);
                } else {
                  selected.remove(option);
                }
              },
              controlAffinity: ListTileControlAffinity.leading,
              activeColor: Color(0xff2147a9),
            ));
          }).toList(),
        ),
      );
    } else if (selected is RxString) {
      // Single-select implementation
      return Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: options.map((option) {
            return Obx(() => RadioListTile<String>(
              title: Text(option),
              value: option,
              groupValue: selected.value.isEmpty ? null : selected.value,
              onChanged: (String? value) {
                selected.value = value ?? '';
              },
              activeColor: Color(0xff2147a9),
            ));
          }).toList(),
        ),
      );
    }

    return Container(); // Fallback
  }

// Complete the ElevatedButton.styleFrom that was cut off in your original code

// Override the dispose method
  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}
