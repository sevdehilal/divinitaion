import 'package:divinitaion/Models/fortune_entity.dart';
import 'package:divinitaion/Services/service.dart';
import 'package:divinitaion/Widgets/fortune_card.dart';
import 'package:divinitaion/Widgets/logout_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class FortuneList extends StatefulWidget {
  @override
  _FortuneListState createState() =>_FortuneListState();
}

class _FortuneListState extends State<FortuneList> {
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
        title: Text('Fallarım'),
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

          final fortunes = snapshot.data!;

          return ListView.builder(
            itemCount: fortunes.length,
            itemBuilder: (context, index) {
              final fortune = fortunes[index];
              return FortuneCard(
                fortune: fortune,
              );
            },
          );
        },
      ),
    );
  }
}
