import 'package:divinitaion/Models/fortune_teller_entity.dart';
import 'package:divinitaion/Page/Client/photo_selection_page.dart';
import 'package:flutter/material.dart';

class CustomFortuneTellerCard extends StatelessWidget {
  final FortuneTeller fortuneTeller;

  CustomFortuneTellerCard({required this.fortuneTeller});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  fortuneTeller.firstName,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(width: 5),
                Text(
                  fortuneTeller.lastName,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Icon(Icons.star, color: Colors.amber),
                SizedBox(width: 5),
                Text(
                  '0 Puan',
                  style: TextStyle(fontSize: 18),
                ),
              ],
            ),
            Row(
              children: [
                Icon(Icons.monetization_on, color: Colors.yellow),
                SizedBox(width: 5),
                Text(
                  '0 Altın',
                  style: TextStyle(fontSize: 18),
                ),
                Spacer(),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PhotoSelectionPage(fortuneTeller: fortuneTeller,),
                      ),
                    );
                  },
                  child: Text('Fal Baktır'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
