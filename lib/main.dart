import 'package:flutter/material.dart';
import 'package:idea_collector/screens/ideas.dart';
import 'package:idea_collector/screens/milestones.dart';
import 'package:idea_collector/screens/welcome.dart';

void main() => runApp(MaterialApp(
  initialRoute: '/ideas',

  routes: {

    '/':(context) => Welcome(),
    '/ideas':(context) => Ideas(),
    '/milestones':(context) => Milestones()
    
    },
  
));

 