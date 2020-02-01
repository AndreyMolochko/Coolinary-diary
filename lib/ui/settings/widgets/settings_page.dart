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
      children: _buildSubItemsList(settingsItem),
    );
  }

  List<Widget> _buildSubItemsList(SettingsItem settingsItem) {
    if (settingsItem is LanguageItem) {
      return [Text("Language subItem")];
    } else if (settingsItem is MoreItem) {
      return [Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: Dimens.normalPadding, bottom: Dimens.smallPadding),
            child: Text("More subItem", style: TextStyles.smallBlackText),
          ),
        ],
      )];
    }
  }
}
