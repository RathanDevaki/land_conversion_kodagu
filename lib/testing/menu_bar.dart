import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:routemaster/routemaster.dart';

import '../utilities/typography.dart';
import 'drawer.dart';

class MenuBar extends StatelessWidget {
  const MenuBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 66,
      decoration: const BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(color: Color(0x1A000000), offset: Offset(0, 2), blurRadius: 4)
      ]),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: const <Widget>[
          Spacer(),
          ResponsiveVisibility(
              visible: false,
              visibleWhen: [Condition.largerThan(name: MOBILE)],
              child: MenuItem(
                path: "/docs",
                name: "Docs",
                isInDrawer: false,
              )),
          ResponsiveVisibility(
              visible: false,
              visibleWhen: [Condition.largerThan(name: MOBILE)],
              child: MenuItem(
                path: "/showcase",
                name: "Showcase",
                isInDrawer: false,
              )),
          ResponsiveVisibility(
              visible: false,
              visibleWhen: [Condition.largerThan(name: MOBILE)],
              child: MenuItem(
                path: "/development",
                name: "Development",
                isInDrawer: false,
              )),
          ResponsiveVisibility(
              visible: false,
              visibleWhen: [Condition.largerThan(name: MOBILE)],
              child: MenuItem(
                path: "/ecosystem",
                name: "Ecosystem",
                isInDrawer: false,
              )),
          ResponsiveVisibility(
            visible: false,
            visibleWhen: [Condition.largerThan(name: MOBILE)],
            child: Padding(
              padding: EdgeInsets.only(left: 8, right: 0),
              child: GetStartedButton(
                inDrawer: false,
              ),
            ),
          ),
        ],
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
