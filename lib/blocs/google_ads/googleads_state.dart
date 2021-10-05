part of 'googleads_cubit.dart';

enum AdsStatus {
  initial,
  loading,
  loaded,
  error,
}

class GoogleAdsState extends Equatable {
  final Future<InitializationStatus> adsState;
  final AdsStatus status;

  final interstitialAdLoadCallback = FullScreenContentCallback(
    onAdShowedFullScreenContent: (InterstitialAd ad) =>
        print('$ad onAdShowedFullScreenContent.'),
    onAdDismissedFullScreenContent: (InterstitialAd ad) {
      print('$ad onAdDismissedFullScreenContent.');
      ad.dispose();
    },
    onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
      print('$ad onAdFailedToShowFullScreenContent: $error');
      ad.dispose();
    },
    onAdImpression: (InterstitialAd ad) => print('$ad impression occurred.'),
  );

  final _bannerAdListener = BannerAdListener(
    // Called when an ad is successfully received.
    onAdLoaded: (Ad ad) => print('Ad loaded.'),
    // Called when an ad request failed.
    onAdFailedToLoad: (Ad ad, LoadAdError error) {
      // Dispose the ad here to free resources.
      ad.dispose();
      print('Ad failed to load: $error');
    },
    // Called when an ad opens an overlay that covers the screen.
    onAdOpened: (Ad ad) => print('Ad opened.'),
    // Called when an ad removes an overlay that covers the screen.
    onAdClosed: (Ad ad) => print('Ad closed.'),
    // Called when an impression occurs on the ad.
    onAdImpression: (Ad ad) => print('Ad impression.'),
  );

  BannerAd createBannerAd() {
    return BannerAd(
      size: AdSize.banner,
      adUnitId: AdIds.bannerAdUnitId,
      request: AdRequest(),
      listener: _bannerAdListener,
    );
  }

  GoogleAdsState({
    @required this.adsState,
    @required this.status,
  });

  factory GoogleAdsState.initial() {
    return GoogleAdsState(
      adsState: MobileAds.instance.initialize(),
      status: AdsStatus.initial,
    );
  }

  @override
  List<Object> get props => [adsState, status];

  GoogleAdsState copyWith({
    Future<InitializationStatus> adsState,
    AdsStatus status,
    BannerAd bannerAd,
  }) {
    return GoogleAdsState(
      adsState: adsState ?? this.adsState,
      status: status ?? this.status,
    );
  }
}
