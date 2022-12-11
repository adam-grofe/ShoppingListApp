import 'package:flutter/material.dart';
import 'package:grocery_list/utils/button.dart';
import 'package:grocery_list/utils/button.dart';

class AddItemDialogue extends StatelessWidget {
  final controller;
  VoidCallback onSave;
  VoidCallback onCancel;

  AddItemDialogue({
    super.key,
    required this.controller,
    required this.onSave,
    required this.onCancel,
  });

  void onSubmitted(String str) {
    onSave();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.blueGrey,
      content: Container(
        height: 200,
        child: Column( 
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextField(
              controller: controller,
              onSubmitted: onSubmitted,
              decoration: InputDecoration( 
                border: OutlineInputBorder(),
                hintText: "Add Item"
              ),
            ),

            // Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Save button
                MyButton(text: "Save", onPressed: onSave),
              
                // Cancel Button
                MyButton(text: "Cancel", onPressed: onCancel)
            ],)
          ]
        ),
      ),
    );
  }
}