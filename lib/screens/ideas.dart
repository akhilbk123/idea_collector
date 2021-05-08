import 'package:flutter/material.dart';

class Ideas extends StatefulWidget {
  @override
  _IdeasState createState() => _IdeasState();
}

class _IdeasState extends State<Ideas> {
  List<Widget> listofwidgets = [];

  void additemtolist() {
    List<Widget> tempList = listofwidgets;
    tempList.add(Text("Iam Added"));
    setState(() {
      listofwidgets = tempList;
    });
  }

  void showmyTile() {}

  Future<void> _showTile() async {
    return showmyTile<void>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            contentPadding: const EdgeInsets.all(16.0),
            content: Row(
              children: [
                Expanded(
                  child: TextField(
                      autofocus: true,
                      decoration: InputDecoration(
                          labelText: "Text", hintText: "Input Ideas Here")),
                )
              ],
            ),
          );
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
      body: Container(
          child: ListView.builder(
              itemCount: listofwidgets.length,
              itemBuilder: (context, index) {
                return Container(
                  height: 100.0,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 10.0),
                    child: Card(
                      child: ListTile(
                          onTap: () {
                            _showTile;
                          },
                          title: Text('Ideas Please !!')),
                      color: Colors.grey[100],
                      margin: EdgeInsets.all(1.0),
                    ),
                  ),
                );
              })),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            additemtolist();
          },
          child: const Icon(Icons.add),
          backgroundColor: Colors.amber[600]),
    );
  }
}
