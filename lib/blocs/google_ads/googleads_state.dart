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

  final _bannerAdListener = BannerAdListener(
    // Called when an ad is successfully received.
    onAdLoaded: (Ad ad) {
      // * Getting Ready for Release
      // print('Ad loaded.');
    },
    // Called when an ad request failed.
    onAdFailedToLoad: (Ad ad, LoadAdError error) {
      // Dispose the ad here to free resources.
      ad.dispose();
      // * Getting Ready for Release
      // print('Ad failed to load: $error');
    },

    // * Getting Ready for Release
    // Called when an ad opens an overlay that covers the screen.
    // onAdOpened: (Ad ad) {
    //   print('Ad opened.');
    // },
    // Called when an ad removes an overlay that covers the screen.
    // onAdClosed: (Ad ad) => print('Ad closed.'),
    // Called when an impression occurs on the ad.
    // onAdImpression: (Ad ad) => print('Ad impression.'),
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
