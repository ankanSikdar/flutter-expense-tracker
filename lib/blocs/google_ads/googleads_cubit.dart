import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'ad_ids.dart';

part 'googleads_state.dart';

class GoogleAdsCubit extends Cubit<GoogleAdsState> {
  GoogleAdsCubit() : super(GoogleAdsState.initial()) {
    getBannerAd();
  }

  Future<void> getBannerAd() async {
    emit(state.copyWith(status: AdsStatus.loading));
    try {
      await state.adsState;
      emit(state.copyWith(status: AdsStatus.loaded));
    } catch (e) {
      // * Getting Ready for Release
      // print('AdLoad Failed');
      emit(state.copyWith(status: AdsStatus.error));
    }
  }
}
