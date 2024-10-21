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
        title: Text('Falcı Bilgileri'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Falcı adı ve puanı
            Text(
              '${widget.firstName} ${widget.lastName} adlı falcıya fal baktırılacak.',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'Falcı Puanı: 4.5/5',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),

            // Merak ettiğin konular
            Text(
              'Merak Ettiğin Konular:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),

            // FortuneCategoriesDropdown 1
            FortuneCategoriesDropdown(
              onChanged: (int? newValue) {
                setState(() {
                  selectedTopic1 = newValue; // İlk seçilen konuyu güncelle
                });
              },
            ),
            SizedBox(height: 8),

            // FortuneCategoriesDropdown 2
            FortuneCategoriesDropdown(
              onChanged: (int? newValue) {
                setState(() {
                  selectedTopic2 = newValue; // İkinci seçilen konuyu güncelle
                });
              },
            ),

            // Fotoğraflar
            Text(
              'Fotoğraflar:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
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
            SizedBox(
                height: 20), // Buton ile diğer içerikler arasında biraz boşluk

            // Gönder butonu
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
                  padding: EdgeInsets.symmetric(
                      horizontal: 30,
                      vertical: 15), // Butonun boyutunu ayarlamak için
                  textStyle: TextStyle(
                      fontSize: 20), // Butonun yazı boyutunu ayarlamak için
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
