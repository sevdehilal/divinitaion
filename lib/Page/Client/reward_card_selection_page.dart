// import 'package:divinitaion/Page/Client/fortune_teller_list.dart';
// import 'package:divinitaion/Services/service.dart';
// import 'package:flutter/material.dart';
// import 'package:google_mobile_ads/google_mobile_ads.dart';

// class RewardCardSelectionPage extends StatefulWidget {
//   final int? clientId;

//   const RewardCardSelectionPage({Key? key, this.clientId}) : super(key: key);

//   @override
//   _RewardCardSelectionPageState createState() =>
//       _RewardCardSelectionPageState();
// }

// class _RewardCardSelectionPageState extends State<RewardCardSelectionPage> {
//   int? selectedReward;
//   List<int> rewards = [5, 10, 15, 20, 25, 30];
//   ApiService _apiService = ApiService();

//   bool isRevealed = false;
//   bool isConfirmed = false;
//   bool isAdCompleted = false;

//   RewardedAd? _rewardedAd;

//   @override
//   void initState() {
//     super.initState();
//     // AdMob test ID'sini kullanarak reklamı yükle
//     _loadRewardedAd();
//   }

//   // Reklam yükleme fonksiyonu
//   void _loadRewardedAd() {
//     RewardedAd.load(
//       adUnitId:
//           'ca-app-pub-3940256099942544/5224354917', // Google'ın AdMob test ID'si
//       request: AdRequest(),
//       rewardedAdLoadCallback: RewardedAdLoadCallback(
//         onAdLoaded: (ad) {
//           setState(() {
//             _rewardedAd = ad;
//           });
//           // Reklam yüklendiğinde otomatik olarak göster
//           _showRewardedAd();
//         },
//         onAdFailedToLoad: (error) {
//           print('Failed to load rewarded ad: $error');
//         },
//       ),
//     );
//   }

//   // Reklamı gösterme fonksiyonu
//   void _showRewardedAd() {
//     if (_rewardedAd != null) {
//       _rewardedAd!.show(
//         onUserEarnedReward: (ad, reward) {
//           setState(() {
//             isAdCompleted = true;
//           });
//           print('User earned reward: ${reward.amount} ${reward.type}');
//         },
//       );
//     } else {
//       print('Ad is not loaded yet');
//     }
//   }

//   @override
//   void dispose() {
//     super.dispose();
//     // Reklam nesnesini serbest bırak
//     _rewardedAd?.dispose();
//   }

//   void shuffleRewards() {
//     rewards.shuffle();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Kart Seçin'),
//         backgroundColor: Colors.black,
//       ),
//       body: Center(
//         child: isAdCompleted
//             ? Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   const Text(
//                     'Bir Kart Seç ve Coin Kazan!',
//                     style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//                   ),
//                   const SizedBox(height: 20),
//                   GridView.builder(
//                     shrinkWrap: true,
//                     gridDelegate:
//                         const SliverGridDelegateWithFixedCrossAxisCount(
//                       crossAxisCount: 3,
//                       crossAxisSpacing: 10,
//                       mainAxisSpacing: 10,
//                     ),
//                     itemCount: rewards.length,
//                     itemBuilder: (context, index) {
//                       return GestureDetector(
//                         onTap: isRevealed || isConfirmed
//                             ? null
//                             : () {
//                                 setState(() {
//                                   shuffleRewards();
//                                   selectedReward = rewards[index];
//                                   isRevealed = true;
//                                 });
//                               },
//                         child: AnimatedContainer(
//                           duration: const Duration(seconds: 1),
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(20),
//                             color:
//                                 isRevealed ? Colors.white : Colors.transparent,
//                             image: isRevealed
//                                 ? null
//                                 : DecorationImage(
//                                     image: AssetImage(
//                                         'lib/assets/tarot_karti.jpg'),
//                                     fit: BoxFit.cover,
//                                   ),
//                           ),
//                           alignment: Alignment.center,
//                           width: 150,
//                           height: 80,
//                           child: isRevealed
//                               ? Text(
//                                   '${rewards[index]} Coin',
//                                   style: const TextStyle(
//                                       fontSize: 18,
//                                       fontWeight: FontWeight.bold,
//                                       color: Colors.black),
//                                 )
//                               : Container(),
//                         ),
//                       );
//                     },
//                   ),
//                   if (isRevealed && selectedReward != null)
//                     Padding(
//                       padding: const EdgeInsets.only(top: 20),
//                       child: Column(
//                         children: [
//                           Text(
//                             '$selectedReward Coin Kazandınız!',
//                             style: const TextStyle(
//                                 fontSize: 18, fontWeight: FontWeight.bold),
//                           ),
//                           ElevatedButton(
//                             onPressed: isConfirmed
//                                 ? null
//                                 : () async {
//                                     setState(() {
//                                       isConfirmed = true;
//                                     });

//                                     if (widget.clientId == null) {
//                                       ScaffoldMessenger.of(context)
//                                           .showSnackBar(const SnackBar(
//                                         content: Text("Client ID bulunamadı!"),
//                                       ));
//                                       setState(() {
//                                         isConfirmed = false;
//                                       });
//                                       return;
//                                     }

//                                     try {
//                                       await _apiService
//                                           .earnCoin(selectedReward!);

//                                       ScaffoldMessenger.of(context)
//                                           .showSnackBar(SnackBar(
//                                         content: Text(
//                                             "Ödül başarıyla gönderildi: $selectedReward Coin!"),
//                                       ));
//                                       Navigator.pop(context);
//                                       Navigator.pushReplacement(
//                                         context,
//                                         MaterialPageRoute(
//                                             builder: (context) =>
//                                                 ClientFortuneTellerList()),
//                                       );
//                                     } catch (e) {
//                                       setState(() {
//                                         isConfirmed = false;
//                                       });
//                                       ScaffoldMessenger.of(context)
//                                           .showSnackBar(SnackBar(
//                                         content: Text("Bir hata oluştu: $e"),
//                                       ));
//                                     }
//                                   },
//                             child: const Text('Ödülü Al'),
//                           ),
//                         ],
//                       ),
//                     ),
//                 ],
//               )
//             : const CircularProgressIndicator(),
//       ),
//     );
//   }
// }
