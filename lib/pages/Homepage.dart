import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:habbit_tracjer/components/Myfb.dart';
import 'package:habbit_tracjer/components/habitTile.dart';
import 'package:habbit_tracjer/components/monthly_summary.dart';
import 'package:habbit_tracjer/data/habit_database.dart';
import 'package:hive_flutter/adapters.dart';
import '../components/Enterhabbit.dart';
import '../components/Myalertbox.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
 HabitDatabase db = HabitDatabase();
 final _mybox = Hive.box("habit_database");


 @override
  void initState() {
    if(_mybox.get("CURRENT_HABIT_LIST") == null){
       db.createdata();
    }
    else{
      db.loaddata();
    }

    db.updatedata();
    super.initState();
  }
  final _habitcontroller = TextEditingController();
  final _newhabbitcontoller = TextEditingController();
  void checkBoxtapped(bool? value,int ind){
      setState(() {
        db.todayshabbit[ind][1] = value!;
      });
      db.updatedata();
  }
  void Savenewhabbit(){
    setState(() {
      db.todayshabbit.add([_habitcontroller.text,false]);
    });
    _habitcontroller.clear();
    db.updatedata();
     Navigator.of(context).pop();
  }

  void cancelnewhabbit(){
    _habitcontroller.clear();
     Navigator.of(context).pop();
  }
  
  void addHabbit(){
      showDialog(context: context, builder: (context){
        return AddHabbit(
          controller: _habitcontroller,
        onChanged: Savenewhabbit,oncancel: cancelnewhabbit,);
      });
  }

  void savenewhabbit(int index){
    showDialog(context: context, builder: ((context) => Myalertbox(
      Hinttext: db.todayshabbit[index][0],
      newcontroller: _newhabbitcontoller, oncancel: cancelsave, onChanged: () => saveexisting(index))));
      db.updatedata();
  }
  void saveexisting(int index){
      setState(() {
        db.todayshabbit[index][0] = _newhabbitcontoller.text;
      });
      _newhabbitcontoller.clear();
      db.updatedata();
     Navigator.of(context).pop();
  }
  void cancelsave(){
    _newhabbitcontoller.clear();
     Navigator.of(context).pop();
  }
  void deletehabbit(int index){
      setState(() {
        db.todayshabbit.removeAt(index);
      });
      db.updatedata();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: MyFloatingActionButton(onchanged: addHabbit),
      backgroundColor: Colors.grey[900],
      body: ListView(
        children: [
          Center(child: Text("Habit Tracker",style: GoogleFonts.quintessential(color: Colors.white,fontSize: 26,fontWeight: FontWeight.bold))),
          MonthlySummary(datasets: db.heatmapdataset, startDate: _mybox.get("Start_Date")),
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
          itemCount: db.todayshabbit.length,
          itemBuilder: ((context, index) {
          return HabitTile(
            habittile: db.todayshabbit[index][0],
            iscompleted: db.todayshabbit[index][1],
            onChanged: (value){return checkBoxtapped(value,index);},
            updatetapped: (context){
              return savenewhabbit(index);
              },
            deletetapped: ((context) {
                return deletehabbit(index);
            }),
          );
      }))
        ],
      )
    );
  }
}