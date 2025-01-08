import 'package:divinitaion/Models/fortune_list.dart';
import 'package:divinitaion/Page/Client/answered_fortune_page.dart';
import 'package:divinitaion/Page/Common/backround_container.dart';
import 'package:divinitaion/Services/service.dart';
import 'package:divinitaion/Widgets/ClientWidgets/fortune_card.dart';
import 'package:flutter/material.dart';

class FortuneList extends StatefulWidget {
  @override
  _FortuneListState createState() => _FortuneListState();
}

class _FortuneListState extends State<FortuneList> with SingleTickerProviderStateMixin {
  final ApiService _apiService = ApiService();
  late Future<List<FortuneListt>> _pendingFortunes;
  late Future<List<FortuneListt>> _pastFortunes;
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
    return BackgroundContainer(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          children: [
            TabBar(
              controller: _tabController,
              labelColor: const Color.fromARGB(202, 232, 162, 241),
              unselectedLabelColor: Colors.white,
              tabs: [
                Tab(text: 'Cevap Bekleyen Fallar'),
                Tab(text: 'Fallarım'),
              ],
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildFortuneList(_pendingFortunes, 'Cevap Bekleyen Fal bulunmamaktadır.', false),
                  _buildFortuneList(_pastFortunes, 'Geçmiş Fal bulunmamaktadır.', true),
                ],
              ),
            ),
          ],
        ),
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
          return Center(child: Text(emptyMessage, style: TextStyle(color: Colors.white)));
        }

        final fortunes = snapshot.data!;
        fortunes.sort((a, b) => b.createDate?.compareTo(a.createDate ?? DateTime.now()) ?? 0);

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
