import 'package:flutter/material.dart';

class Ideas extends StatefulWidget {
  @override
  _IdeasState createState() => _IdeasState();
}

class _IdeasState extends State<Ideas> {

List <Widget> listofwidgets = [];

void additemtolist(){

  List <Widget> tempList = listofwidgets;
  tempList.add(Text("Iam Added"));
  setState(() {
    listofwidgets = tempList;
  });
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ideas'),
        backgroundColor: Colors.amber[600],
        centerTitle: true,
      ),
      body:Container(
        child:ListView(children: [
          Column(
            children: listofwidgets,
          ),
          FloatingActionButton(onPressed: (){
            additemtolist();
            
          },)

          
        ]
        ) ,
      
        
        )
      
             
    );
  }
}