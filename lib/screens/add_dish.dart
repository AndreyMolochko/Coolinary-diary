import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sqflite_worker/localization/app_translations.dart';
import 'package:sqflite_worker/model/dish.dart';
import 'package:sqflite_worker/resourses/strings.dart';
import 'package:sqflite_worker/utils/database_helper.dart';
import 'package:sqflite_worker/utils/utils.dart';
import 'package:sqflite_worker/widgets/camera_alert_dialog.dart';
import 'package:sqflite_worker/widgets/image_addition_dish_widget.dart';
import 'package:sqflite_worker/widgets/multiline_text_field.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:sqflite_worker/app_theme.dart' as AppTheme;

typedef void Callback();

class AddDish extends StatefulWidget {
  final Callback callback;

  AddDish(this.callback);

  @override
  _AddDishState createState() => _AddDishState();
}

class _AddDishState extends State<AddDish> {
  var nameController = new TextEditingController();
  var cookingListController = new TextEditingController();
  var ingredientListController = new TextEditingController();
  String category = "soups";
  List<DropdownMenuItem<String>> _dropDownMenuItems;
  DatabaseHelper databaseHelper = new DatabaseHelper();
  bool validateName = false;
  bool validateCookingList = false;
  bool validateIngredient = false;
  File image;

  static const APP_ID = "ca-app-pub-5996416754533238~1194599427";
  static const UNIT_ID = "ca-app-pub-5996416754533238/3208736282";

  static final MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
    testDevices: APP_ID != null ? [APP_ID] : null,
    keywords: ['Kitchen', 'Food'],
  );

  BannerAd bannerAd;
  InterstitialAd interstitialAd;
  RewardedVideoAd rewardedVideoAd;

  BannerAd buildBanner() {
    return BannerAd(
        adUnitId: UNIT_ID,
        size: AdSize.banner,
        listener: (MobileAdEvent event) {
          print(event);
        });
  }

  InterstitialAd buildInterstitial() {
    return InterstitialAd(
        adUnitId: UNIT_ID,
        targetingInfo: targetingInfo,
        listener: (MobileAdEvent event) {
          if (event == MobileAdEvent.failedToLoad) {
            interstitialAd..load();
          } else if (event == MobileAdEvent.closed) {
            interstitialAd = buildInterstitial()
              ..load();
          }
          print(event);
        });
  }

  @override
  void initState() {
    super.initState();

    _initControllers();
    _initAdMobBanner();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _dropDownMenuItems = getDropDownMenuItems();
  }

  void _initControllers() {
    nameController.addListener(() {
      setState(() {
        validateName = Utils.getValidation(nameController.text);
      });
    });

    cookingListController.addListener(() {
      setState(() {
        validateCookingList = Utils.getValidation(cookingListController.text);
      });
    });

    ingredientListController.addListener(() {
      setState(() {
        validateIngredient = Utils.getValidation(ingredientListController.text);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    bannerAd
      ..load()
      ..show();
    return Scaffold(
      appBar: AppBar(
        title: new Text(AppTranslations.translate(context, "add_dish")),
      ),
      body: Builder(
        builder: (context) => SingleChildScrollView(
              child: Container(
                  child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: _getWidgetWithPadding(MultiLineTextField(
                            AppTranslations.translate(context, "name"),
                            validateName,
                            nameController,
                            1)),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Padding(
                          padding: const EdgeInsets.only(left: 16.0),
                          child: ImageNewDish(
                            image: image,
                            onPressed: _showDialog,
                          )),
                      Padding(
                        padding: const EdgeInsets.only(right: 16.0),
                        child: DropdownButton(
                          value: category,
                          items: _dropDownMenuItems,
                          onChanged: _changeDropDownItem,
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: _getWidgetWithPadding(MultiLineTextField(
                            AppTranslations.translate(context, "cooking_list"),
                            validateCookingList,
                            cookingListController,
                            4)),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: _getWidgetWithPadding(MultiLineTextField(
                            AppTranslations.translate(
                                context, "ingredient_list"),
                            validateIngredient,
                            ingredientListController,
                            4)),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 16.0, right: 16.0, top: 8.0),
                    child: SizedBox(
                      height: 48,
                      width: double.infinity,
                      child: RaisedButton(
                        color: AppTheme.Colors.orangePrimary,
                        child: new Text(
                            AppTranslations.translate(context, "add_dish"),),
                        onPressed: () {
                          _onClickAddDish(context);
                        },
                        shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.all(
                                const Radius.circular(
                                    AppTheme.Dimens.radiusButton))),
                      ),
                    ),
                  )
                ],
              )),
            ),
      ),
    );
  }

  @override
  void dispose() {
    bannerAd?.dispose();
    interstitialAd?.dispose();
    super.dispose();
  }

  List<DropdownMenuItem<String>> getDropDownMenuItems() {
    List<DropdownMenuItem<String>> items = new List();
    for (String category in listCategories) {
      items.add(new DropdownMenuItem(
          value: category,
          child: new Text(
            AppTranslations.translate(context, category),
            style: new TextStyle(fontSize: 18.0),
          )));
    }

    return items;
  }

  Widget _getWidgetWithPadding(Widget widget) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 8.0),
      child: widget,
    );
  }

  bool _isValidAllField() {
    if (validateName && validateIngredient && validateCookingList) {
      return true;
    } else {
      return false;
    }
  }

  void _changeDropDownItem(String selectedCategory) {
    setState(() {
      category = selectedCategory;
    });
  }

  void _onClickAddDish(var context) {
    if (_isValidAllField() && image != null) {
      _insertDishFromFields();
    } else {
      _showSnackbarError(context);
    }
  }

  void _insertDishFromFields() async {
    int result = await databaseHelper.insertDish(_getDishFromFields());

    if (result != 0) {
      widget.callback();
      Navigator.pop(context);
    }
  }

  Dish _getDishFromFields() {
    return new Dish(nameController.text, 0, category,
        ingredientListController.text, cookingListController.text, image.path);
  }

  void _showDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return CameraAlertDialog(
              AppTranslations.translate(context, "camera"),
              AppTranslations.translate(context, "gallery"),
              _clickOnCamera,
              _clickOnGallery);
        });
  }

  void _clickOnCamera() async {
    Navigator.pop(context);
    image = await ImagePicker.pickImage(source: ImageSource.camera);
    setState(() {});
  }

  void _clickOnGallery() async {
    Navigator.pop(context);
    image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {});
  }

  void _showSnackbarError(var context) {
    final snackbar = new SnackBar(
      content: Text(AppTranslations.translate(context, "fill_fields")),
    );
    Scaffold.of(context).showSnackBar(snackbar);
  }

  void _initAdMobBanner() {
    FirebaseAdMob.instance.initialize(appId: APP_ID);
    bannerAd = buildBanner()
      ..load();
    interstitialAd = buildInterstitial()
      ..load();
  }
}
