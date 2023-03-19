import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';

import 'package:routemaster/routemaster.dart';

import '../utilities/constants.dart';
import '../utilities/typography.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue[700],
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const FlutterHomeImage(),
                    const Spacer(),
                    IconButton(
                        onPressed: () => Navigator.of(context).pop(),
                        icon: const Icon(
                          Icons.close,
                          color: Colors.white,
                          size: 18,
                        ))
                  ],
                ),
                const SizedBox(
                  height: 40,
                ),
                const MenuItem(
                  path: "/docs",
                  name: "Docs",
                  isInDrawer: true,
                ),
                const SizedBox(
                  height: 20,
                ),
                const MenuItem(
                  path: "/showcase",
                  name: "Showcase",
                  isInDrawer: true,
                ),
                const SizedBox(
                  height: 20,
                ),
                const MenuItem(
                  path: "/development",
                  name: "Development",
                  isInDrawer: true,
                ),
                const SizedBox(
                  height: 20,
                ),
                const MenuItem(
                  path: "/ecosystem",
                  name: "Ecosystem",
                  isInDrawer: true,
                )
              ],
            ),
            Column(
              children: const [
                Spacer(),
                GetStartedButton(inDrawer: true),
                SizedBox(
                  height: 20,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

class MenuItem extends StatelessWidget {
  final String path;
  final String name;
  final bool isInDrawer;
  const MenuItem(
      {Key? key,
      required this.path,
      required this.isInDrawer,
      required this.name})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          Routemaster.of(context).replace(path);
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(name,
              style: TextStyle(
                  fontSize: 15,
                  color: isInDrawer
                      ? Colors.white
                      : (RouteData.of(context).path.contains(path))
                          ? Colors.blue
                          : Colors.grey[700],
                  fontFamily: fontFamily)),
        ),
      ),
    );
  }
}

class GetStartedButton extends StatefulWidget {
  final bool inDrawer;
  const GetStartedButton({Key? key, required this.inDrawer}) : super(key: key);

  @override
  State<GetStartedButton> createState() => _GetStartedButtonState();
}

class _GetStartedButtonState extends State<GetStartedButton> {
  @override
  Widget build(BuildContext context) {
    return FlutterSwitch(
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
    );
  }
}

class FlutterHomeImage extends StatelessWidget {
  const FlutterHomeImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          Routemaster.of(context).replace('/home');
        },
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 5, 16, 5),
          child: Image.asset("assets/images/logo.png",
              height: 37, fit: BoxFit.contain),
        ),
      ),
    );
  }
}
