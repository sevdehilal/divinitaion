import 'package:divinitaion/Models/fortune_list.dart';
import 'package:divinitaion/Page/Client/answered_fortune_page.dart';
import 'package:divinitaion/Services/service.dart';
import 'package:divinitaion/Widgets/ClientWidgets/fortune_card.dart';
import 'package:divinitaion/Widgets/CommonWidgets/logout_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class FortuneList extends StatefulWidget {
  @override
  _FortuneListState createState() => _FortuneListState();
}

class _FortuneListState extends State<FortuneList> with SingleTickerProviderStateMixin {
  final ApiService _apiService = ApiService();
  late Future<List<FortuneListt>> _pendingFortunes;
  late Future<List<FortuneListt>> _pastFortunes;
  final FlutterSecureStorage _secureStorage = FlutterSecureStorage();
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _pendingFortunes = _apiService.fetchPendingFortunes();
    _pastFortunes = _apiService.fetchAnsweredFortunes();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fallarım',
          style: TextStyle(
                fontSize: 18,
                color: const Color.fromARGB(255, 255, 255, 255),
              ),
        ),
        actions: [LogoutButton()],
        backgroundColor: Color.fromARGB(255, 24, 18, 20),
        bottom: TabBar(
          controller: _tabController,
          labelColor: const Color.fromARGB(255, 224, 0, 253),
          unselectedLabelColor: Colors.white,
          tabs: [
            Tab(text: 'Cevap Bekleyen Fallar',),
            Tab(text: 'Fallarım'),
          ],
        ),
      ),
      backgroundColor: Color.fromARGB(255, 24, 18, 20),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildFortuneList(_pendingFortunes, 'Cevap Bekleyen Fallar yok.', false),
          _buildFortuneList(_pastFortunes, 'Geçmiş Fallar yok.', true),
        ],
      ),
    );
  }

  Widget _buildFortuneList(Future<List<FortuneListt>> futureList, String emptyMessage, bool isTappable) {
    return FutureBuilder<List<FortuneListt>>(
      future: futureList,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text(emptyMessage));
        }

        final fortunes = snapshot.data!;
        return ListView.builder(
          itemCount: fortunes.length,
          itemBuilder: (context, index) {
            final fortune = fortunes[index];
            return FortuneCard(
              fortune: fortune,
              isTappable: isTappable,
              onTap: isTappable
                  ? () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => FortuneAnswerPage(fortune: fortune),
                        ),
                      );
                    }
                  : null,
            );
          },
        );
      },
    );
  }
}
