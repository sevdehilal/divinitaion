import 'package:divinitaion/Models/fortune_teller_entity.dart';
import 'package:divinitaion/Page/Client/photo_selection_page.dart';
import 'package:flutter/material.dart';

class CustomFortuneTellerCard extends StatelessWidget {
  final FortuneTeller fortuneTeller;
  final int clientCredit;

  CustomFortuneTellerCard({required this.fortuneTeller, required this.clientCredit});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      color: Colors.black.withOpacity(0.5),
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
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 255, 255, 255),
                  ),
                ),
                SizedBox(width: 5),
                Text(
                  fortuneTeller.lastName,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 255, 255, 255),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Icon(Icons.star, color: Colors.amber),
                SizedBox(width: 2),
                Text(
                  "${fortuneTeller.rating}",
                  style: TextStyle(fontSize: 16, color: Color.fromARGB(255, 255, 255, 255),),
                ),
              ],
            ),
            Row(
              children: [
                Icon(Icons.monetization_on, color: Colors.yellow),
                SizedBox(width: 2),
                Text(
                  "${fortuneTeller.requirementCredit}",
                  style: TextStyle(fontSize: 16, color: Color.fromARGB(255, 255, 255, 255),),
                ),
                Spacer(),
                if (fortuneTeller.requirementCredit != null && clientCredit < fortuneTeller.requirementCredit!)
                  OutlinedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              PhotoSelectionPage(fortuneTeller: fortuneTeller),
                        ),
                      );
                    },
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: const Color.fromARGB(255, 255, 0, 0)),
                    ),
                    child: Text(
                      'Coin Kazan',
                      style: TextStyle(color: const Color.fromARGB(255, 255, 0, 0)),
                    ),
                  )
                else
                  OutlinedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              PhotoSelectionPage(fortuneTeller: fortuneTeller),
                        ),
                      );
                    },
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: Colors.white),
                    ),
                    child: Text(
                      'Fal Baktır',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
