import 'package:admob_demo/app_helper.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:pay/pay.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late BannerAd bottomBannerAd;
  bool isBottomBannerAdLoaded = false;
  final paymentItems = <PaymentItem>[];
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
    paymentItems.add(PaymentItem(
        amount: '200',
        label: "Product1",
        status: PaymentItemStatus.final_price));
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
          child: GooglePayButton(
            paymentConfigurationAsset: 'gpay.json',
            paymentItems: paymentItems,
            onPaymentResult: (data) {
              print(data);
            },
            width: 150.0,
            height: 60.0,
            style: GooglePayButtonStyle.white,
            type: GooglePayButtonType.pay
          ),
        ),
      ),
    );
  }
}
