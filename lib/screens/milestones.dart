import 'package:flutter/material.dart';

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

  Widget _buildPopup1Dialog(BuildContext context, [int index]) {
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
              onPressed: () {
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
