import 'package:flutter/material.dart';

class FortuneCard extends StatefulWidget {
  final String fortuneType;
  final String fortuneTeller;
  final String userName;
  final String date;

  const FortuneCard({
    Key? key,
    required this.fortuneType,
    required this.fortuneTeller,
    required this.userName,
    required this.date,
  }) : super(key: key);

  @override
  _FortuneCardState createState() => _FortuneCardState();
}

class _FortuneCardState extends State<FortuneCard> {
  bool isChecked = false;
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'fortunes',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24, // Yazı boyutunu artırdık
            fontWeight: FontWeight.normal, // Yazı kalınlığı
          ),
        ),
        centerTitle: true,
        backgroundColor:
            const Color.fromARGB(255, 70, 70, 68), // AppBar arka plan rengi
        elevation: 4, // Gölge efekti
      ),
      body: Padding(
        padding: const EdgeInsets.all(7.0),
        child: SizedBox(
          height: 150,
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0),
            ),
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                crossAxisAlignment:
                    CrossAxisAlignment.center, // Dikeyde ortalıyoruz
                children: [
                  Icon(
                    Icons.coffee,
                    size: 50,
                  ),
                  SizedBox(width: 25),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment:
                          MainAxisAlignment.center, // Dikeyde ortalamak için
                      children: [
                        Text(
                          widget.fortuneType,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text('Falcı: ${widget.fortuneTeller}'),
                        Text('İsim: ${widget.userName}'),
                        Text('Tarih: ${widget.date}'),
                      ],
                    ),
                  ),
                  Column(
                    mainAxisAlignment:
                        MainAxisAlignment.center, // Dikeyde ortalamak için
                    children: [
                      IconButton(
                        icon: Icon(
                          isChecked
                              ? Icons.check_box
                              : Icons.check_box_outline_blank,
                          size: 24,
                        ),
                        onPressed: () {
                          setState(() {
                            isChecked =
                                !isChecked; // Check ikonunu değiştiriyoruz
                          });
                        },
                      ),
                      SizedBox(height: 8),
                      IconButton(
                        icon: Icon(
                          isFavorite ? Icons.favorite : Icons.favorite_border,
                          size: 24,
                        ),
                        onPressed: () {
                          setState(() {
                            isFavorite =
                                !isFavorite; // Favori ikonunu değiştiriyoruz
                          });
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
