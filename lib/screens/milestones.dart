import 'dart:convert';

import 'package:flutter/material.dart';
import 'ideas.dart';
import 'package:idea_collector/Funcions/usermodel.dart';
import 'package:http/http.dart' as http;

class Milestones extends StatefulWidget {
  @override
  _MilestonesState createState() => _MilestonesState();
}

class _MilestonesState extends State<Milestones> {
  List<int> listcount = [];
  List<bool> _status = [];
  List<String> _text1 = ['Add Milestones'];
  TextEditingController _c1;
  var _state1 = 0;
  // Map<String, dynamic> data;
  String idea;

  var j = 0;

  void createList() {
    List<int> tempL = listcount;
    tempL.add(1);
    setState(() {
      listcount = tempL;
    });
  }

  cleartext() {
    _c1.clear();
  }

  Future<Usermodel> createideas(String milestone, String idea) async {
    // final String apiurl = 'http://127.0.0.1:8000/api/ideas/';

    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': "*/*",
      'connection': 'keep-alive',
      'Accept-Encoding': 'gzip, deflate, br'
    };

    var body = jsonEncode({"milestones": milestone, "Idea": idea});

    final response = await http.post(
        Uri.http('10.0.2.2:8000', '/api/milestones/'),
        headers: headers,
        body: body);

    if (response.statusCode == 201) {
      print("Success");
      final String responseString = response.body;

      return usermodelFromJson(responseString);
    } else {
      return null;
    }
  }

  Widget _buildPopup1Dialog(BuildContext context, [int index]) {
    // final Map<String, dynamic> data_1 = ModalRoute.of(context).settings.arguments;

    onGenerateRoute:
    (settings) {
      final Map<String, dynamic> args = settings.arguments;

      return args;
    };
    // idea = data["data"];
    return AlertDialog(
      contentPadding: const EdgeInsets.all(16.0),
      content: Row(
        children: [
          Expanded(
            child: TextField(
                autofocus: true,
                decoration: InputDecoration(
                    labelText: "Text", hintText: "Input Milestones Here"),
                controller: _c1),
          ),
          SizedBox(height: 10.0),
          TextButton(
              onPressed: () async {
                final milestone = _c1.text;
                // final idea = _c.text;
                final Usermodel user =
                    await createideas(milestone, args["data"]);

                setState(() {
                  if (_state1 != 0) {
                    this._text1[index] = _c1.text;
                  } else {
                    if (j == 0) {
                      this._text1[j] = _c1.text;
                    } else {
                      this._text1.add(_c1.text);
                    }
                  }
                });
                j = j + 1;
                cleartext();
                Navigator.pop(context);
              },
              child: Text("Save"))
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _c1 = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Milestones"),
        centerTitle: true,
        backgroundColor: Colors.amber[600],
      ),
      body: Container(
          child: ListView.builder(
        itemCount: listcount.length,
        itemBuilder: (context, index) {
          return Container(
              child: Padding(
            padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
            child: Card(
              child: CheckboxListTile(
                value: _status[index],
                title: Text(_text1[index]),
                onChanged: (bool check) {
                  setState(() {
                    _status[index] = check;
                  });
                },
                subtitle: Column(
                  children: [
                    Container(
                      child: Row(
                        children: [
                          TextButton(
                              onPressed: () {
                                setState(() {
                                  _text1.removeAt(index);
                                });
                              },
                              child:
                                  Icon(Icons.delete, color: Colors.grey[700])),
                          TextButton(
                              onPressed: () {
                                _state1 = 1;
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) =>
                                        _buildPopup1Dialog(context, index));
                              },
                              child: Icon(Icons.edit, color: Colors.grey[700]))
                        ],
                      ),
                    )
                  ],
                ),
              ),
              margin: EdgeInsets.all(1.0),
              color: Colors.grey[100],
            ),
          ));
        },
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _state1 = 0;
          createList();
          showDialog(
              context: context,
              builder: (BuildContext context) => _buildPopup1Dialog(context));

          setState(() {
            _status = List<bool>.filled(listcount.length, false);
          });
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.amber[600],
      ),
    );
  }
}
