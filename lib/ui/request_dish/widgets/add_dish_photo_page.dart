import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sqflite_worker/localization/app_translations.dart';
import 'package:sqflite_worker/resourses/module.dart' as App;

import '../module.dart';

class AddDishPhotoPage extends StatefulWidget {
  final RequestDishViewModelType _viewModel;

  AddDishPhotoPage(this._viewModel);

  @override
  _AddDishPhotoPageState createState() => _AddDishPhotoPageState();
}

class _AddDishPhotoPageState extends State<AddDishPhotoPage> {
  final ImagePicker _imagePicker = ImagePicker();
  File _image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget._viewModel.getPageTitle(context)),
        ),
        body: _buildBody(context));
  }

  Widget _buildBody(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          _image == null ? _buildStubImage(context) : _buildPickedImage(),
          Padding(
            padding: const EdgeInsets.only(
                left: App.Dimens.normalPadding, right: App.Dimens.normalPadding, bottom: App.Dimens.smallPadding),
            child: _buildSaveButton(context),
          )
        ],
      ),
    );
  }

  Widget _buildStubImage(BuildContext context) {
    return Expanded(
        child: GestureDetector(
      child: Container(
        width: double.maxFinite,
        margin: EdgeInsets.only(right: App.Dimens.bigPadding, left: App.Dimens.bigPadding, top: App.Dimens.bigPadding),
        padding: EdgeInsets.only(
            top: App.Dimens.bigPadding,
            bottom: App.Dimens.bigPadding,
            left: App.Dimens.normalPadding,
            right: App.Dimens.normalPadding),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(App.Dimens.borderRadiusAddImage), color: App.Colors.gainsboro),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(right: App.Dimens.smallPadding),
              child: Icon(Icons.camera_alt, size: 72),
            ),
            Padding(
              padding: const EdgeInsets.only(top: App.Dimens.smallPadding),
              child: Text(AppTranslations.of(context).text('subtitle_add_dish_photo_screen')),
            )
          ],
        ),
      ),
      onTap: () async {
        await _showCameraGalleryDialog(context);
      },
    ));
  }

  Widget _buildPickedImage() {
    return GestureDetector(
      child: Padding(
        padding: const EdgeInsets.only(
            top: App.Dimens.normalPadding,
            bottom: App.Dimens.mediumPadding,
            left: App.Dimens.normalPadding,
            right: App.Dimens.normalPadding),
        child:
            ClipRRect(borderRadius: BorderRadius.circular(App.Dimens.borderRadiusAddImage), child: Image.file(_image)),
      ),
      onTap: () async {
        await _showCameraGalleryDialog(context);
      },
    );
  }

  Widget _buildSaveButton(BuildContext context) {
    return Container(
      width: double.infinity,
      child: ElevatedButton(
        child: Text(AppTranslations.of(context).text('add_dish_photo_screen_save_button')),
        onPressed: () {
          widget._viewModel.saveImagePath(_image.path);//TODO: validation
          widget._viewModel.addDish();
          Navigator.of(context).pop();
        },
      ),
    );
  }

  Future<void> _showCameraGalleryDialog(BuildContext context) {
    return showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text(AppTranslations.of(context).text('camera_title_add_dish_photo_screen')),
                      onTap: () {
                        _uploadImageFromSource(ImageSource.camera);
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text(AppTranslations.of(context).text('gallery_title_add_dish_photo_screen')),
                    onTap: () {
                      _uploadImageFromSource(ImageSource.gallery);
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  _uploadImageFromSource(ImageSource source) async {
    final _pickerImage = await _imagePicker.getImage(source: source);

    setState(() {
      _image = File(_pickerImage.path);
    });
  }
}
