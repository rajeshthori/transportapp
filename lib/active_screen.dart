import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:transportapp/controllers/activeController.dart';

import 'controllers/homeController.dart';
import 'description_Screen.dart';
import 'helpers/function.dart';

class ActiveScreen extends StatefulWidget {
  @override
  _ActiveScreenState createState() => _ActiveScreenState();
}

class _ActiveScreenState extends State<ActiveScreen> {
  final Activecontroller controller = Get.put(Activecontroller());
  var email='';
  var name='';
  var mobile='';
  var driverLocation='';

  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  void _checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    name = prefs.getString('name') ?? '';
    email = prefs.getString('email') ?? '';
    mobile = prefs.getString('phone') ?? '';
    driverLocation = prefs.getString('address') ?? '';

    controller.fetchTripsWithPost({
      "driver_email": email,
      "status": "In Progress"

    });
    print("name$name");
    print("email $email");
    print("mobile $mobile");
    print("driverLocation $driverLocation");

  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: null,
      child: Scaffold(
        body:  Container(
          decoration: const BoxDecoration(
            color: Color(0xFFFFFFFF), // light yellow
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
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: const Text(
                      "Abgeschlossene Fahrten",
                      style: TextStyle(fontSize: 20, fontFamily:'Inter',fontWeight: FontWeight.w600),
                    ),
                  ),
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
      ),
    );
  }

}