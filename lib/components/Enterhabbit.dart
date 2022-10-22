import 'package:flutter/material.dart';

class AddHabbit extends StatelessWidget {
  final controller;
  final VoidCallback onChanged;
  final VoidCallback  oncancel;

  const AddHabbit({super.key, this.controller, required this.onChanged, required this.oncancel});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      content: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          hintText: "enter a habbit",
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
    );
  }
}