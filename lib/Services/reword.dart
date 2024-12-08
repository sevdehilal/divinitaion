import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdPage extends StatefulWidget {
  @override
  _AdPageState createState() => _AdPageState();
}

class _AdPageState extends State<AdPage> {
  // Reklam birimi ID'leri
  static const String bannerAdUnitId =
      'ca-app-pub-3940256099942544/6300978111'; // Test Banner ID
  static const String interstitialAdUnitId =
      'ca-app-pub-3940256099942544/1033173712'; // Test Interstitial ID
  static const String rewardedAdUnitId =
      'ca-app-pub-3940256099942544/5224354917'; // Test Rewarded ID

  late BannerAd _bannerAd;
  late InterstitialAd _interstitialAd;
  late RewardedAd _rewardedAd;

  bool _isBannerAdLoaded = false;
  bool _isInterstitialAdLoaded = false;
  bool _isRewardedAdLoaded = false;

  @override
  void initState() {
    super.initState();
    _loadBannerAd();
    _loadInterstitialAd();
    _loadRewardedAd();
  }

  @override
  void dispose() {
    super.dispose();
    _bannerAd.dispose();
    _interstitialAd.dispose();
    _rewardedAd.dispose();
  }

  // Banner reklamını yükle
  void _loadBannerAd() {
    _bannerAd = BannerAd(
      adUnitId: bannerAdUnitId,
      size: AdSize.banner,
      request: AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (_) {
          setState(() {
            _isBannerAdLoaded = true;
          });
        },
        onAdFailedToLoad: (ad, error) {
          print('Banner Ad failed to load: $error');
          setState(() {
            _isBannerAdLoaded = false;
          });
        },
      ),
    );
    _bannerAd.load();
  }

  // Interstitial reklamını yükle
  void _loadInterstitialAd() {
    InterstitialAd.load(
      adUnitId: interstitialAdUnitId,
      request: AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          _interstitialAd = ad;
          setState(() {
            _isInterstitialAdLoaded = true;
          });
        },
        onAdFailedToLoad: (error) {
          print('Interstitial Ad failed to load: $error');
          setState(() {
            _isInterstitialAdLoaded = false;
          });
        },
      ),
    );
  }

  // Rewarded reklamını yükle
  void _loadRewardedAd() {
    RewardedAd.load(
      adUnitId: rewardedAdUnitId,
      request: AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (ad) {
          _rewardedAd = ad;
          setState(() {
            _isRewardedAdLoaded = true;
          });
        },
        onAdFailedToLoad: (error) {
          print('Rewarded Ad failed to load: $error');
          setState(() {
            _isRewardedAdLoaded = false;
          });
        },
      ),
    );
  }

  // Banner reklamı göster
  Widget _showBannerAd() {
    return _isBannerAdLoaded
        ? Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 50,
              child: AdWidget(ad: _bannerAd),
            ),
          )
        : Container();
  }

  // Interstitial reklamını göster
  void _showInterstitialAd() {
    if (_isInterstitialAdLoaded) {
      _interstitialAd.show();
    } else {
      print('Interstitial Ad is not loaded yet');
    }
  }

  // Rewarded reklamını göster
  void _showRewardedAd() {
    if (_isRewardedAdLoaded) {
      _rewardedAd.show(
        onUserEarnedReward: (AdWithoutView ad, RewardItem reward) {
          print('User earned reward: ${reward.amount}');
        },
      );
    } else {
      print('Rewarded Ad is not loaded yet');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AdMob Test Sayfası'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: _showInterstitialAd,
              child: Text('Interstitial Reklamı Göster'),
            ),
            ElevatedButton(
              onPressed: _showRewardedAd,
              child: Text('Rewarded Reklamı Göster'),
            ),
            _showBannerAd(),
          ],
        ),
      ),
    );
  }
}
