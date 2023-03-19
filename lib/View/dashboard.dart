import 'package:flutter/material.dart';
import 'package:land_conversion_kodagu/utilities/constants.dart';

import '../utilities/responsive.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // drawer: Responsive.isDesktop(context) ? null : NavigationDrawer(),
      body: SafeArea(
        child: Row(
          children: [
            Container(),
            Expanded(
              flex: 5,
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      height: 30,
                    ),
                    Text(
                      "Deputy Commmissioner Kodagu",
                      textAlign: TextAlign.center,
                      style: headingTextStyle,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            offset: const Offset(
                              1.5,
                              1.0,
                            ),
                            blurRadius: 24.0,
                            spreadRadius: 4.0,
                          ), //BoxShadow
                        ],
                      ),
                      child: Image.asset("assets/images/logo.png"),
                    ),
                    SizedBox(
                      height: 60,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
