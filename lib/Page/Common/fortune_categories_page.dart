import 'package:flutter/material.dart';
import 'package:divinitaion/Page/Client/client_fortune_teller_list.dart'; // Falcı listesi için gerekli import

class FortuneCategoriesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'fortune categories',
          style: TextStyle(
            color: Colors.white,

            fontSize: 24, // Yazı boyutunu artırdık
            fontWeight: FontWeight.normal, // Yazı kalınlığı
          ),
        ),
        centerTitle: true,
        backgroundColor:
            const Color.fromARGB(255, 70, 70, 68), // AppBar arka plan rengi
        elevation: 4,
        // Gölge efekti
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 0),
            // Yeni eklenen "Hemen Yeni Bir Fal Baktır" yazısı
            Text(
              'Hemen Yeni Bir Fal Baktır',
              style: TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.w600,
                color: const Color.fromARGB(255, 45, 48, 51),
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 90), // Yazı ile resim butonları arasında boşluk
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _imageCardButton(context, 'assets/resim1.jpg', ''),
                _imageCardButton(context, 'assets/resim2.jpg', ''),
              ],
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _imageCardButton(context, 'assets/resim3.jpg', ''),
                _imageCardButton(context, 'assets/resim4.jpg', ''),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Kart şeklinde resim buton fonksiyonu
  Widget _imageCardButton(
      BuildContext context, String imagePath, String title) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                ClientFortuneTellerList(), // Falcı listesine yönlendirme
          ),
        );
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
        elevation: 5,
        child: Container(
          width: 140, // Sabit genişlik
          height: 140, // Sabit yükseklik
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 120,
                height: 100,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(imagePath),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              SizedBox(height: 8),
              Text(
                title,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
