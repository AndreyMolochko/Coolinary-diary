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
  bool _isEnabled;

  @override
  Widget build(BuildContext context) {
    _isEnabled = !(_image == null && widget._viewModel.dish.path == null);
    return Scaffold(
        appBar: AppBar(
          title: Text(widget._viewModel.getPageTitle(context)),
        ),
        body: _buildBody(context));
  }

  Widget _buildBody(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height),
      child: SingleChildScrollView(
        child: Container(
          decoration: App.Shapes.whiteGradient,
          child: Column(
            children: [
              _image == null && widget._viewModel.dish.path == null ? _buildStubImage(context) : _buildPickedImage(),
              Padding(
                padding: const EdgeInsets.only(
                    top: App.Dimens.normalPadding,
                    left: App.Dimens.normalPadding,
                    right: App.Dimens.normalPadding,
                    bottom: App.Dimens.smallPadding),
                child: _buildSaveButton(context, widget._viewModel.dish.path),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStubImage(BuildContext context) {
    return GestureDetector(
      child: Container(
        width: double.maxFinite,
        height: MediaQuery.of(context).size.height * 0.75,
        margin: EdgeInsets.only(right: App.Dimens.bigPadding, left: App.Dimens.bigPadding, top: App.Dimens.bigPadding),
        padding: EdgeInsets.only(
            top: App.Dimens.mediumPadding,
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
    );
  }

  Widget _buildPickedImage() {
    return GestureDetector(
      child: Padding(
        padding: const EdgeInsets.only(
            top: App.Dimens.normalPadding,
            left: App.Dimens.normalPadding,
            right: App.Dimens.normalPadding),
        child: ClipRRect(
            borderRadius: BorderRadius.circular(App.Dimens.borderRadiusAddImage),
            child:
                widget._viewModel.dish.path == null || _image != null ? Image.file(_image) : Image.network(widget._viewModel.dish.path)),
      ),
      onTap: () async {
        await _showCameraGalleryDialog(context);
      },
    );
  }

  Widget _buildSaveButton(BuildContext context, String path) {
    return Container(
      width: double.infinity,
      child: ElevatedButton(
        child: Text(AppTranslations.of(context).text('add_dish_photo_screen_save_button'),
            style: App.TextStyles.normalBlackText),
        style: App.Shapes.primaryButtonStyle,
        onPressed: _isEnabled ? () {
          widget._viewModel.clickOnSave(context, _image != null ? _image.path : path, path != null ? path : "");
          Navigator.of(context).pop();
        } : null,
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
