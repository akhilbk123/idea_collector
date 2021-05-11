import 'package:flutter/material.dart';

class Ideas extends StatefulWidget {
  @override
  _IdeasState createState() => _IdeasState();
}

class _IdeasState extends State<Ideas> {
  List<String> _text = ['Idea'];
  TextEditingController _c;
  List<int> listofwidgets = [];

  var i = 0;

  void additemtolist() {
    List<int> tempList = listofwidgets;
    tempList.add(1);
    setState(() {
      listofwidgets = tempList;
    });
  }

  cleartextfield() {
    _c.clear();
  }

  Widget _buildPopupDialog(BuildContext context) {
    return AlertDialog(
      contentPadding: const EdgeInsets.all(16.0),
      content: Row(
        children: [
          Expanded(
            child: TextField(
                autofocus: true,
                decoration: InputDecoration(
                    labelText: "Text", hintText: "Input Ideas Here"),
                controller: _c),
          ),
          SizedBox(height: 10.0),
          TextButton(
              onPressed: () {
                setState(() {
                  if (i == 0) {
                    this._text[i] = _c.text;
                  } else {
                    this._text.add(_c.text);
                  }
                });
                i = i + 1;
                cleartextfield();
                Navigator.pop(context);
              },
              child: Text("Save"))
        ],
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
                return Container(
                  // height: 200.0,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 10.0),
                    child: SizedBox(
                      height: 100,
                      child: Card(
                        elevation: 10.0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(40.0)),
                        child: ListTile(
                            onTap: () {
                              Navigator.pushNamed(context, '/milestones');
                            },
                            onLongPress: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) =>
                                    _buildPopupDialog(context),
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
                                          onPressed: () {},
                                          child: Icon(
                                            Icons.delete,
                                            color: Colors.grey[700],
                                          )),
                                      TextButton(
                                          onPressed: () {},
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
