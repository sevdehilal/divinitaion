import 'package:divinitaion/Models/fortune_list.dart';
import 'package:flutter/material.dart';

class FortuneAnswerPage extends StatefulWidget {
  final FortuneListt fortune;

  const FortuneAnswerPage({Key? key, required this.fortune}) : super(key: key);

  @override
  _FortuneAnswerPageState createState() => _FortuneAnswerPageState();
}

class _FortuneAnswerPageState extends State<FortuneAnswerPage> {
  int _currentRating = 0;

  void _updateRating(int rating) {
    setState(() {
      _currentRating = rating;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Fal Cevabın...',
          style: TextStyle(
            fontSize: 18,
            color: Color.fromARGB(255, 255, 255, 255),
          ),
        ),
        backgroundColor: Color.fromARGB(255, 24, 18, 20),
      ),
      backgroundColor: Color.fromARGB(255, 24, 18, 20),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Kategoriler: ${widget.fortune.categories?.join(', ') ?? ''}',
              style: const TextStyle(
                fontSize: 16,
                color: Color.fromARGB(255, 138, 138, 138),
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Oluşturma Tarihi: ${widget.fortune.createDate}',
              style: TextStyle(
                fontSize: 12,
                color: const Color.fromARGB(255, 138, 138, 138),
              ),
            ),
            const SizedBox(height: 6),
            const Divider(),
            Text(
              widget.fortune.answer ?? 'No answer provided.',
              style: const TextStyle(
                fontSize: 14,
                color: Color.fromARGB(255, 255, 255, 255),
              ),
            ),
            const Spacer(),
            Center(
              child: Text(
                'Bu falı puanlamak ister misin?',
                style: const TextStyle(
                  fontSize: 14,
                  color: Color.fromARGB(255, 255, 255, 255),
                ),
              ),
            ),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(5, (index) {
                  return IconButton(
                    icon: Icon(
                      Icons.star,
                      color: index < _currentRating ? Colors.yellow : Colors.grey,
                    ),
                    onPressed: () => _updateRating(index + 1),
                  );
                }),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
