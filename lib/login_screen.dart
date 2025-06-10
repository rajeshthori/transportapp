import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:transportapp/controllers/loginController.dart';
import 'bottom_navigation.dart';
import 'helpers/GradientBackground.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final Logincontroller controller = Get.put(Logincontroller());
  bool passwordEye = true;
  @override
  Widget build(BuildContext context) {
    return GradientBackground(
        child: SafeArea(
      child: Scaffold(
        body: Container(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Image.asset(
                    'assets/images/logo.png',
                    width: 150,
                    height: 150,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                  children: [

                      Text(
                        'Willkommen!!',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 28,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w700),
                      ),
                      Text(
                        'Bitte geben Sie Ihre Anmeldedaten ein.!!',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Color(0xFF858080),
                            fontSize: 14,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w400),
                      ),
                  ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const SizedBox(
                  height: 2,
                ),
                Container(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      Padding(
                        padding: const EdgeInsets.only(top: 24.0), // space for label
                        child: Stack(
                          children: [
                            Positioned(
                              left: 20,
                              top: 0,
                              child: Text(
                                'Email',
                                style: TextStyle(color: Colors.black, fontSize: 12),
                              ),
                            ),
                            TextFormField(
                              controller: controller.emailController,
                              onChanged: (value) {
                                // Optional: add logic here
                              },
                              focusNode: controller.fieldFocusNodes['email'],
                              keyboardType: TextInputType.emailAddress,
                              textInputAction: TextInputAction.next,
                              onFieldSubmitted: (_) {
                                FocusScope.of(context)
                                    .requestFocus(controller.fieldFocusNodes['password']);
                              },
                              style: TextStyle(color: Colors.black),
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(2.0),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(2.0),
                                  borderSide: BorderSide(color: Colors.grey.shade300),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(2.0),
                                  borderSide: BorderSide(color: Colors.grey),
                                ),
                                contentPadding:
                                EdgeInsets.symmetric(vertical: 16.0, horizontal: 12.0),
                                labelText: 'Email Id',
                                labelStyle: TextStyle(color: Colors.grey, fontSize: 12),
                                floatingLabelBehavior: FloatingLabelBehavior.auto,
                                suffixIcon: Icon(Icons.email, color: Colors.grey),
                              ),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(
                        height: 10,
                      ),

                      Padding(
                        padding: const EdgeInsets.only(top: 24.0), // space for label
                        child: Stack(
                          children: [
                            Positioned(
                              left: 20,
                              top: 0,
                              child: Text(
                                'Password',
                                style: TextStyle(color: Colors.black, fontSize: 12),
                              ),
                            ),
                            TextFormField(
                              onChanged: (value) {
                                // Optional: add logic here
                              },
                              controller: controller.passwordController,
                              obscureText: passwordEye,
                              keyboardType: TextInputType.visiblePassword,
                              style: TextStyle(color: Colors.black),
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(2.0),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(2.0),
                                  borderSide: BorderSide(color: Colors.grey.shade300),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(2.0),
                                  borderSide: BorderSide(color: Colors.grey),
                                ),
                                contentPadding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 12.0),
                                labelText: 'Enter your password',
                                labelStyle: TextStyle(color: Colors.grey, fontSize: 12),
                                floatingLabelBehavior: FloatingLabelBehavior.auto,
                                suffixIcon: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                      icon: Icon(
                                        passwordEye ? Icons.visibility_off : Icons.visibility,
                                        color: Colors.grey,
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          passwordEye = !passwordEye;
                                        });
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: 80),
                      Center(
                        child: Text(
                          'Indem Sie auf „Weiter“ klicken, stimmen Sie unseren Allgemeinen Geschäftsbedingungen und Datenschutzbestimmungen zu',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Color(0xED000000),
                              fontSize: 12,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                      SizedBox(height: 30),

                      Obx(() => GestureDetector(
                        onTap: controller.isLoading.value
                            ? null
                            : () {
                          if (controller.emailController.text.trim().isEmpty ||
                              controller.passwordController.text.trim().isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text("Bitte geben Sie sowohl E-Mail als auch Passwort ein."),
                                backgroundColor: Colors.red,
                              ),
                            );
                          } else {
                            controller.registerUser(context);
                          }
                        },
                        child: Container(
                          width: double.infinity,
                          height: 50,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Color(0xff2147a9),
                            border: Border.all(
                              color: Color(0xff2147a9),
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: controller.isLoading.value
                              ? SizedBox(
                            width: 24,
                            height: 24,
                            child: CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                              strokeWidth: 2.5,
                            ),
                          )
                              : Text(
                            "Sich Inmelden",
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ))





                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
