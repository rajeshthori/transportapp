import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:transportapp/description_Screen.dart';

import 'controllers/homeController.dart';
import 'helpers/function.dart';
import 'login_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HomeController controller = Get.put(HomeController());
  var email='';
  var name='';
  var mobile='';
  var driverLocation='';
  var driverId='';

  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  void _checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      name = prefs.getString('name') ?? '';
      email = prefs.getString('email') ?? '';
      mobile = prefs.getString('phone') ?? '';
      driverLocation = prefs.getString('address') ?? '';
      driverId = prefs.getString('id')??'';
    });

    controller.fetchTripsWithPost({
      "driver_email": email.toLowerCase(),
      "status": "In Progress"
    });

    print("name: $name");
    print("email: $email");
    print("mobile: $mobile");
    print("driverLocation: $driverLocation");
    print("driverId: $driverId");
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: Container(
          color: Colors.white, // Important: sets background color to avoid black area
          child: Stack(
            children: [
              // Background image
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                height: 300,
                child: Image.asset(
                  'assets/images/home_image.png',
                  fit: BoxFit.cover,
                ),
              ),

              // Top content (text + location)
              Positioned(
                top: 50,
                left: 16,
                right: 16,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          driverLocation,
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                        SizedBox(width: 8),
                        Icon(Icons.location_on, color: Colors.white),
                        SizedBox(width: 8),
                        IconButton(
                          onPressed: () {
                            showImagePickerDialog(context);
                          },
                          icon: Icon(Icons.logout, color: Colors.white),
                        ),
                      ],
                    ),

                    const SizedBox(height: 16),
                    const Text("Willkommen!!",
                        style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
                     Text(name, style: TextStyle(color: Colors.white, fontSize: 18)),
                     Text("Fahrer-ID: $driverId", style: TextStyle(color: Colors.white)),
                     Text("Fahrzeugnummer: $mobile", style: TextStyle(color: Colors.white)),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Icon(Icons.notifications, color: Colors.orange),
                        Switch(value: true, onChanged: (val) {}),
                      ],
                    ),
                  ],
                ),
              ),

              // Bottom list container
              Positioned(
                top: 270,
                left: 0,
                right: 0,
                bottom: 0,
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
                  ),
                  padding: const EdgeInsets.only(top: 16),
                  child: Column(
                    children: [
                       Text(
                        name,
                        style: TextStyle(fontSize: 20, fontFamily:'Inter',fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 10),
                      Expanded(
                        child: Obx(() {
                          if (controller.isLoading.value) {
                            return const Center(child: CircularProgressIndicator());
                          }

                          if (controller.tripList.isEmpty) {
                            return Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    'assets/images/chat_icon.png', // apne image ka path yahan den
                                    height: 150,
                                  ),
                                  const SizedBox(height: 16),
                                  const Text(
                                    "Keine Benachrichtigungen",
                                    style: TextStyle(
                                      fontFamily: 'Inter',
                                      fontSize: 18,
                                      color: Color(0xff2147a9),
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const Text(
                                    "Wir werden Sie informieren, sobald es etwas Neues gibt.",
                                    style: TextStyle(
                                      fontFamily: 'Inter', // Make sure Inter font is added in pubspec.yaml
                                      fontSize: 12,
                                      color: Color(0xff797979),
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            );

                          }

                          return ListView.builder(
                            itemCount: controller.tripList.length,
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            itemBuilder: (context, index) {
                              final trip = controller.tripList[index];

                              return Container(
                                margin: const EdgeInsets.only(bottom: 16),
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(16),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black12,
                                      blurRadius: 4,
                                      offset: Offset(0, 2),
                                    )
                                  ],
                                  border: Border.all(color: Colors.grey.shade300),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                                      Text(
                                        trip.driver ?? "Unknown Trip",
                                        style: const TextStyle(fontSize: 13, fontFamily: 'Inter', fontWeight: FontWeight.w600),
                                      ),
                                      Align(
                                        alignment: Alignment.centerRight,
                                        child: ElevatedButton(
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => DescriptionScreen(trip: trip),
                                              ),
                                            );
                                          },

                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.white,
                                            foregroundColor: const Color(0xff2147a9),
                                            side: const BorderSide(color: Color(0xff2147a9)),
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(20),
                                            ),
                                          ),
                                          child: const Text(
                                            "Hier Klicken",
                                            style: TextStyle(fontSize: 12, fontFamily: 'Inter', fontWeight: FontWeight.w600),
                                          ),
                                        ),
                                      ),
                                    ]),
                                    const SizedBox(height: 10),
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Image.asset('assets/images/current_location.png'),
                                        const SizedBox(width: 8),
                                        Expanded(
                                          child: Text(
                                            trip.pickupLocation ?? "No source address",
                                            style: const TextStyle(fontSize: 10, fontFamily: 'Inter', fontWeight: FontWeight.w400),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 6),
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Image.asset('assets/images/location_icon.png'),
                                        const SizedBox(width: 8),
                                        Expanded(
                                          child: Text(
                                            trip.deliveryLocation ?? "No destination address",
                                            style: const TextStyle(fontSize: 10, fontFamily: 'Inter', fontWeight: FontWeight.w400),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 10),
                                    const Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                                      child: Divider(color: Colors.grey, thickness: 2),
                                    ),
                                    const SizedBox(height: 10),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 15),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            trip.brand ?? "No vehicle",
                                            style: const TextStyle(fontSize: 10, fontFamily: 'Inter', fontWeight: FontWeight.w400),
                                          ),
                                          Row(
                                            children: [
                                              Image.asset('assets/images/km_icon.png'),
                                              const SizedBox(width: 4),
                                              Text("${trip.distance} Km", style: const TextStyle(fontSize: 10, fontFamily: 'Inter', fontWeight: FontWeight.w400)),
                                              const SizedBox(width: 12),
                                              const Icon(Icons.timer, size: 16, color: Color(0xff2147a9)),
                                              const SizedBox(width: 4),
                                              Text(formatDuration(trip.duration) ?? "", style: const TextStyle(fontSize: 10, fontFamily: 'Inter', fontWeight: FontWeight.w400)),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                  ],
                                ),
                              );
                            },
                          );
                        }),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
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
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              
              SizedBox(height: 20,),
              Center(
                child: Text('Möchten Sie sich wirklich abmelden? ', style: TextStyle(
                  fontSize: 18,
                  color: Color(0xffffffff),
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w400,
                ),),
              ),
SizedBox(height: 20,),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                ),
                onPressed: () async {
                  SharedPreferences prefs = await SharedPreferences.getInstance();
                  await prefs.clear();
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                        (Route<dynamic> route) => false,
                  );
                },
                icon: Icon(Icons.logout),
                label: const Text("Abmelden"),
              ),

              const SizedBox(height: 10),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue.shade900,
                  foregroundColor: Colors.white,
                ),
                onPressed: () async {
                  Navigator.pop(context);

                },

                label: const Text("Nein"),
              ),
            ],
          ),
        ),
      ),
    );
  }

}