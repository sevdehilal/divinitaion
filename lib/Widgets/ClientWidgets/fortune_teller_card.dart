import 'package:divinitaion/Models/fortune_teller_entity.dart';
import 'package:divinitaion/Page/Client/photo_selection_page.dart';
import 'package:divinitaion/Page/Client/reward_card_selection_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomFortuneTellerCard extends StatefulWidget {
  final FortuneTeller fortuneTeller;
  final int clientCredit;

  const CustomFortuneTellerCard({
    Key? key,
    required this.fortuneTeller,
    required this.clientCredit,
  }) : super(key: key);

  @override
  _CustomFortuneTellerCardState createState() =>
      _CustomFortuneTellerCardState();
}

class _CustomFortuneTellerCardState extends State<CustomFortuneTellerCard> {
  int? clientId;
  late int currentCredit;

  @override
  void initState() {
    super.initState();
    _loadClientId();
    currentCredit = widget.clientCredit;
  }

  Future<void> _loadClientId() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      clientId = prefs.getInt('id');
    });
  }

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
                  widget.fortuneTeller.firstName,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(width: 5),
                Text(
                  widget.fortuneTeller.lastName,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                const Icon(Icons.star, color: Colors.amber),
                const SizedBox(width: 2),
                Text(
                  "${widget.fortuneTeller.rating}",
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                const Icon(Icons.monetization_on, color: Colors.yellow),
                const SizedBox(width: 2),
                Text(
                  "${widget.fortuneTeller.requirementCredit}",
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
                const Spacer(),
                if (widget.fortuneTeller.requirementCredit != null &&
                    currentCredit < widget.fortuneTeller.requirementCredit!)
                  OutlinedButton(
                    onPressed: clientId == null
                        ? null
                        : () async {
                            final reward = 0;
                            // final reward = await Navigator.push<int>(
                            //   context,
                            //   MaterialPageRoute(
                            //     builder: (context) =>
                            //         RewardCardSelectionPage(clientId: clientId),
                            //   ),
                            // );

                            if (reward != null) {
                              setState(() {
                                currentCredit += reward;
                              });
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                      'Kazanılan ödül: $reward coin eklendi!'),
                                ),
                              );
                            }
                          },
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Colors.red),
                    ),
                    child: const Text(
                      'Coin Kazan',
                      style: TextStyle(color: Colors.red),
                    ),
                  )
                else
                  OutlinedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PhotoSelectionPage(
                            fortuneTeller: widget.fortuneTeller,
                          ),
                        ),
                      );
                    },
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Colors.white),
                    ),
                    child: const Text(
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
