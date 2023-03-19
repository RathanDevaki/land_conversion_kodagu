import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';

import '../utilities/constants.dart';
import 'drawer.dart';

class FlutterAppbar extends StatefulWidget {
  const FlutterAppbar({Key? key}) : super(key: key);

  @override
  State<FlutterAppbar> createState() => _FlutterAppbarState();
}

class _FlutterAppbarState extends State<FlutterAppbar> {
  @override
  Widget build(BuildContext context) {
    const Color navLinkColor = Color(0xFF6E7274);
    return AppBar(
        iconTheme: const IconThemeData(
          color: navLinkColor,
          size: 20,
        ),
        backgroundColor: Colors.white,
        actions: [
          FlutterSwitch(
            width: 110.0,
            height: 35.0,
            valueFontSize: 20.0,

            ///toggleSize: 45.0,
            value: status,
            activeColor: primaryColor,
            borderRadius: 4.0,
            padding: 4.0,
            activeText: 'ಕನ್ನಡ',
            inactiveText: 'English',
            showOnOff: true,
            onToggle: (val) {
              setState(() {
                status = val;
                //language_setter(status);
              });
            },
          ),
        ],
        title: Row(
          children: [
            FlutterHomeImage(),
            Text(
              !status
                  ? 'ಭೂ ಪರಿವರ್ತನೆಯ ನಿರಾಕ್ಷೇಪಣಾ ಪತ್ರ ಪಡೆಯುವ ಬಗ್ಗೆ ಅರ್ಜಿ '
                  : 'Application for NOC for land conversion ',
              style: headingTextStyle,
            ),
          ],
        ));
  }
}
