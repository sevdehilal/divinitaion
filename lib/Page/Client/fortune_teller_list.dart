import 'package:divinitaion/Models/fortune_teller_entity.dart';
import 'package:divinitaion/Page/Common/backround_container.dart';
import 'package:divinitaion/Services/service.dart';
import 'package:divinitaion/Widgets/ClientWidgets/fortune_teller_card.dart';
import 'package:divinitaion/Widgets/CommonWidgets/logout_button.dart';
import 'package:flutter/material.dart';

class ClientFortuneTellerList extends StatefulWidget {
  @override
  _ClientFortuneTellerListPageState createState() =>
      _ClientFortuneTellerListPageState();
}

class _ClientFortuneTellerListPageState
    extends State<ClientFortuneTellerList> {
  final ApiService _apiService = ApiService();
  late Future<List<FortuneTeller>> _userList;
  late Future<int> _clientCreditFuture;
  List<FortuneTeller> _filteredFortuneTellers = [];
  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _userList = _apiService.FetchFortuneTeller();
    _clientCreditFuture = _apiService.fetchClientCreditByClientId();

    _userList.then((fortuneTellers) {
      setState(() {
        _filteredFortuneTellers = fortuneTellers;
      });
    });

    _searchController.addListener(_filterFortuneTellers);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _filterFortuneTellers() {
    final query = _searchController.text.toLowerCase();

    _userList.then((fortuneTellers) {
      setState(() {
        _filteredFortuneTellers = fortuneTellers
            .where((ft) =>
                ft.firstName.toLowerCase().contains(query) ||
                ft.lastName.toLowerCase().contains(query))
            .toList();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(
          'Falcı Seçimi',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        actions: [
          FutureBuilder<int>(
            future: _clientCreditFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Center(
                    child: SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    ),
                  ),
                );
              } else if (snapshot.hasError || !snapshot.hasData) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Icon(
                    Icons.error,
                    color: Colors.red,
                  ),
                );
              }

              final clientCredit = snapshot.data!;
              return Row(
                children: [
                  Text(
                    clientCredit.toString(),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(width: 4),
                  Icon(
                    Icons.monetization_on,
                    color: Colors.yellow,
                  ),
                ],
              );
            },
          ),
          LogoutButton(),
        ],
        backgroundColor: Colors.transparent,
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(60),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: 'Falcı Ara',
                hintStyle: TextStyle(color: Colors.white54),
                prefixIcon: Icon(Icons.search, color: Colors.white),
                filled: true,
                fillColor: Colors.black.withOpacity(0.5),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
        ),
      ),
      body: BackgroundContainer(
        child: Column(
          children: [
            Expanded(
              child: FutureBuilder<List<FortuneTeller>>(
                future: _userList,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (_filteredFortuneTellers.isEmpty) {
                    return Center(child: Text('Arama sonuçları bulunamadı.'));
                  }

                  return ListView.builder(
                    itemCount: _filteredFortuneTellers.length,
                    itemBuilder: (context, index) {
                      final fortuneTeller = _filteredFortuneTellers[index];
                      return FutureBuilder<int>(
                        future: _clientCreditFuture,
                        builder: (context, clientSnapshot) {
                          if (clientSnapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(child: CircularProgressIndicator());
                          } else if (clientSnapshot.hasError ||
                              !clientSnapshot.hasData) {
                            return Center(
                                child:
                                    Text('Error: ${clientSnapshot.error}'));
                          }

                          final clientCredit = clientSnapshot.data!;

                          return CustomFortuneTellerCard(
                            fortuneTeller: fortuneTeller,
                            clientCredit: clientCredit,
                          );
                        },
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
