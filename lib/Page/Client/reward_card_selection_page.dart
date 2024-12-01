import 'package:divinitaion/Services/service.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class RewardCardSelectionPage extends StatefulWidget {
  final int? clientId;

  const RewardCardSelectionPage({Key? key, this.clientId}) : super(key: key);

  @override
  _RewardCardSelectionPageState createState() =>
      _RewardCardSelectionPageState();
}

class _RewardCardSelectionPageState extends State<RewardCardSelectionPage> {
  final ApiService _apiService = ApiService();
  int? selectedReward;
  List<int> rewards = [5, 10, 15, 20, 25, 30];

  bool isRevealed = false;
  bool isConfirmed = false;
  bool isAdLoaded = false;
  late RewardedAd _rewardedAd;  // Ödüllü reklam

  // Reklamı yüklemek için fonksiyon
  Future<void> _loadAd() async {
    RewardedAd.load(
      adUnitId: 'ca-app-pub-2442587495670415/3394104117', // Burada reklam birimi kimliğini kullanıyorsunuz
      request: AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (RewardedAd ad) {
          setState(() {
            _rewardedAd = ad;
            isAdLoaded = true;
          });
        },
        onAdFailedToLoad: (LoadAdError error) {
          print('Ad failed to load: $error');
        },
      ),
    );
  }

  // Ödüllü reklamı göstermek için fonksiyon
  void _showAd() {
    if (isAdLoaded) {
      _rewardedAd.show(
        onUserEarnedReward: (AdWithoutView ad, RewardItem reward) {
          // Kullanıcı ödül kazandığında yapılacak işlemler
          print('User earned reward: ${reward.amount} ${reward.type}');
        },
      );
    } else {
      print('Ad is not loaded yet.');
    }
  }

  Future<void> _sendRewardToApi(int clientId, int reward) async {
    await Future.delayed(Duration(seconds: 2));
    print("Reward $reward sent to client $clientId");
  }

  void shuffleRewards() {
    rewards.shuffle();
  }

  @override
  void initState() {
    super.initState();
    // Reklamı yüklemek
    _loadAd();
  }

  @override
  void dispose() {
    // Reklamı serbest bırakmak
    _rewardedAd.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kart Seçin'),
        backgroundColor: Colors.black,
      ),
      body: Center(
        child: isAdLoaded
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Bir Kart Seç ve Coin Kazan!',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _showAd,  // Reklamı göster butonu
                    child: const Text('Reklamı Göster'),
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
                            color: isRevealed ? Colors.white : Colors.transparent,
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
                            onPressed: isConfirmed
                                ? null
                                : () async {
                                    setState(() {
                                      isConfirmed = true;
                                    });

                                    if (widget.clientId == null) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                        content: Text("Client ID bulunamadı!"),
                                      ));
                                      setState(() {
                                        isConfirmed = false;
                                      });
                                      return;
                                    }

                                    try {
                                      await _apiService.earnCoin(selectedReward!);

                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                        content: Text(
                                            "Ödül başarıyla gönderildi: $selectedReward Coin!"),
                                      ));

                                      Navigator.pop(context);
                                    } catch (e) {
                                      setState(() {
                                        isConfirmed = false;
                                      });
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                        content: Text("Bir hata oluştu: $e"),
                                      ));
                                    }
                                  },
                            child: const Text('Ödülü Al'),
                          ),
                        ],
                      ),
                    ),
                ],
              )
            : Center(
                child: CircularProgressIndicator(),
              ),
      ),
    );
  }
}
