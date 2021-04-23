import 'package:flutter_svg/svg.dart';
import 'package:sqflite_worker/localization/app_translations.dart';
import 'package:sqflite_worker/resourses/module.dart' as App;
import 'package:flutter/material.dart';

class StubViewListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: App.Shapes.whiteGradient,
      child:
          Column(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.center, children: [
        SvgPicture.asset('assets/wedding-dinner.svg',
            height: App.Dimens.sizeImageStubView, width: App.Dimens.sizeImageStubView, color: App.Colors.black),
        Padding(
          padding: const EdgeInsets.only(left: App.Dimens.bigPadding, right: App.Dimens.bigPadding),
          child: Text(AppTranslations.of(context).text('label_stub_view_dish_list_screen'),
              textAlign: TextAlign.center, style: App.TextStyles.mediumWhiteText.copyWith(color: App.Colors.black)),
        ),
      ]),
    );
  }
}
