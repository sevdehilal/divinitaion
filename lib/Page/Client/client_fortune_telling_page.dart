import 'package:divinitaion/Page/Client/client_fortune_teller_list.dart';
import 'package:divinitaion/Page/Common/fortune_categories_page.dart';
import 'package:divinitaion/Page/Common/welcome.dart';
import 'package:divinitaion/Widgets/client_button_navigation.dart';
import 'package:divinitaion/Widgets/fortune_card.dart';
import 'package:divinitaion/Widgets/fortune_categories_dropdown.dart';
import 'package:flutter/material.dart';

class FortuneTellingPage extends StatefulWidget {
  final String firstName;
  final String lastName;

  FortuneTellingPage({required this.firstName, required this.lastName});

  @override
  _FortuneTellingPageState createState() => _FortuneTellingPageState();
}

class _FortuneTellingPageState extends State<FortuneTellingPage> {
  int? selectedTopic1;
  int? selectedTopic2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Falcı',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            // Falcı Kartı
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundImage: NetworkImage(
                          'https://via.placeholder.com/100'), // Dummy image
                    ),
                    SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${widget.firstName} ${widget.lastName}",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        Row(
                          children: [
                            Text('4.2', style: TextStyle(fontSize: 16)),
                            Icon(Icons.star, color: Colors.amber),
                            Icon(Icons.star, color: Colors.amber),
                            Icon(Icons.star, color: Colors.amber),
                            Icon(Icons.star, color: Colors.amber),
                            Icon(Icons.star_half, color: Colors.amber),
                          ],
                        ),
                      ],
                    ),
                    Spacer(),
                    Icon(Icons.arrow_forward_ios),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Merak Ettiğin Konular ?',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),

            // Merak Ettiğin Konular Kartı
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 8),

                    // FortuneCategoriesDropdown 1
                    FortuneCategoriesDropdown(
                      onChanged: (int? newValue) {
                        setState(() {
                          selectedTopic1 =
                              newValue; // İlk seçilen konuyu güncelle
                        });
                      },
                    ),
                    SizedBox(height: 8),

                    // FortuneCategoriesDropdown 2
                    FortuneCategoriesDropdown(
                      onChanged: (int? newValue) {
                        setState(() {
                          selectedTopic2 =
                              newValue; // İkinci seçilen konuyu güncelle
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Fotoğraflar',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),

            // Fotoğraflar Kartı
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Image.network(
                          'https://via.placeholder.com/100',
                          width: 100,
                          height: 100,
                        ),
                        Image.network(
                          'https://via.placeholder.com/100',
                          width: 100,
                          height: 100,
                        ),
                        Image.network(
                          'https://via.placeholder.com/100',
                          width: 100,
                          height: 100,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 30),

            // Gönder Butonu
            Center(
              child: ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Fal gönderildi!')),
                  );
                  Future.delayed(Duration(seconds: 1), () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CustomBottomNavigation(),
                      ),
                    );
                  });
                },
                child: Text('Gönder'),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  textStyle: TextStyle(fontSize: 20),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
