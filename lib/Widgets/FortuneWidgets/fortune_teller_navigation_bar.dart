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
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(0),
        child: AppBar(
          backgroundColor: Colors.black,
          elevation: 0,
        ),
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.black,
        ),
        child: BottomNavigationBar(
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(
                Icons.coffee,
                color: _selectedIndex == 0
                    ? const Color.fromARGB(158, 232, 162, 241)
                    : Colors.white,
              ),
              label: 'Bekleyen Fallar',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.coffee,
                color: _selectedIndex == 1
                    ? const Color.fromARGB(158, 232, 162, 241)
                    : Colors.white,
              ),
              label: 'Baktığım Fallar',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.person,
                color: _selectedIndex == 2
                    ? const Color.fromARGB(158, 232, 162, 241)
                    : Colors.white,
              ),
              label: 'Profil',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: const Color.fromARGB(158, 232, 162, 241),
          unselectedItemColor: Colors.white,
          onTap: _onItemTapped,
          backgroundColor: Colors.transparent,
        ),
      ),
    );
  }
}
