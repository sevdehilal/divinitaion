import 'package:flutter/material.dart';
import 'package:divinitaion/Models/fortune_model_for_fortune_teller.dart';
import 'package:divinitaion/Page/FortuneTeller/answer_page.dart';
import 'package:divinitaion/Services/service.dart';
import 'package:divinitaion/Widgets/FortuneWidgets/fortune_card_for_fortune_teller.dart';

class AnsweredFortuneList extends StatefulWidget {
  @override
  _AnsweredFortuneListState createState() => _AnsweredFortuneListState();
}

class _AnsweredFortuneListState extends State<AnsweredFortuneList> {
  final ApiService _apiService = ApiService();
  late Future<List<FortuneForFortuneTeller>> _answeredFortuneList;

  @override
  void initState() {
    super.initState();
    _answeredFortuneList = _apiService.FetchAnsweredFortunesByFortuneTellerId();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color:
            Color.fromARGB(103, 57, 2, 60),
        child: FutureBuilder<List<FortuneForFortuneTeller>>(
          future: _answeredFortuneList,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(
                  child: Text('No answered fortunes found.',
                      style: TextStyle(
                          color: Colors.white)));
            }

            final fortunes = snapshot.data!;

            fortunes.sort((a, b) {
              if (a.createDate == null || b.createDate == null) {
                return 0;
              }
              return b.createDate!.compareTo(a.createDate!);
            });
            
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
