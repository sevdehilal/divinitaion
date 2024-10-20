import 'package:divinitaion/Page/Client/client_fortune_teller_list.dart';
import 'package:divinitaion/Page/Client/client_profil_page.dart';
import 'package:flutter/material.dart';
import 'package:divinitaion/Models/register_client.dart';
// User modelinizi içe aktardığınızdan emin olun.
import 'package:divinitaion/Page/Common/fortune_categories_page.dart';

class CustomBottomNavigation extends StatefulWidget {
  @override
  _CustomBottomNavigationState createState() => _CustomBottomNavigationState();
}

class _CustomBottomNavigationState extends State<CustomBottomNavigation> {
  int _selectedIndex = 0;

  // Kullanıcı bilgilerini burada tanımlıyoruz
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

  // Sayfa listesini burada tanımlıyoruz
  List<Widget> get _pages => [
        FortuneCategoriesPage(), // Falcı listesi burada çağrılıyor
        Center(child: Text('Fallarım', style: TextStyle(fontSize: 24))),
        ClientProfilePage(
            user: currentUser), // currentUser'ı buraya geçiriyoruz
      ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex], // Sayfa listesini burada kullanıyoruz
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Anasayfa',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: 'Fallarım',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.man),
            label: 'Profil',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        onTap: _onItemTapped,
      ),
    );
  }
}
