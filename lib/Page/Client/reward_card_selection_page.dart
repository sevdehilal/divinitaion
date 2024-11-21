import 'package:flutter/material.dart';

class RewardCardSelectionPage extends StatefulWidget {
  final int? clientId;

  const RewardCardSelectionPage({Key? key, this.clientId}) : super(key: key);

  @override
  _RewardCardSelectionPageState createState() => _RewardCardSelectionPageState();
}

class _RewardCardSelectionPageState extends State<RewardCardSelectionPage> {
  int? selectedReward;
  List<int> rewards = [5, 10, 15, 20, 25, 30];

  bool isRevealed = false;
  bool isConfirmed =
      false;

  Future<void> _sendRewardToApi(int clientId, int reward) async {
    await Future.delayed(Duration(seconds: 2));
    print("Reward $reward sent to client $clientId");
  }

  void shuffleRewards() {
    rewards.shuffle();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kart Seçin'),
        backgroundColor: Colors.black,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Bir Kart Seç ve Coin Kazan!',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            GridView.builder(
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: 6,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: isRevealed || isConfirmed
                      ? null
                      : () {
                          setState(() {
                            shuffleRewards();
                            selectedReward = rewards[index];
                            isRevealed = true;
                          });
                        },
                  child: AnimatedContainer(
                    duration: const Duration(seconds: 1),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: isRevealed
                          ? Colors.white
                          : Colors.transparent,
                      image: isRevealed
                          ? null
                          : DecorationImage(
                              image: AssetImage('lib/assets/tarot_karti.jpg'),
                              fit: BoxFit.cover,
                            ),
                    ),
                    alignment: Alignment.center,
                    width: 150,
                    height: 80,
                    child: isRevealed
                        ? Text(
                            '${rewards[index]} Coin',
                            style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          )
                        : Container(),
                  ),
                );
              },
            ),
            if (isRevealed && selectedReward != null)
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Column(
                  children: [
                    Text(
                      '$selectedReward Coin Kazandınız!',
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        if (widget.clientId == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text("Client ID bulunamadı!")),
                          );
                          return;
                        }

                        await _sendRewardToApi(
                            widget.clientId!, selectedReward!);

                        Navigator.pop(context);
                      },
                      child: const Text('Ödülü Al'),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
