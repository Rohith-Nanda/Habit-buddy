import 'package:habbit_tracjer/daytime/date_time.dart';
import 'package:hive_flutter/adapters.dart';

final _myBox = Hive.box("habit_database");

class HabitDatabase{
  Map<DateTime,int> heatmapdataset = {};
  List todayshabbit = [];
  //create data
  void createdata(){
      // todayshabbit = [
      //   ["run",false],
      //   ["walk",false]
      // ];

      _myBox.put("Start_Date", todaysDateformatted());
  }
  //load data
  void loaddata(){
      if(_myBox.get(todaysDateformatted())==null){
        todayshabbit = _myBox.get("CURRENT_HABIT_LIST");
        for(int i=0;i<todayshabbit.length;i++){
        todayshabbit[i][1] = false;
      }
      }
      else{
        todayshabbit = _myBox.get(todaysDateformatted());
      }
  }
  //update data
  void updatedata(){
    //update todays entry

    _myBox.put(todaysDateformatted(),todayshabbit);
    _myBox.put("CURRENT_HABIT_LIST", todayshabbit);
    calculatehabbitcompletedperc();
    loadHeatMap();
  }

  void calculatehabbitcompletedperc(){
     int countCompleted = 0;
     for(int i =0;i<todayshabbit.length;i++){
         if(todayshabbit[i][1] == true){
          countCompleted++;
         }
     }
     
     String percent = todayshabbit.isEmpty?'0.0':(countCompleted/todayshabbit.length).toStringAsFixed(1);
     _myBox.put("PERCENTAGE_SUMMARY_${todaysDateformatted()}", percent);
  }


void loadHeatMap() {
    DateTime startDate = createDateTimeObject(_myBox.get("Start_Date"));

    // count the number of days to load
    int daysInBetween = DateTime.now().difference(startDate).inDays;

    // go from start date to today and add each percentage to the dataset
    // "PERCENTAGE_SUMMARY_yyyymmdd" will be the key in the database
    for (int i = 0; i < daysInBetween + 1; i++) {
      String yyyymmdd = convertDateTimeToString(
        startDate.add(Duration(days: i)),
      );

      double strengthAsPercent = double.parse(
        _myBox.get("PERCENTAGE_SUMMARY_$yyyymmdd") ?? "0.0",
      );

      // split the datetime up like below so it doesn't worry about hours/mins/secs etc.

      // year
      int year = startDate.add(Duration(days: i)).year;

      // month
      int month = startDate.add(Duration(days: i)).month;

      // day
      int day = startDate.add(Duration(days: i)).day;

      final percentForEachDay = <DateTime, int>{
        DateTime(year, month, day): (10 * strengthAsPercent).toInt(),
      };
      heatmapdataset.addEntries(percentForEachDay.entries);
      print(heatmapdataset);
    }
  }
}
