import 'package:flutter/material.dart';
import 'package:sqflite_worker/localization/app_translations.dart';
import 'package:sqflite_worker/model/module.dart';
import 'package:sqflite_worker/resourses/module.dart' as App;
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
        body: _buildBody(context)
    );
  }

  @override
  void dispose() {
    widget._viewModel.dispose();
    super.dispose();
  }

  Widget _buildBody(BuildContext context) {
    return StreamBuilder(
        stream: widget._viewModel.items,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<SettingsItem> listSettingsItems = snapshot.data;
            return ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                return _buildListItem(listSettingsItems[index], context);
              },
              itemCount: listSettingsItems == null ? 0 : listSettingsItems.length,
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        });
  }

  Widget _buildListItem(SettingsItem settingsItem, BuildContext context) {
    return ExpansionTile(
      title: Text(AppTranslations.translate(context, settingsItem.title), style: App.TextStyles.normalBlackText),
      children: _buildSubitemsList(settingsItem, context),
    );
  }

  List<Widget> _buildSubitemsList(SettingsItem settingsItem, BuildContext context) {
    if (settingsItem is LanguageItem) {
      return _buildLanguageItems(settingsItem);
    } else if (settingsItem is AboutItem) {
      return [_getAboutItem(context)];
    } else if (settingsItem is ContactItem) {
      return [_getContactsItem(settingsItem, context)];
    } else if(settingsItem is LogoutItem) {
      return [_getLogoutItem(settingsItem, context)];
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
                      top: App.Dimens.smallPadding, bottom: App.Dimens.smallPadding),
                  child: Text(widget._viewModel.getLanguageByType(
                      languageItem.subItems[i]),
                    style: App.TextStyles.smallBlackText,),
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

  Widget _getAboutItem(BuildContext context) {
    return StreamBuilder(
        stream: widget._viewModel.appVersion,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(
                      left: App.Dimens.normalPadding, bottom: App.Dimens.smallPadding),
                  child: Text("${AppTranslations.translate(context,
                      'version_of_application_settings_screen')} : "
                      "${snapshot.data}",
                      style: App.TextStyles.smallBlackText),
                ),
              ],
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        });
  }

  Widget _getContactsItem(ContactItem contactItem, BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Flexible(
              child: Padding(
                padding: const EdgeInsets.only(
                    bottom: App.Dimens.smallPadding, left: App.Dimens.normalPadding),
                child: Text(
                    AppTranslations.translate(context, "link_with_developer_settings_screen"),
                    style: App.TextStyles.smallBlackText),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: App.Dimens.smallPadding),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: _getIconsNetworks(contactItem)
          ),
        ),
      ],
    );
  }

  Widget _getLogoutItem(LogoutItem logoutItem, BuildContext context) {
    return Row(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(
              left: App.Dimens.normalPadding, right: App.Dimens.normalPadding),
          child: Text(
            AppTranslations.of(context).text(logoutItem.subItems[0]),
            style: App.TextStyles.smallBlackText,),
        ),
        RaisedButton(
          color: App.Colors.white,
          shape: App.Shapes.secondaryButton,
          child: Text(AppTranslations.of(context).text(logoutItem.title),
              style: App.TextStyles.smallBlackText),
          onPressed: () {
            widget._viewModel.handleClickByLogout(context);
          },)
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
