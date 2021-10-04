import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'ad_ids.dart';

part 'googleads_event.dart';
part 'googleads_state.dart';

class GoogleAdsBloc extends Bloc<GoogleAdsEvent, GoogleAdsState> {
  GoogleAdsBloc() : super(GoogleAdsState.initial()) {
    on<GoogleAdsEvent>((event, emit) async {
      if (event is LoadBannerAd) {
        emit(state.copyWith(status: AdsStatus.loading));
        await state.adsState;
        emit(state.copyWith(
            bannerAd: state.createBannerAd(), status: AdsStatus.loaded));
      }
    });
  }
}
