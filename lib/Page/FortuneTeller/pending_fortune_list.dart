import 'package:flutter/material.dart';
import 'package:divinitaion/Models/fortune_model_for_fortune_teller.dart';
import 'package:divinitaion/Page/FortuneTeller/answer_page.dart';
import 'package:divinitaion/Services/service.dart';
import 'package:divinitaion/Widgets/fortune_card_for_fortune_teller.dart';

class PendingFortuneList extends StatefulWidget {
  @override
  _PendingFortuneListState createState() => _PendingFortuneListState();
}

class _PendingFortuneListState extends State<PendingFortuneList> {
  final ApiService _apiService = ApiService();
  late Future<List<FortuneForFortuneTeller>> _fortuneList;

  @override
  void initState() {
    super.initState();
    _fortuneList = _apiService.FetchFortunesByFortuneTellerId();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder<List<FortuneForFortuneTeller>>(
        future: _fortuneList,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No pending fortunes found.'));
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
    );
  }
}
