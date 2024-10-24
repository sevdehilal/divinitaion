import 'package:divinitaion/Models/fortune_model_for_fortune_teller.dart';
import 'package:divinitaion/Page/FortuneTeller/answer_page.dart';
import 'package:divinitaion/Services/service.dart';
import 'package:flutter/material.dart';

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
      appBar: AppBar(
        title: Text('Fortunes'),
      ),
      body: FutureBuilder<List<FortuneForFortuneTeller>>(
        future: _fortuneList,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No fortune tellers found.'));
          }

          final fortunes = snapshot.data!;

          return ListView.builder(
            itemCount: fortunes.length,
            itemBuilder: (context, index) {
              final fortune = fortunes[index];
              return ListTile(
                title: Text('${fortune.firstName} ${fortune.lastName}'),
                subtitle: Text(fortune.occupation!),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AnswerPage(fortune: fortune),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
