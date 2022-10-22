import 'package:flutter/material.dart';

class MyFloatingActionButton extends StatelessWidget {
  void Function()? onchanged;
  MyFloatingActionButton({super.key,required this.onchanged});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(onPressed: onchanged,
    backgroundColor: Colors.white,
    child: Icon(Icons.add,color: Colors.black,),);
  }
}