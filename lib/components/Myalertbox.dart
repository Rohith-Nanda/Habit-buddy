import 'package:flutter/material.dart';

class Myalertbox extends StatelessWidget {
  final newcontroller;
  final oncancel;
  final onChanged;
  final String Hinttext;
  Myalertbox({super.key,required this.newcontroller,required this.oncancel,required this.onChanged, required this.Hinttext});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      
      backgroundColor: Colors.white,
      content: TextFormField(
        controller: newcontroller,
        decoration: InputDecoration(
          hintText: Hinttext,
          enabledBorder: OutlineInputBorder(borderSide:  BorderSide(color: Colors.black)),
          focusedBorder: OutlineInputBorder(borderSide:  BorderSide(color: Colors.green)),
          )
        ),
      actions: [
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,  
          children: [MaterialButton(onPressed: onChanged,
          color: Colors.green[500],
          elevation: 0,
          child: Text("save",style: TextStyle(color: Colors.black),),
          ),
          MaterialButton(onPressed: oncancel,
          color: Colors.green[500],
          elevation: 0,
          child: Text("cancel",style: TextStyle(color: Colors.black),),
          ),]),
        )
      ],
    );;
  }
}