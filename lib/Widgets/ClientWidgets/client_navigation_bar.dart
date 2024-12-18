import 'package:divinitaion/Page/Client/CustomScaffold.dart';
import 'package:divinitaion/Page/Client/client_profil_page.dart';
import 'package:divinitaion/Page/Client/fortune_list.dart';
import 'package:divinitaion/Page/Common/fortune_categories_page.dart';
import 'package:flutter/material.dart';

class CustomBottomNavigation extends StatefulWidget {
  @override
  _CustomBottomNavigationState createState() => _CustomBottomNavigationState();
}

class _CustomBottomNavigationState extends State<CustomBottomNavigation> {
  int _selectedIndex = 0;

  List<Widget> get _pages => [
        FortuneCategoriesPage(),
        FortuneList(),
        ClientProfilePage(),
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
          backgroundColor: Colors.black.withOpacity(0.2),
          elevation: 0,
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.2),
        ),
        child: BottomNavigationBar(
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                color: _selectedIndex == 0
                    ? const Color.fromARGB(158, 232, 162, 241) 
                    : Colors.white, 
              ),
              label: 'Anasayfa',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.coffee,
                color: _selectedIndex == 1
                    ? const Color.fromARGB(158, 232, 162, 241)
                    : Colors.white,
              ),
              label: 'Fallarım',
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
      body: _pages[_selectedIndex],
    );
  }
}
