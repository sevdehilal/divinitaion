import 'package:divinitaion/Page/Client/client_fortune_telling_page.dart';
import 'package:flutter/material.dart';

class CustomFortuneTellerCard extends StatelessWidget {
  final String firstName;
  final String lastName;

  CustomFortuneTellerCard({required this.firstName, required this.lastName});

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
            Row(children: [
              Text(
                firstName,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(width: 5),
              Text(
                lastName,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ]),
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
                SizedBox(width: 150),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => FortuneTellingPage(
                              firstName: firstName, lastName: lastName)),
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
