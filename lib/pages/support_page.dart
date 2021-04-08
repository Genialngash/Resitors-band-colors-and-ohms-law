import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';
import 'package:resistohms/color_picker.dart';
import 'package:resistohms/constants.dart';

import '../ad_manager.dart';

class RatingPage extends StatefulWidget {
  @override
  _RatingPageState createState() => _RatingPageState();
}

class _RatingPageState extends State<RatingPage> {
  void _loadBannerAd() {
    _bannerAd
      ..load()
      ..show(anchorType: AnchorType.top);
  }

  void _loadNativeAd() {
    _nativeAd
      ..load()
      ..show(anchorType: AnchorType.bottom);
  }

  BannerAd _bannerAd;
  NativeAd _nativeAd;

  bool _isRewardedAdReady;

  void _loadRewardedAd() {
    RewardedVideoAd.instance.load(
      targetingInfo: MobileAdTargetingInfo(),
      adUnitId: AdManager.rewardedAdUnitId,
    );
  }

  void _onRewardedAdEvent(RewardedVideoAdEvent event,
      {String rewardType, int rewardAmount}) {
    switch (event) {
      case RewardedVideoAdEvent.loaded:
        setState(() {
          _isRewardedAdReady = true;
        });
        break;
      case RewardedVideoAdEvent.closed:
        setState(() {
          _isRewardedAdReady = false;
        });
        _loadRewardedAd();
        break;
      case RewardedVideoAdEvent.failedToLoad:
        setState(() {
          _isRewardedAdReady = false;
        });

        print('Failed to load a rewarded ad');
        break;
      case RewardedVideoAdEvent.rewarded:
        _loadNativeAd();
        break;
      default:
      // do nothing
    }
  }

  // InterstitialAd _interstitialAd = InterstitialAd(
  //   adUnitId: AdManager.interstitialAdUnitId,
  // );
  InterstitialAd _interstitialAd;
  void _loadInterstitialAd() {
    _interstitialAd.load();
  }

  @override
  void initState() {
    _bannerAd = BannerAd(
      adUnitId: AdManager.bannerAdUnitId,
      size: AdSize.banner,
    );

    _isRewardedAdReady = false;

    RewardedVideoAd.instance.listener = _onRewardedAdEvent;

    _loadRewardedAd();

    _interstitialAd = InterstitialAd(
      adUnitId: AdManager.interstitialAdUnitId,
    );

    super.initState();
  }

  @override
  void dispose() {
    _bannerAd?.dispose();
    RewardedVideoAd.instance.listener = null;
    _interstitialAd?.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.all(20),
      child: Container(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            'SUPPORT THE DEVELOPER BY \tWATCHING THE VIDEO',
            style: textStyling(fontSize: 17),
          ),
          ElevatedButton(
              onPressed: () {
                RewardedVideoAd.instance.show();
                if (_isRewardedAdReady == false) {
                  _loadNativeAd();
                  _loadBannerAd();
                }
              },
              child: Text('Watch')),
          ColorPicker(
              width: screenWidth - screenWidth / 6,
              onColorChanged: (Color color) async {}),
          ElevatedButton(
              onPressed: () {
                _loadInterstitialAd();

                RewardedVideoAd.instance.show();
              },
              child: Text('Earn'))
        ],
      )),
    );
  }
}
