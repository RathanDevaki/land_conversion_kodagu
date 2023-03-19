import 'package:flutter/material.dart';

class Toggle extends StatefulWidget {
  const Toggle({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<Toggle> {
  String? _mainObjective;
  String? _subObjective;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dropdown Demo"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 20),
          Text("Main Objective"),
          SizedBox(height: 10),
          DropdownButton<String>(
            value: _mainObjective,
            onChanged: (String? newValue) {
              setState(() {
                _mainObjective = newValue;
                _subObjective = null;
              });
            },
            items: <String>['A', 'B', 'C']
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
          SizedBox(height: 20),
          if (_mainObjective != null)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Sub Objective"),
                SizedBox(height: 10),
                DropdownButton<String>(
                  value: _subObjective,
                  onChanged: (String? newValue) {
                    setState(() {
                      _subObjective = newValue;
                    });
                  },
                  items: (_mainObjective == 'A')
                      ? <String>['A1', 'A2']
                          .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList()
                      : (_mainObjective == 'B')
                          ? <String>['B1', 'B2']
                              .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList()
                          : [],
                ),
              ],
            ),
        ],
      ),
    );
  }
}
