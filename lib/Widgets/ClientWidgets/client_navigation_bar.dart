import 'package:divinitaion/Models/register_client.dart';
import 'package:divinitaion/Page/Client/CustomScaffold';
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

  final User currentUser = User(
    firstName: 'Sevde Hilal',
    lastName: 'Durak',
    gender: 'Kadın',
    dateOfBirth: DateTime(1990, 1, 1),
    occupation: 'Öğrenci',
    maritalStatus: 'Single',
    userName: 'sevdehilal',
    email: 'sevdehilald@gmail.com',
    password: 'Sevdehilal.02',
  );

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
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home, color: Colors.white),
              label: 'Anasayfa',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.coffee, color: Colors.white),
              label: 'Fallarım',
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
          backgroundColor: Colors.transparent,
        ),
      ),
      body: _pages[_selectedIndex],
    );
  }
}
