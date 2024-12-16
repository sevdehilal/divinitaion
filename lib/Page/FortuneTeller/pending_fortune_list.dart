import 'package:divinitaion/Page/Common/backround_container.dart';
import 'package:divinitaion/Widgets/CommonWidgets/logout_button.dart';
import 'package:divinitaion/Widgets/FortuneWidgets/fortune_card_for_fortune_teller.dart';
import 'package:flutter/material.dart';
import 'package:divinitaion/Models/fortune_model_for_fortune_teller.dart';
import 'package:divinitaion/Page/FortuneTeller/answer_page.dart';
import 'package:divinitaion/Services/service.dart';

class PendingFortuneList extends StatefulWidget {
  @override
  _PendingFortuneListState createState() => _PendingFortuneListState();
}

class _PendingFortuneListState extends State<PendingFortuneList> {
  final ApiService _apiService = ApiService();
  late Future<List<FortuneForFortuneTeller>> _pendingFortuneList;

  @override
  void initState() {
    super.initState();
    _pendingFortuneList = _apiService.FetchPendingFortunesByFortuneTellerId();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.black.withOpacity(0.2),
        elevation: 0,
        title: Text(
          'Bekleyen Fallar',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: LogoutButton(),
          ),
        ],   
      ),
      body: BackgroundContainer(
        child: FutureBuilder<List<FortuneForFortuneTeller>>(
          future: _pendingFortuneList,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(
                child: Text(
                  'Bekleyen fal bulunmamaktadır.',
                  style: TextStyle(color: Colors.white),
                ),
              );
            }

            final fortunes = snapshot.data!;

            return ListView.builder(
              itemCount: fortunes.length,
              itemBuilder: (context, index) {
                final fortune = fortunes[index];

                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AnswerPage(fortune: fortune),
                      ),
                    );
                  },
                  child: FortuneCardForFortuneTeller(
                    fortune: fortune,
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
