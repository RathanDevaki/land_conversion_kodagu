import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utilities/constants.dart';

class ApplicationView extends StatefulWidget {
  const ApplicationView({super.key});

  @override
  State<ApplicationView> createState() => _ApplicationViewState();
}

class _ApplicationViewState extends State<ApplicationView> {
  late String name,
      spouse,
      address,
      mobile,
      taluk,
      hobli,
      village,
      survey_num,
      total_area,
      converting,
      main_obj,
      sub_obj;

  @override
  void initState() {
    super.initState();
    shared();
  }

  Future<void> shared() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      name = prefs.getString('name')!;
      spouse = prefs.getString('spouse')!;
      address = prefs.getString('address')!;
      mobile = prefs.getString('mobile')!;
      taluk = prefs.getString('taluk')!;
      hobli = prefs.getString('hobli')!;
      village = prefs.getString('village')!;
      survey_num = prefs.getString('survey_number')!;
      total_area = prefs.getString('total_area')!;
      converting = prefs.getString('converting')!;
      main_obj = prefs.getString('main_obj')!;
      sub_obj = prefs.getString('sub_obj')!;
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width * 1.0;
    return Scaffold(
      backgroundColor: Color.fromRGBO(226, 223, 217, 1),
      body: Center(
        child: Container(
          width: width,
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.0),
              color: tableBackground),
          child: SingleChildScrollView(
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(width: 5, color: Colors.black12),
                borderRadius: BorderRadius.all(Radius.circular(50)),
              ),
              child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    FittedBox(
                      child: Row(
                        children: [
                          Image.asset(
                            "assets/images/logo.png",
                            width: 120,
                            height: 120,
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Text(
                            "Your Application Successfully Submitted:",
                            style: headingTextStyle,
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 4),
                          ),
                        ],
                      ),
                    ),
                    const Divider(
                      color: Colors.black54,
                      thickness: 1,
                    ),
                    const SizedBox(),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 22),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Expanded(
                            child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Text(
                                  'Applicant Name: ',
                                  style: const TextStyle(fontSize: 20),
                                )),
                          ),
                          Expanded(
                            child: Text(name,
                                style: const TextStyle(fontSize: 20)),
                          ),
                        ],
                      ),
                    ),
                    /////

                    const SizedBox(),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 22),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Expanded(
                            child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Text(
                                  'Father/Spouse Name : ',
                                  style: const TextStyle(fontSize: 20),
                                )),
                          ),
                          Expanded(
                            child: Text(spouse,
                                style: const TextStyle(fontSize: 20)),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 22),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Expanded(
                            child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Text(
                                  'Complete Address : ',
                                  style: const TextStyle(fontSize: 20),
                                )),
                          ),
                          Expanded(
                            child: Text(address,
                                style: const TextStyle(fontSize: 20)),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 22),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Expanded(
                            child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Text(
                                  'Mobile Number : ',
                                  style: const TextStyle(fontSize: 20),
                                )),
                          ),
                          Expanded(
                            child: Text(mobile,
                                style: const TextStyle(fontSize: 20)),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 22),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Expanded(
                            child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Text(
                                  'Taluk : ',
                                  style: const TextStyle(fontSize: 20),
                                )),
                          ),
                          Expanded(
                            child: Text(taluk,
                                style: const TextStyle(fontSize: 20)),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 22),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Expanded(
                            child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Text(
                                  'Hobli: ',
                                  style: const TextStyle(fontSize: 20),
                                )),
                          ),
                          Expanded(
                            child: Text(hobli,
                                style: const TextStyle(fontSize: 20)),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 22),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Expanded(
                            child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Text(
                                  'Village: ',
                                  style: const TextStyle(fontSize: 20),
                                )),
                          ),
                          Expanded(
                            child: Text(village,
                                style: const TextStyle(fontSize: 20)),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 22),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Expanded(
                            child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Text(
                                  'Survey Number: ',
                                  style: const TextStyle(fontSize: 20),
                                )),
                          ),
                          Expanded(
                            child: Text(survey_num,
                                style: const TextStyle(fontSize: 20)),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 22),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Expanded(
                            child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Text(
                                  'Total Land Area : ',
                                  style: const TextStyle(fontSize: 20),
                                )),
                          ),
                          Expanded(
                            child: Text(total_area,
                                style: const TextStyle(fontSize: 20)),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 22),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Expanded(
                            child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Text(
                                  'Area sought for land conversion : ',
                                  style: const TextStyle(fontSize: 20),
                                )),
                          ),
                          Expanded(
                            child: Text(converting,
                                style: const TextStyle(fontSize: 20)),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 22),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Expanded(
                            child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Text(
                                  'Main Objective : ',
                                  style: const TextStyle(fontSize: 20),
                                )),
                          ),
                          Expanded(
                            child: Text(main_obj,
                                style: const TextStyle(fontSize: 20)),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 22),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Expanded(
                            child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Text(
                                  'Sub Objective: ',
                                  style: const TextStyle(fontSize: 20),
                                )),
                          ),
                          Expanded(
                            child: Text(sub_obj,
                                style: const TextStyle(fontSize: 20)),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(),
                    // Padding(
                    //   padding: const EdgeInsets.symmetric(horizontal: 22),
                    //   child: Row(
                    //     mainAxisSize: MainAxisSize.min,
                    //     children: <Widget>[
                    //       Expanded(
                    //         child: Padding(
                    //             padding: const EdgeInsets.all(20.0),
                    //             child: Text(
                    //               'Adhar Submitted?: ',
                    //               style: const TextStyle(fontSize: 20),
                    //             )),
                    //       ),
                    //       Expanded(
                    //         child: Text('No',
                    //             style: const TextStyle(fontSize: 20)),
                    //       ),
                    //     ],
                    //   ),
                    // ),
                  ]),
            ),
          ),
        ),
      ),
    );
  }
}
