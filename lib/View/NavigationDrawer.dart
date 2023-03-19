import 'package:flutter/material.dart';
import 'package:land_conversion_kodagu/utilities/constants.dart';

class NavigationDrawer extends StatelessWidget {
  const NavigationDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double sizedBoxHeight = MediaQuery.of(context).size.height * 0.020;
    return Drawer(
      elevation: 20.0,
      semanticLabel: 'Label',
      child: Material(
        color: Color.fromARGB(197, 240, 203, 203),
        child: ListView(
          padding: horizontalPadding,
          children: <Widget>[
            DrawerHeader(
              child: Image.asset("assets/images/logo.png"),
            ),
            SizedBox(height: sizedBoxHeight),
            buildMenuItem(
              text: 'Application Lists',
              icon: Icons.place_outlined,
              onClicked: () => selectedItem(context, 0),
            ),
            SizedBox(height: sizedBoxHeight),
            buildMenuItem(
              text: 'Pending Applications',
              icon: Icons.nature_outlined,
              onClicked: () => selectedItem(context, 1),
            ),
            SizedBox(height: sizedBoxHeight),
            buildMenuItem(
              text: 'VA Circle',
              icon: Icons.account_tree,
              onClicked: () => selectedItem(context, 2),
            ),
            SizedBox(height: sizedBoxHeight),
            buildMenuItem(
              text: 'Profile',
              icon: Icons.person,
              onClicked: () => selectedItem(context, 5),
            ),
            SizedBox(height: sizedBoxHeight),
            buildMenuItem(
              text: 'Settings',
              icon: Icons.settings,
            ),
            SizedBox(height: sizedBoxHeight),
            Divider(
              color: secondaryColorDark,
            ),
          ],
        ),
      ),
    );
  }

  buildMenuItem({
    required String text,
    required IconData icon,
    VoidCallback? onClicked,
  }) {
    // final color = secondaryColor;
    return ListTile(
      leading: Icon(icon, color: primaryColor),
      title: Text(text, style: TextStyle(color: textColor)),
      hoverColor: Color.fromARGB(227, 149, 117, 117),
      onTap: onClicked,
    );
  }

  selectedItem(BuildContext context, int index) {
    switch (index) {
      // case 0:
      //   Navigator.of(context).push(
      //     MaterialPageRoute(
      //       builder: (context) => DataTableDB(),
      //     ),
      //   );
      //   break;
      // case 1:
      //   Navigator.of(context).push(
      //     MaterialPageRoute(
      //       builder: (context) => HobliScreen(),
      //     ),
      //   );
      //   break;
      // case 2:
      //   Navigator.of(context).push(
      //     MaterialPageRoute(
      //       builder: (context) => VACircleScreen(),
      //     ),
      //   );
      //   break;
      // case 3:
      //   Navigator.of(context).push(MaterialPageRoute(builder: (context)=>VillageScreen(),));
      //   break;
      // case 4:
      //   Navigator.of(context).push(MaterialPageRoute(builder: (context)=>PoliceStationScreen(),));
      //   break;
      // case 5:
      //   Navigator.of(context).push(MaterialPageRoute(builder: (context)=>AdminLoginPage(),));
      //   break;
    }
  }
}
