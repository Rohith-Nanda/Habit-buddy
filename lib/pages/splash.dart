import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:habbit_tracjer/pages/Homepage.dart';
import 'package:lottie/lottie.dart';

class splashscreen extends StatefulWidget {
  const splashscreen({super.key});

  @override
  State<splashscreen> createState() => _splashscreenState();
}

class _splashscreenState extends State<splashscreen> {
  void initState() {
    navigatetohome();
    super.initState();
  }


  void navigatetohome() async{
     await Future.delayed(Duration(milliseconds: 3500));
     Navigator.of(context).pushReplacement(MaterialPageRoute(builder: ((context) {
       return Homepage();
     })));
  }
  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.white,
      body:   
         Column(
          mainAxisAlignment: MainAxisAlignment.center,
           children: [
             Center(child: Lottie.network("https://assets10.lottiefiles.com/packages/lf20_fbpbl0qw.json")),
             Text("HABIT BUDDY",style: GoogleFonts.adamina(fontSize: 38,fontWeight: FontWeight.bold),)
           ],
         )
    );
  }
}