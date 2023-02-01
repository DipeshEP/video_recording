import 'package:flutter/material.dart';
import 'package:video/Screens/video_Play.dart';
 void main(){
   runApp(Myapp());
 }
 class Myapp extends StatelessWidget {
   const Myapp({Key? key}) : super(key: key);

   @override
   Widget build(BuildContext context) {
     return MaterialApp(
       title: "Video",
       theme: ThemeData(
         primaryColor: Colors.cyan,
       ),
       debugShowCheckedModeBanner: false,
       home:VideoPlay() ,
     );
   }
 }
