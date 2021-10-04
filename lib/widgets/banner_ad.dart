import 'package:expense_app/blocs/app_blocs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BannerAdWidget extends StatelessWidget {
  const BannerAdWidget({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GoogleAdsBloc, GoogleAdsState>(
      builder: (context, state) {
        if (state.status == AdsStatus.loaded) {
          // return Ad
          return Container();
        }
        return Container(
          height: 0,
          width: 0,
        );
      },
    );
  }
}
