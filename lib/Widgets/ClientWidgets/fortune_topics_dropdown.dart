import 'package:flutter/material.dart';
import 'package:divinitaion/Models/fortune_topic.dart';
import 'package:divinitaion/Services/service.dart';

class FortuneTopicsDropdown extends StatefulWidget {
  final Function(int?) onChanged;

  FortuneTopicsDropdown({required this.onChanged});

  @override
  _FortuneTopicsDropdownState createState() => _FortuneTopicsDropdownState();
}

class _FortuneTopicsDropdownState extends State<FortuneTopicsDropdown> {
  final ApiService _apiService = ApiService();
  late Future<List<FortuneTopic>> _topics;
  int? _selectedTopicId;

  @override
  void initState() {
    super.initState();
    _topics = _apiService.fetchFortuneTopics();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<FortuneTopic>>(
      future: _topics,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Hata: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text('Konu bulunamadı.'));
        }

        List<FortuneTopic> topics = snapshot.data!;
        return DropdownButton<int>(
          value: _selectedTopicId,
          hint: Text(
            'Bir konu seçin',
            style: TextStyle(color: Colors.white),
          ),
          onChanged: (int? newValue) {
            setState(() {
              _selectedTopicId = newValue;
              widget.onChanged(newValue);
            });
          },
          dropdownColor: Colors.black,
          style: TextStyle(color: Colors.white),
          items: topics.map<DropdownMenuItem<int>>((FortuneTopic topic) {
            return DropdownMenuItem<int>(
              value: topic.id,
              child: Text(
                topic.categoryName,
                style: TextStyle(color: Colors.white),
              ),
            );
          }).toList(),
        );
      },
    );
  }
}
