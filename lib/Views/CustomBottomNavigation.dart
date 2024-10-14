import 'package:divinitaion/Views/CustomFortuneTellerList.dart';
import 'package:flutter/material.dart';

class CustomBottomNavigation extends StatefulWidget {
  @override
  _CustomBottomNavigationState createState() => _CustomBottomNavigationState();
}

class _CustomBottomNavigationState extends State<CustomBottomNavigation> {
  int _selectedIndex = 0;
/*
  static List<Widget> _pages = <Widget>[
    Center(child: Text('Ana Sayfa', style: TextStyle(fontSize: 24))),
    Center(child: Text('Fallarım', style: TextStyle(fontSize: 24))),
    Center(child: Text('Diğer', style: TextStyle(fontSize: 24))),
  ];
  */

  static List<Widget> _pages = <Widget>[
      CustomFortuneTellerList(), // Falcı listesi burada çağrılıyor
      Center(child: Text('Fallarım', style: TextStyle(fontSize: 24))),
      Center(child: Text('Diğer', style: TextStyle(fontSize: 24))),
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
        title: Text('Bottom Navigation Bar Örneği'),
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Falcılar',
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