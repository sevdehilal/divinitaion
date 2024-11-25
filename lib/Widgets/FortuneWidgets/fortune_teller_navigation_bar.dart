import 'package:divinitaion/Page/Client/CustomScaffold.dart';
import 'package:divinitaion/Page/FortuneTeller/answered_fortune_list.dart';
import 'package:divinitaion/Page/FortuneTeller/fortune_teller_profile_page.dart';
import 'package:divinitaion/Page/FortuneTeller/pending_fortune_list.dart';
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
    return CustomScaffold(
      appBar: AppBar(
        backgroundColor: Colors.black.withOpacity(0.2),
        elevation: 0,
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.2), // Hafif transparan arka plan
        ),
        child: BottomNavigationBar(
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
              icon: Icon(Icons.person, color: Colors.white),
              label: 'Profil',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: const Color.fromARGB(255, 255, 0, 0),
          unselectedItemColor: Colors.white,
          onTap: _onItemTapped,
          backgroundColor: Colors.transparent, // Şeffaf alt çubuk
        ),
      ),
    );
  }
}
