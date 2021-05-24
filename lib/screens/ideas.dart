import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:idea_collector/Funcions/usermodel.dart';

class Ideas extends StatefulWidget {
  @override
  _IdeasState createState() => _IdeasState();
}

class _IdeasState extends State<Ideas> {
  //List to Store Tile text data
  List<String> _text = ['Idea'];
  TextEditingController _c;
  var _state1 = 0;

  //List to store the number od widgets created
  List<int> listofwidgets = [];

  var i = 0;

//Function that counts the number of tiles
  void additemtolist() {
    List<int> tempList = listofwidgets;
    tempList.add(1);
    setState(() {
      listofwidgets = tempList;
    });
  }

//To clear the textfield box

  cleartextfield() {
    _c.clear();
  }

  Future<Usermodel> createideas(String ideas) async {
    final String apiurl = 'http://127.0.0.1:8000/api/ideas/';

    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': "*/*",
      'connection': 'keep-alive',
      'Accept-Encoding': 'gzip, deflate, br'
    };

    var body = jsonEncode({"ideas": ideas});

    final response = await http.post(Uri.http('10.0.2.2:8000', '/api/ideas/'),
        headers: headers, body: body);

    if (response.statusCode == 201) {
      print("Success");
      final String responseString = response.body;

      return usermodelFromJson(responseString);
    } else {
      return null;
    }
  }

//AlertBox Function
  Widget _buildPopupDialog(BuildContext context, [int index]) {
    return AlertDialog(
      contentPadding: const EdgeInsets.all(10.0),
      content: Container(
        height: 200.0,
        child: Column(
          children: [
            Expanded(
              child: TextField(
                  autofocus: true,
                  decoration: InputDecoration(
                      labelText: "Text", hintText: "Input Ideas Here"),
                  controller: _c),
            ),
            TextButton(
                onPressed: () async {
                  final ideas = _c.text;
                  final Usermodel user = await createideas(ideas);

                  setState(() {
                    if (_state1 != 0) {
                      this._text[index] = _c.text;
                    } else {
                      if (i == 0) {
                        this._text[i] = _c.text;
                      } else {
                        this._text.add(_c.text);
                      }
                    }
                  });
                  i = i + 1;
                  cleartextfield();
                  Navigator.pop(context);
                },
                child: Text("Save"))
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    _c = TextEditingController();

    super.initState();
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
                final item = _text[index];

                return Container(
                  // height: 200.0,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 10.0),
                    child: SizedBox(
                      height: 100,
                      child: Card(
                        key: Key(item),
                        elevation: 10.0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(40.0)),
                        child: ListTile(
                            onTap: () {
                              Navigator.pushNamed(context, '/milestones');
                            },
                            onLongPress: () {
                              _state1 = 1;
                              showDialog(
                                context: context,
                                builder: (BuildContext context) =>
                                    _buildPopupDialog(context, index),
                              );
                            },
                            title: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                _text[index],
                                style: TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            subtitle: Column(
                              children: [
                                Container(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      TextButton(
                                          onPressed: () {
                                            setState(() {
                                              _text.removeAt(index);
                                            });
                                          },
                                          child: Icon(
                                            Icons.delete,
                                            color: Colors.grey[700],
                                          )),
                                      TextButton(
                                          onPressed: () {
                                            _state1 = 1;
                                            showDialog(
                                                context: context,
                                                builder:
                                                    (BuildContext context) =>
                                                        _buildPopupDialog(
                                                            context, index));
                                          },
                                          child: Icon(
                                            Icons.edit,
                                            color: Colors.grey[700],
                                          ))
                                    ],
                                  ),
                                )
                              ],
                            )),
                        color: Colors.grey[300],
                        margin: EdgeInsets.all(5.0),
                      ),
                    ),
                  ),
                );
              })),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            _state1 = 0;
            additemtolist();
            showDialog(
              context: context,
              builder: (BuildContext context) => _buildPopupDialog(context),
            );
          },
          child: const Icon(Icons.add),
          backgroundColor: Colors.amber[600]),
    );
  }
}
