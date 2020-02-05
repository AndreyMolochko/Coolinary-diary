import 'package:flutter/material.dart';
import 'package:sqflite_worker/localization/app_translations.dart';
import 'package:sqflite_worker/model/module.dart';
import 'package:sqflite_worker/resourses/module.dart';
import 'package:sqflite_worker/ui/settings/module.dart';

class SettingsPage extends StatefulWidget {
  final SettingsViewModelType _viewModel;

  SettingsPage(this._viewModel);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  void initState() {
    widget._viewModel.initState();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(AppTranslations.translate(context, "settings_title_screen")),
        ),
        body: _buildBody());
  }

  @override
  void dispose() {
    widget._viewModel.dispose();
  }

  Widget _buildBody() {
    return StreamBuilder(
        stream: widget._viewModel.items,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<SettingsItem> listSettingsItems = snapshot.data;
            return ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                return _buildListItem(listSettingsItems[index]);
              },
              itemCount: listSettingsItems == null ? 0 : listSettingsItems.length,
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        });
  }

  Widget _buildListItem(SettingsItem settingsItem) {
    return ExpansionTile(
      title: Text(settingsItem.title, style: TextStyles.normalBlackText),
      children: _buildSubitemsList(settingsItem),
    );
  }

  List<Widget> _buildSubitemsList(SettingsItem settingsItem) {
    if (settingsItem is LanguageItem) {
      return _buildLanguageItems(settingsItem);
    } else if (settingsItem is AboutItem) {
      return [_getAboutItem()];
    } else if (settingsItem is ContactItem) {
      return [_getContactsItem(settingsItem)];
    }
  }

  List<Widget> _buildLanguageItems(LanguageItem languageItem) {
    List<Widget> languagesList = [];
    for (int i = 0; i < languageItem.subItems.length; i++) {
      languagesList.add(StreamBuilder(
          stream: widget._viewModel.radioGroupLanguage,
          builder: (context, snapshot) {
            return Row(
              children: <Widget>[
                Radio(value: languageItem.subItems[i],
                  groupValue: snapshot.data,
                  onChanged: widget._viewModel.handleLanguageRadio,),
                InkWell(child: Padding(
                  padding: const EdgeInsets.only(
                      top: Dimens.smallPadding, bottom: Dimens.smallPadding),
                  child: Text(widget._viewModel.getLanguageByType(
                      languageItem.subItems[i]),
                    style: TextStyles.smallBlackText,),
                ),
                    onTap: () {
                      widget._viewModel.handleLanguageRadio(
                          languageItem.subItems[i]);
                    })
              ],
            );
          }
      ));
    }

    return languagesList;
  }

  Widget _getAboutItem() {
    return StreamBuilder(
        stream: widget._viewModel.appVersion,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(
                      left: Dimens.normalPadding, bottom: Dimens.smallPadding),
                  child: Text("Application version : ${snapshot.data}",
                      style: TextStyles.smallBlackText),
                ),
              ],
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        });
  }

  Widget _getContactsItem(ContactItem contactItem) {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Flexible(
              child: Padding(
                padding: const EdgeInsets.only(
                    bottom: Dimens.smallPadding, left: Dimens.normalPadding),
                child: Text(
                    "You can link with developer via these social networks",
                    style: TextStyles.smallBlackText),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: Dimens.smallPadding),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: _getIconsNetworks(contactItem)
          ),
        ),
      ],
    );
  }

  List<Widget> _getIconsNetworks(ContactItem contactItem) {
    List<Widget> iconButtonsList = [];
    for (int i = 0; i < contactItem.subItems.length; i++) {
      ContactResources contactResources = contactItem.subItems[i];
      iconButtonsList.add(
          IconButton(icon: Image.asset(contactResources.imagePath),
            onPressed: () {
              widget._viewModel.handleClickByNetwork(contactResources);
            },)
      );
    }

    return iconButtonsList;
  }
}
