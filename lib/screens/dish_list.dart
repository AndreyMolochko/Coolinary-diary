import 'package:flutter/material.dart';
import 'package:sqflite_worker/localization/app_translations.dart';
import 'package:sqflite_worker/model/dish.dart';
import 'package:sqflite_worker/screens/settings.dart';
import 'package:sqflite_worker/utils/database_helper.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_worker/resourses/strings.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sqflite_worker/screens/update_dish.dart';
import 'package:sqflite_worker/screens/cooking_dish.dart';
import 'package:sqflite_worker/screens/add_dish.dart';
import 'dart:io';

class DishList extends StatefulWidget {
  @override
  _DishListState createState() => _DishListState();
}

class _DishListState extends State<DishList> {
  int indexNavBar = 0;
  static String title = "";
  DatabaseHelper databaseHelper = new DatabaseHelper();
  String currentCategory = listCategories[0];
  List<Dish> dishList;
  List<Dish> filterFullList;
  List<String> popupItems = ["update", "delete"];
  List<String> categoriesList = new List();
  BuildContext contextSnackbar;
  int id;
  Dish dish;
  Icon search = new Icon(
    Icons.search,
    color: Colors.white,
  );
  final TextEditingController filterController = new TextEditingController();

  Widget appBarTitle = new Text(title);

  @override
  void initState() {
    _updateScreen();
    _initFilterController();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _initCategories();
    setState(() {
      title = categoriesList[0];
    });
  }

  @override
  Widget build(BuildContext context) {
    if (dishList == null) {
      dishList = new List<Dish>();
      _updateScreen();
    }

    Widget body = _getBody();

    return Scaffold(
      appBar: _appBar(appBarTitle),
      body: body,
      bottomNavigationBar: new Theme(
          data: Theme.of(context).copyWith(canvasColor: Colors.blue),
          child: _getBottomNavigationBar()),
    );
  }

  void onTapBottomNavigationBar(int index) {
    setState(() {
      switch (index) {
        case 0:
          _switchNewTapItem(0);
          _updateScreen();
          break;

        case 1:
          _switchNewTapItem(1);
          _updateScreen();
          break;
        case 2:
          _switchNewTapItem(2);
          _updateScreen();
          break;
        case 3:
          _switchNewTapItem(3);
          _updateScreen();
          break;
        case 4:
          _switchNewTapItem(4);
          _updateScreen();
          break;
      }
    });
  }

  BottomNavigationBar _getBottomNavigationBar() {
    return BottomNavigationBar(
        onTap: onTapBottomNavigationBar,
        currentIndex: indexNavBar,
        items: [
          BottomNavigationBarItem(
              icon: new SvgPicture.asset(
                "assets/soup.svg",
                height: 24,
              ),
              title: Text(categoriesList[0])),
          BottomNavigationBarItem(
              icon: new SvgPicture.asset(
                "assets/wedding-dinner.svg",
                height: 24,
              ),
              title: new Text(categoriesList[1])),
          BottomNavigationBarItem(
              icon: new SvgPicture.asset(
                "assets/salad.svg",
                height: 24,
              ),
              title: new Text(categoriesList[2])),
          BottomNavigationBarItem(
              icon: new SvgPicture.asset(
                "assets/birthday-cake.svg",
                height: 24,
              ),
              title: new Text(categoriesList[3])),
          BottomNavigationBarItem(
              icon: new SvgPicture.asset(
                "assets/lemonade.svg",
                height: 24,
              ),
              title: new Text(categoriesList[4]))
        ]);
  }

  void _updateScreen() {
    final Future<Database> dbFuture = databaseHelper.initializeDatabase();
    dbFuture.then((database) {
      Future<List<Dish>> dishListFuture =
          databaseHelper.getDishesByCategory(currentCategory);
      dishListFuture.then((dishList) {
        setState(() {
          this.dishList = dishList;
          filterFullList = dishList;
        });
      });
    });
  }

  Widget _appBar(Widget appBarTitle) {
    return AppBar(
      title: appBarTitle,
      actions: <Widget>[
        IconButton(
          icon: search,
          onPressed: _searchPressed,
        ),
        IconButton(
          icon: new Icon(
            Icons.add,
            color: Colors.white,
          ),
          onPressed: _onClickAdd,
        ),
        IconButton(
          icon: new Icon(
            Icons.more_vert,
            color: Colors.white,
          ),
          onPressed: _clickSettingsItem,
        ),
      ],
    );
  }

  void _onClickAdd() {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => new AddDish(_updateScreen)));
  }

  void onClickPopupMenu(String action) {
    if (action == popupItems[0]) {
      _onClickUpdateDish();
    } else if (action == popupItems[1]) {
      _onClickDeleteDish();
    }
  }

  void _onClickUpdateDish() {
    _showUpdateDishScreen();
  }

  void _onClickDeleteDish() {
    _showSnackbarForDelete();
  }

  void _showSnackbarForDelete() {
    final snackbar = new SnackBar(
      content: Text("Do you really want to delete"
          " dish?"),
      action: SnackBarAction(label: 'Yes', onPressed: _clickOnSnackbar),
      duration: new Duration(days: 1000),
    );
    Scaffold.of(contextSnackbar).showSnackBar(snackbar);
  }

  void _clickOnSnackbar() {
    _deleteDish(id);
  }

  void _deleteDish(int id) async {
    int result = await databaseHelper.deleteDish(id);
  }

  void _showUpdateDishScreen() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => new UpdateDish(dish, _updateScreen)));
  }

  void _showCookingScreen(Dish dish) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => new CookingDish((dish))));
  }

  void _showSettings() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => new SettingsWidget()));
  }

  void _searchPressed() {
    setState(() {
      if (search.icon == Icons.search) {
        search = new Icon(Icons.close);
        appBarTitle = new TextField(
          style: new TextStyle(color: Colors.white, fontSize: 18.0),
          controller: filterController,
          decoration: new InputDecoration(
              prefixIcon: new Icon(
                Icons.search,
                color: Colors.white,
              ),
              hintText: AppTranslations.translate(context, "search"),
              hintStyle: new TextStyle(color: Colors.white)),
        );
      } else {
        filterController.clear();
        search = new Icon(Icons.search);
        appBarTitle = new Text(title);
      }
    });
  }

  void _initFilterController() {
    filterController.addListener(() {
      if (filterController.text.isEmpty || filterController.text.length < 1) {
        setState(() {
          dishList = filterFullList;
        });
      } else {
        setState(() {
          dishList = _getFilterList(filterController.text);
        });
      }
    });
  }

  List<Dish> _getFilterList(String title) {
    List<Dish> filterList = new List();

    for (int i = 0; i < filterFullList.length; i++) {
      if (filterFullList[i].name.toLowerCase().contains(title.toLowerCase())) {
        filterList.add(filterFullList[i]);
      }
    }

    return filterList;
  }

  Widget _getDishesWidget() {
    return ListView.builder(
      itemBuilder: (context, position) {
        return Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 8.0),
          child: Container(
            decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: new BorderRadius.all(Radius.circular(6.0))),
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0, left: 8.0),
                      child: Text(
                        dishList[position].name,
                        style: new TextStyle(fontSize: 24.0),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0, right: 8.0),
                      child: PopupMenuButton<String>(
                        onSelected: onClickPopupMenu,
                        icon: Icon(Icons.more_horiz),
                        itemBuilder: (BuildContext context) {
                          id = dishList[position].id;
                          dish = dishList[position];
                          contextSnackbar = context;
                          return popupItems.map((String choice) {
                            return PopupMenuItem<String>(
                              value: choice,
                              child: Text(choice),
                            );
                          }).toList();
                        },
                      ),
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(),
                  child: dishList[position].path.length > 0
                      ? Image.file(new File(dishList[position].path))
                      : Icon(Icons.image),
                ),
                Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, top: 8.0),
                      child: Text(
                        "You cooked this dish " +
                            dishList[position].counterCooking.toString() +
                            " times",
                        style: new TextStyle(fontSize: 16.0),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, left: 8.0),
                  child: Row(
                    children: <Widget>[
                      Text(
                          dishList[position]
                              .ingredientList
                              .replaceAll(r'$', '\n'),
                          style: new TextStyle(fontSize: 18.0)),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 8.0,
                    left: 8.0,
                    bottom: 8.0,
                  ),
                  child: Row(
                    children: <Widget>[
                      InkWell(
                        child: Text(AppTranslations.translate(context, "cook"),
                            style: new TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.blueAccent)),
                        onTap: () {
                          _showCookingScreen(dishList[position]);
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
      itemCount: dishList.length,
    );
  }

  Widget _getBody() {
    Widget body;
    if (dishList.length == 0) {
      body = _noDataAvailable();
    } else {
      body = _getDishesWidget();
    }

    return body;
  }

  Widget _noDataAvailable() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Flexible(
              child: Text(
                AppTranslations.translate(context, "no_data_available"),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ],
    );
  }

  void _switchNewTapItem(int index) {
    title = categoriesList[index];
    appBarTitle = new Text(title);
    search = new Icon(Icons.search);
    filterController.clear();
    indexNavBar = index;
  }

  void _clickSettingsItem() {
    _showSettings();
  }

  void _initCategories() {
    categoriesList.add(AppTranslations.translate(context, "soups"));
    categoriesList.add(AppTranslations.translate(context, "main"));
    categoriesList.add(AppTranslations.translate(context, "salads"));
    categoriesList.add(AppTranslations.translate(context, "dessert"));
    categoriesList.add(AppTranslations.translate(context, "drinks"));
  }
}
