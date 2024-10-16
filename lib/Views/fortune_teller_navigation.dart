
import 'package:flutter/material.dart';

class FortuneTellerBottomNavigation extends StatefulWidget {
  @override
  _FortuneTellerBottomNavigationState createState() => _FortuneTellerBottomNavigationState();
}

class _FortuneTellerBottomNavigationState extends State<FortuneTellerBottomNavigation> {
  int _selectedIndex = 0;

  static List<Widget> _pages = <Widget>[
    Center(child: Text('Bekleyen Fallar', style: TextStyle(fontSize: 24))),
    Center(child: Text('Profil', style: TextStyle(fontSize: 24))),
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
            icon: Icon(Icons.star),
            label: 'Bekleyen Fallar',
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
