import 'package:admob_demo/app_helper.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late BannerAd bottomBannerAd;
  bool isBottomBannerAdLoaded = false;

  void createBottomBannerAd() {
    bottomBannerAd = BannerAd(
        size: AdSize.banner,
        adUnitId: AdHelper.bannerAdUnitId,
        listener: BannerAdListener(onAdLoaded: (_) {
          setState(() {
            isBottomBannerAdLoaded = true;
          });
        }, onAdFailedToLoad: (ad, error) {
          ad.dispose();
        }),
        request: AdRequest());
    bottomBannerAd.load();
  }

  @override
  void initState() {
    super.initState();
    createBottomBannerAd();
  }

  @override
  void dispose() {
    super.dispose();
    bottomBannerAd.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: isBottomBannerAdLoaded
          ? Container(
              height: bottomBannerAd.size.height.toDouble(),
              width: bottomBannerAd.size.width.toDouble(),
              child: AdWidget(ad: bottomBannerAd),
            )
          : null,
      appBar: AppBar(
        title: Text('Load Bottom AdMob Banner'),
        centerTitle: true,
      ),
      body: Container(
        child: Center(
          child: Text('Body'),
        ),
      ),
    );
  }
}
