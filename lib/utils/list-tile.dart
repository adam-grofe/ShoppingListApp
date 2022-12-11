import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class MyListTile extends StatelessWidget {
  final String tileText;
  final bool isChecked;
  Function(bool?)? onChanged;
  Function(BuildContext?) onDelete;

  final double _curve = 5;

  MyListTile({
    super.key,
    required this.tileText,
    required this.isChecked,
    required this.onChanged,
    required this.onDelete
    });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left:12, right:12, top:12),
      child: Slidable(
        endActionPane: ActionPane(
          motion: StretchMotion(), 
          children: [
            SlidableAction(
              onPressed: onDelete,
              icon: Icons.delete,
              backgroundColor: Colors.red,
              borderRadius: BorderRadius.circular(_curve),
            )
          ],
        ),
        child: Container(  
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.blue[200],
            borderRadius: BorderRadius.circular(_curve),
          ),
          child: Row(
            children: [
              // Checkbox
              Checkbox(value: isChecked, onChanged: onChanged, activeColor: Colors.black,),
        
              // Tile Text
              Text(
                tileText,
                style: TextStyle(
                  decoration: isChecked ? TextDecoration.lineThrough : TextDecoration.none 
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}