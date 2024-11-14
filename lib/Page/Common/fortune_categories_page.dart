import 'package:divinitaion/Widgets/CommonWidgets/logout_button.dart';
import 'package:flutter/material.dart';
import 'package:divinitaion/Page/Client/fortune_teller_list.dart';

class FortuneCategoriesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fortune Categories', 
          style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: const Color.fromARGB(255, 255, 255, 255),
              ),
            ),
        backgroundColor: Color.fromARGB(255, 24, 18, 20),
        actions: [LogoutButton()],
      ),
      backgroundColor: Color.fromARGB(255, 24, 18, 20),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Hemen Yeni Bir Fal Baktır !',
              style: TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.w600,
                color: const Color.fromARGB(255, 255, 255, 255),
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _imageCardButton(
                    context, 'lib/assets/kahvefali.png', 'Kahve Falı'),
                _imageCardButton(context, 'lib/assets/hand.png', 'El Falı'),
              ],
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _imageCardButton(
                    context, 'lib/assets/dharita.png', 'Doğum Haritası'),
                _imageCardButton(context, 'lib/assets/tarot.png', 'Tarot Falı'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _imageCardButton(
      BuildContext context, String imagePath, String fortuneName) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                ClientFortuneTellerList(),
          ),
        );
      },
      child: Column(
        children: [
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0),
            ),
            elevation: 5,
            child: Container(
              width: 140,
              height: 140,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 140,
                    height: 140,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(imagePath),
                        fit: BoxFit.fill,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 8),
          Text(
            fortuneName,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: const Color.fromARGB(255, 255, 255, 255),
            ),
          ),
        ],
      ),
    );
  }
}
