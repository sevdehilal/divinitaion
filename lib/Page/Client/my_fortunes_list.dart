// main.dart
import 'package:divinitaion/Models/fortune_entity.dart';
import 'package:divinitaion/Models/fortune_teller_entity.dart';
import 'package:divinitaion/Services/service.dart';
import 'package:divinitaion/Widgets/fortune_teller_card.dart';
import 'package:divinitaion/Widgets/fortune_card.dart';
import 'package:divinitaion/Widgets/logout_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class MyFortunesList extends StatefulWidget {
  @override
  _MyFortunesList createState() => _MyFortunesList();
}

class _MyFortunesList extends State<MyFortunesList> {
  final ApiService _apiService = ApiService();
  late Future<List<Fortune>> _fortuneList;
  final FlutterSecureStorage _secureStorage = FlutterSecureStorage();

  @override
  void initState() {
    super.initState();
    _fortuneList = _apiService.FetchFortunes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select FortuneTeller'),
        actions: [LogoutButton()],
      ),
      body: FutureBuilder<List<Fortune>>(
        future: _fortuneList,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No users found.'));
          }

          final fortuneTellers = snapshot.data!;

          return ListView.builder(
            itemCount: fortuneTellers.length,
            itemBuilder: (context, index) {
              final fortune = fortuneTellers[index];
              return FortuneCard(
                fortune: fortune, // Pass the entire FortuneTeller object
              );
            },
          );
        },
      ),
    );
  }
}
