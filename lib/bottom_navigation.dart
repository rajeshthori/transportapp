import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'active_screen.dart';
import 'cancel_screen.dart';
import 'ended_screen.dart';
import 'home_screen.dart';

class BottomNavigation extends StatefulWidget {
  @override
  _BottomNavigationState createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int _selectedIndex = 0;
  DateTime? _lastPressed;

  final List<Widget> _screens = [
    HomeScreen(),
    ActiveScreen(),
    CancelScreen(),
    EndedScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        body: _screens[_selectedIndex],
        bottomNavigationBar: Container(
          decoration: const BoxDecoration(
            color: Color(0xFFFFEDE1), // updated background color
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(0),
              topRight: Radius.circular(0),
            ),
          ),
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: _selectedIndex,
            selectedItemColor: Colors.blue,
            unselectedItemColor: Colors.grey,
            backgroundColor: Colors.transparent, // keep transparent to show Container's color
            elevation: 0, // optional: removes shadow for cleaner look
            onTap: (index) {
              setState(() {
                _selectedIndex = index;
              });
            },

            items: [
              BottomNavigationBarItem(
                icon: ColorFiltered(
                  colorFilter: ColorFilter.mode(
                    _selectedIndex == 0 ? Color(0xff2147a9) : Color(0x998b8b8b),
                    BlendMode.srcIn,
                  ),
                  child: Image.asset(
                    'assets/images/home_icon.png',
                    width: 24,
                    height: 24,
                  ),
                ),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: ColorFiltered(
                  colorFilter: ColorFilter.mode(
                    _selectedIndex == 1 ? Color(0xff2147a9) : Color(0x998b8b8b),
                    BlendMode.srcIn,
                  ),
                  child: Image.asset(
                    'assets/images/active_icon.png',
                    width: 24,
                    height: 24,
                  ),
                ),
                label: 'Active',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.cancel),
                label: 'Cancel',
              ),
              BottomNavigationBarItem(
                icon: ColorFiltered(
                  colorFilter: ColorFilter.mode(
                    _selectedIndex == 3 ? Color(0xff2147a9) : Color(0x998b8b8b),
                    BlendMode.srcIn,
                  ),
                  child: Image.asset(
                    'assets/images/ended_icon.png',
                    width: 24,
                    height: 24,
                  ),
                ),
                label: 'Ended',
              ),
            ],
          ),
        ),
      ),
    );

  }

  Future<bool> _onWillPop() async {
    final now = DateTime.now();
    if (_lastPressed == null || now.difference(_lastPressed!) > const Duration(seconds: 2)) {
      _lastPressed = now;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Press again to exit'), duration: Duration(seconds: 2)),
      );
      return false;
    }
    return true;
  }
}