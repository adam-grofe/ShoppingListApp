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

  void addItem( String item ){
    itemsList.add([item,false]);
  }

  void loadData() {
    itemsList = _box.get("ITEMSLIST");
  
  }

  void update() {
    _box.put("ITEMSLIST",itemsList);
  }

  void removeChecked() {
    itemsList.removeWhere((element) => _checked(element));
  }

  bool _checked( List element ) {
    return element[1];
  }
}