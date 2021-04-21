import 'package:flutter_svg/svg.dart';
import 'package:sqflite_worker/resourses/module.dart' as App;
import 'package:flutter/material.dart';

class StubViewListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset('assets/wedding-dinner.svg',
              height: App.Dimens.sizeImageStubView, width: App.Dimens.sizeImageStubView, color: App.Colors.black),
          Padding(
            padding: const EdgeInsets.only(left: App.Dimens.bigPadding, right: App.Dimens.bigPadding),
            child: Text("You don't have any dishes, for dishes addition you have to click +",
                textAlign: TextAlign.center, style: App.TextStyles.mediumWhiteText.copyWith(color: App.Colors.black)),
          ),
        ]);
  }
}
