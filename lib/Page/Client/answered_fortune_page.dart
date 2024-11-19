import 'package:divinitaion/Models/fortune_list.dart';
import 'package:divinitaion/Page/Common/backround_container';
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
      extendBodyBehindAppBar: true, // Arka planın AppBar ile birleşmesi için.
      appBar: AppBar(
        title: const Text(
          'Fal Cevabın...',
          style: TextStyle(
            fontSize: 18,
            color: Color.fromARGB(255, 255, 255, 255),
          ),
        ),
        backgroundColor: Colors.transparent, // AppBar'ı transparan yapar.
        elevation: 0,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.black.withOpacity(0.6), // Gradient başı
                Colors.transparent, // Gradient sonu
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
      ),
      body: BackgroundContainer(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.6),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Text(
                  'Kategoriler: ${widget.fortune.categories?.join(', ') ?? ''}',
                  style: const TextStyle(
                    fontSize: 16,
                    color: Color.fromARGB(255, 255, 255, 255),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.6),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Text(
                  'Oluşturma Tarihi: ${widget.fortune.createDate}',
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color.fromARGB(255, 255, 255, 255),
                  ),
                ),
              ),
              const SizedBox(height: 6),
              const Divider(color: Colors.grey),
              Container(
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.6),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Text(
                  widget.fortune.answer ?? 'No answer provided.',
                  style: const TextStyle(
                    fontSize: 14,
                    color: Color.fromARGB(255, 255, 255, 255),
                  ),
                ),
              ),
              const Spacer(),
              Center(
                child: Container(
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.6),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: const Text(
                    'Bu falı puanlamak ister misin?',
                    style: TextStyle(
                      fontSize: 14,
                      color: Color.fromARGB(255, 255, 255, 255),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
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
      ),
    );
  }
}
