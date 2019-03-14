import 'package:flutter/material.dart';
import 'package:sqflite_worker/model/dish.dart';
import 'package:sqflite_worker/utils/database_helper.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_worker/resourses/strings.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sqflite_worker/screens/update_dish.dart';
import 'package:sqflite_worker/screens/cooking_dish.dart';

class DishList extends StatefulWidget {
  @override
  _DishListState createState() => _DishListState();
}

class _DishListState extends State<DishList> {
  int indexNavBar = 0;
  static String title = listCategories[0];
  DatabaseHelper databaseHelper = new DatabaseHelper();
  List<Dish> dishList;
  List<Dish> filterFullList;
  List<String> popupItems = ["update", "delete"];
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
    updateScreen();
    _initFilterController();
  }

  @override
  Widget build(BuildContext context) {
    if (dishList == null) {
      dishList = new List<Dish>();
      updateScreen();
    }

    Widget body;
    if (dishList.length == 0) {
      body = noDataAvailable();
    } else {
      body = getDishesWidget();
    }

    return Scaffold(
      appBar: appBar(appBarTitle),
      body: body,
      bottomNavigationBar: new Theme(
          data: Theme.of(context).copyWith(canvasColor: Colors.blue),
          child: getBottomNavigationBar()),
    );
  }

  void onTapBottomNavigationBar(int index) {
    setState(() {
      switch (index) {
        case 0:
          title = listCategories[0];
          appBarTitle = new Text(title);
          search = new Icon(Icons.search);
          filterController.clear();
          indexNavBar = 0;
          updateScreen();
          break;

        case 1:
          title = listCategories[1];
          appBarTitle = new Text(title);
          search = new Icon(Icons.search);
          filterController.clear();
          indexNavBar = 1;
          updateScreen();
          break;
        case 2:
          title = listCategories[2];
          appBarTitle = new Text(title);
          search = new Icon(Icons.search);
          filterController.clear();
          indexNavBar = 2;
          updateScreen();
          break;
        case 3:
          title = listCategories[3];
          appBarTitle = new Text(title);
          search = new Icon(Icons.search);
          filterController.clear();
          indexNavBar = 3;
          updateScreen();
          break;
        case 4:
          title = listCategories[4];
          appBarTitle = new Text(title);
          search = new Icon(Icons.search);
          filterController.clear();
          indexNavBar = 4;
          updateScreen();
          break;
      }
    });
  }

  BottomNavigationBar getBottomNavigationBar() {
    return BottomNavigationBar(
        onTap: onTapBottomNavigationBar,
        currentIndex: indexNavBar,
        items: [
          BottomNavigationBarItem(
              icon: new SvgPicture.asset(
                "assets/soup.svg",
                height: 24,
              ),
              title: Text(listCategories[0])),
          BottomNavigationBarItem(
              icon: new SvgPicture.asset(
                "assets/wedding-dinner.svg",
                height: 24,
              ),
              title: new Text(listCategories[1])),
          BottomNavigationBarItem(
              icon: new SvgPicture.asset(
                "assets/salad.svg",
                height: 24,
              ),
              title: new Text(listCategories[2])),
          BottomNavigationBarItem(
              icon: new SvgPicture.asset(
                "assets/birthday-cake.svg",
                height: 24,
              ),
              title: new Text(listCategories[3])),
          BottomNavigationBarItem(
              icon: new SvgPicture.asset(
                "assets/lemonade.svg",
                height: 24,
              ),
              title: new Text(listCategories[4]))
        ]);
  }

  void updateScreen() {
    final Future<Database> dbFuture = databaseHelper.initializeDatabase();
    dbFuture.then((database) {
      Future<List<Dish>> dishListFuture =
          databaseHelper.getDishesByCategory(title);
      dishListFuture.then((dishList) {
        setState(() {
          this.dishList = dishList;
          filterFullList = dishList;
        });
      });
    });
  }

  Widget appBar(Widget appBarTitle) {
    return AppBar(
      title: appBarTitle, // = new Text(title),
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
      ],
    );
  }

  void _onClickAdd() {
    Navigator.of(context).pushNamed('/addDish');
  }

  void onClickPopupMenu(String action) {
    if (action == popupItems[0]) {
      onClickUpdateDish();
    } else if (action == popupItems[1]) {
      onClickDeleteDish();
    }
  }

  void onClickUpdateDish() {
    showUpdateDishScreen();
  }

  void onClickDeleteDish() {
    showSnackbarForDelete();
  }

  void showSnackbarForDelete() {
    final snackbar = new SnackBar(
      content: Text("Do you really want to delete"
          " dish?"),
      action: SnackBarAction(label: 'Yes', onPressed: clickOnSnackbar),
    );
    Scaffold.of(contextSnackbar).showSnackBar(snackbar);
  }

  void clickOnSnackbar() {
    deleteDish(id);
  }

  void deleteDish(int id) async {
    int result = await databaseHelper.deleteDish(id);
    if (result != 0) {
      print('Dish deleted Successfully');
      updateScreen();
    } else {
      print('Problem deleted dish');
    }
  }

  void showUpdateDishScreen() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => new UpdateDish(dish)));
  }

  void showCookingScreen(Dish dish) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => new CookingDish((dish))));
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
              hintText: ''
                  'Sea'
                  'rch...',
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
          dishList = getFilterList(filterController.text);
        });
      }
    });
  }

  List<Dish> getFilterList(String title) {
    List<Dish> filterList = new List();

    for (int i = 0; i < filterFullList.length; i++) {
      if (filterFullList[i].name.toLowerCase().contains(title.toLowerCase())) {
        filterList.add(filterFullList[i]);
      }
    }

    return filterList;
  }

  Widget getDishesWidget() {
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
                  child: Image.network(
                      "https://s3-us-west-1.amazonaws.com/powr/defaults/image-slider2.jpg"),
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
                        child: Text("COOK",
                            style: new TextStyle(
                                fontSize: 20.0, fontWeight: FontWeight.bold)),
                        onTap: () {
                          showCookingScreen(dishList[position]);
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

  Widget noDataAvailable() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(LocalizationEN.noDataAvailable),
          ],
        ),
      ],
    );
  }
}
