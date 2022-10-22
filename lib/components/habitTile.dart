import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';

class HabitTile extends StatelessWidget {
  final String habittile;
  final bool iscompleted;
  final Function(bool?)? onChanged;
  void Function(BuildContext)? updatetapped;
  void Function(BuildContext)? deletetapped;
  HabitTile({required this.habittile,required this.iscompleted,required this.onChanged, required this.updatetapped,required this.deletetapped});
  
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8,horizontal: 16),
      child: Slidable(
        endActionPane: ActionPane(
          motion:StretchMotion(),
          children: [
           SlidableAction(
          onPressed: updatetapped,
           backgroundColor: Colors.green.shade900,
           icon: Icons.create_outlined,
           borderRadius: BorderRadius.circular(8),
           ),
            SlidableAction(onPressed: deletetapped,
           backgroundColor: Colors.red.shade300,
           icon: Icons.delete,
           borderRadius: BorderRadius.circular(8),
           )
          ],
        ),
        child: Container(
          
          decoration: BoxDecoration(
            color: iscompleted?Colors.green[400]:Colors.grey[600],
            borderRadius: BorderRadius.circular(8)
          ),
          padding: EdgeInsets.symmetric(vertical: 20,horizontal: 6),
          child: Row(
            children: [
              Checkbox(value: iscompleted, onChanged: onChanged),
              Expanded(
                child: Text(habittile,style: GoogleFonts.aBeeZee(fontSize: 14,color: Colors.white,fontWeight: FontWeight.w200
                ),maxLines: 1,overflow: TextOverflow.clip,),
              ),
              Row(
                children: [
                  Icon(Icons.arrow_left,color: Colors.white,)
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}