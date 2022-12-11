import 'package:flutter/material.dart';
import 'package:grocery_list/data/database.dart';
import 'package:grocery_list/utils/add-item-dialogue.dart';
import 'package:grocery_list/utils/list-tile.dart';
import 'package:grocery_list/utils/add-item-dialogue.dart';
import 'package:grocery_list/utils/button.dart';
import 'package:hive_flutter/hive_flutter.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  // Text Controller
  final _controller = TextEditingController();

  // Database Reference
  final ListDatabase db = ListDatabase();
  final _box = Hive.box("listBox");

  @override 
  void initState() {

    if( _box.get("ITEMSLIST") == null ){
      db.createInitialList();
    } else {
      db.loadData();
    }
    super.initState();
  }
  // Method to change box
  void checkBoxChanged(bool? value, int index) {
    setState((){
      db.itemsList[index][1] = !db.itemsList[index][1];
    });
    db.update();
  }

  // Save the New Item to the list
  void saveNewItem() {
    setState(() {
      db.itemsList.add([_controller.text,false]);
      _controller.clear();
    });
    Navigator.of(context).pop();
    db.update();
  }

  //Create New Item
  void createNewItem() {
    showDialog(
      context: context, 
      builder: (context) {
        return AddItemDialogue(
          controller: _controller,
          onSave: saveNewItem,
          onCancel: () => Navigator.of(context).pop(),
        );
      }
    );
  }

  // Delete Item
  void deleteItem(int index) {
    setState(() {
      db.itemsList.removeAt(index);
    });
     db.update();
  }

  void deleteChecked(){
    setState(() {
      db.removeChecked();
    });
    db.update();
  }


  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: 
        ListView.builder(
          itemCount: db.itemsList.length,
          itemBuilder: (context,index ){
            return MyListTile(
              tileText: db.itemsList[index][0], 
              isChecked: db.itemsList[index][1], 
              onChanged: (value) => checkBoxChanged(value,index),
              onDelete: (context) => deleteItem(index),
            );
          }
        ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,   
        children: [
          FloatingActionButton(
            onPressed: deleteChecked,
            tooltip: 'Delete All Checked Items',
            child: const Icon(Icons.delete),
          ), // This trailing comma makes auto-formatting nicer for build methods.
          const SizedBox(
            height: 24,
          ),
          FloatingActionButton(
            onPressed: createNewItem,
            tooltip: 'Add List Item',
            child: const Icon(Icons.add),
          ), // This trailing comma makes auto-formatting nicer for build methods.
        ],
      ),
    );
  }
}