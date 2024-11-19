import 'package:divinitaion/Models/fortune_teller_entity.dart';
import 'package:divinitaion/Page/Common/backround_container';
import 'package:divinitaion/Services/service.dart';
import 'package:divinitaion/Widgets/ClientWidgets/fortune_teller_card.dart';
import 'package:divinitaion/Widgets/CommonWidgets/logout_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ClientFortuneTellerList extends StatefulWidget {
  @override
  _ClientFortuneTellerListPageState createState() =>
      _ClientFortuneTellerListPageState();
}

class _ClientFortuneTellerListPageState extends State<ClientFortuneTellerList> {
  final ApiService _apiService = ApiService();
  late Future<List<FortuneTeller>> _userList;
  final FlutterSecureStorage _secureStorage = FlutterSecureStorage();

  @override
  void initState() {
    super.initState();
    _userList = _apiService.FetchFortuneTeller();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true, // Arka planın App Bar'ın arkasına geçmesi için.
      appBar: AppBar(
        title: Text(
          'Falcı Seçimi',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: const Color.fromARGB(255, 255, 255, 255),
          ),
        ),
        actions: [LogoutButton()],
        backgroundColor: Colors.transparent, // App Bar'ı şeffaf yapar.
        elevation: 0,
      ),
      body: BackgroundContainer(
        child: FutureBuilder<List<FortuneTeller>>(
          future: _userList,
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
                final fortuneTeller = fortuneTellers[index];
                return CustomFortuneTellerCard(
                  fortuneTeller: fortuneTeller,
                );
              },
            );
          },
        ),
      ),
    );
  }
}
