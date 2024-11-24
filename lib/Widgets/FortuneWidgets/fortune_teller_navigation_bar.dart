import 'package:divinitaion/Page/FortuneTeller/answered_fortune_list.dart';
import 'package:divinitaion/Page/FortuneTeller/fortune_teller_profile_page.dart';
import 'package:divinitaion/Page/FortuneTeller/pending_fortune_list.dart';
import 'package:divinitaion/Widgets/CommonWidgets/logout_button.dart';
import 'package:flutter/material.dart';

class FortuneTellerBottomNavigation extends StatefulWidget {
  @override
  _FortuneTellerBottomNavigationState createState() =>
      _FortuneTellerBottomNavigationState();
}

class _FortuneTellerBottomNavigationState
    extends State<FortuneTellerBottomNavigation> {
  int _selectedIndex = 0;

  static List<Widget> _pages = <Widget>[
    PendingFortuneList(),
    AnsweredFortuneList(),
    FortuneTellerProfilePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Fortune Teller',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Color.fromARGB(255, 24, 18, 20),
        actions: [LogoutButton()],
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.coffee, color: Colors.white),
            label: 'Bekleyen Fallar',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.coffee, color: Colors.white),
            label: 'Baktığım Fallar',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.man, color: Colors.white),
            label: 'Profil',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.white,
        onTap: _onItemTapped,
        backgroundColor: Color.fromARGB(255, 24, 18, 20),
      ),
      backgroundColor: Color.fromARGB(255, 24, 18, 20),
    );
  }
}
