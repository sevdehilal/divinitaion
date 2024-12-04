import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdMobService {
  late RewardedInterstitialAd _rewardedInterstitialAd;
  bool isAdLoaded = false;

  static String get rewardedInterstitialAdUnitId {
    return 'ca-app-pub-2442587495670415/3394104117'; // Ödüllü geçiş reklam birimi ID
  }

  Future<void> initialize() async {
    await MobileAds.instance.initialize();
  }

  Future<void> loadRewardedInterstitialAd(
      Function(RewardItem) onUserEarnedReward) async {
    RewardedInterstitialAd.load(
      adUnitId: rewardedInterstitialAdUnitId,
      request: AdRequest(),
      rewardedInterstitialAdLoadCallback: RewardedInterstitialAdLoadCallback(
        onAdLoaded: (RewardedInterstitialAd ad) {
          _rewardedInterstitialAd = ad;
          isAdLoaded = true;
        },
        onAdFailedToLoad: (LoadAdError error) {
          print('Rewarded Interstitial Ad Failed to Load: $error');
          isAdLoaded = false;
        },
      ),
    );
  }

  void showRewardedInterstitialAd(Function(RewardItem) onUserEarnedReward) {
    if (isAdLoaded) {
      _rewardedInterstitialAd.show(
        onUserEarnedReward: (AdWithoutView ad, RewardItem reward) {
          onUserEarnedReward(reward);
        },
      );
    } else {
      print('Rewarded Interstitial Ad is not loaded yet.');
    }
  }

  void dispose() {
    _rewardedInterstitialAd.dispose();
  }
}
