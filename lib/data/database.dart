import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ListDatabase {

  // List to store items
  List itemsList = [];

  // Reference
  final _box = Hive.box('listBox');

  void createInitialList() {
    itemsList = [
      ["Apples", false],
      ["Cheese", false],
    ];
    update();
  }

  void loadData() {
    itemsList = _box.get("ITEMSLIST");
  }

  void addItem( String item ){
    itemsList.add([item,false]);
    update();
  }

  void removeItem( int index ) {
    itemsList.removeAt(index);
    update();
  }

  void flipBool( int index ) {
    itemsList[index][1] = !itemsList[index][1];
    update();
  }

  void removeChecked() {
    itemsList.removeWhere((element) => _checked(element));
    update();
  }

  bool _checked( List element ) {
    return element[1];
  }

  void update() {
    _box.put("ITEMSLIST",itemsList);
  }
}