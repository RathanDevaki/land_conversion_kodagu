import 'package:flutter/material.dart';
import 'package:land_conversion_kodagu/View/application_form.dart';

class LoginPage1 extends StatelessWidget {
  @override
  Widget build(context) =>
      Scaffold(body: LayoutBuilder(builder: (context, constraints) {
        return AnimatedContainer(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
                  Color.fromRGBO(103, 211, 241, 0.702),
                  Color.fromARGB(255, 252, 254, 254),
                ],
              ),
              // color: Color.fromARGB(255, 231, 231, 226),
            ),
            duration: Duration(milliseconds: 500),
            padding:
                constraints.maxWidth < 500 ? EdgeInsets.zero : EdgeInsets.zero,
            child: Center(
              child: Container(
                // padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
                constraints: BoxConstraints(
                  maxWidth: 1000,
                ),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      blurRadius: 5.0,
                    ),
                  ],
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5.0),
                ),
                // child: Column(
                //     mainAxisAlignment: MainAxisAlignment.spaceAround,
                //     children: [
                //       Text("Welcome to the app, please log in"),
                //       TextField(
                //           decoration: InputDecoration(labelText: "username")),
                //       TextField(
                //           obscureText: true,
                //           decoration: InputDecoration(labelText: "password")),
                //       ElevatedButton(
                //           child: Text("Log in",
                //               style: TextStyle(color: Colors.white)),
                //           onPressed: () {
                //             // Navigator.pushReplacement(
                //             //   context,
                //             //   MaterialPageRoute(
                //             //     builder: (context) => ()
                //             //   )
                //             // );
                //           })
                //     ]),
                child: ApplicationForm(),
              ),
            ));
      }));
}
