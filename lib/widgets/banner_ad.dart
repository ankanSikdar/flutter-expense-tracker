import 'package:expense_app/blocs/app_blocs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class BannerAdWidget extends StatelessWidget {
  BannerAdWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GoogleAdsCubit, GoogleAdsState>(
      builder: (context, state) {
        if (state.status == AdsStatus.loaded) {
          final ad = state.createBannerAd();
          // return Ad
          return Container(
            width: double.infinity,
            height: 50.0,
            margin: EdgeInsets.symmetric(vertical: 8.0),
            child: AdWidget(
              ad: ad..load(),
              key: UniqueKey(),
            ),
          );
        }
        return Container();
      },
    );
  }
}
