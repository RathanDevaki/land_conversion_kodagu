import 'dart:core';
import 'dart:developer';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:intl/intl.dart';

import 'package:flutter/material.dart';
import 'package:land_conversion_kodagu/View/login_view.dart';
import 'package:land_conversion_kodagu/View/signUp_view.dart';
import 'package:land_conversion_kodagu/View/upload.dart';
import 'package:land_conversion_kodagu/services/application_services.dart';
import 'package:land_conversion_kodagu/testing/appbar.dart';
import 'package:land_conversion_kodagu/utilities/responsive.dart';
import 'package:responsive_framework/responsive_wrapper.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/model_user.dart';
import '../testing/menu_bar.dart';
import '../utilities/constants.dart';
import 'application_view.dart';
import 'package:file_picker/file_picker.dart';

class ApplicationForm extends StatefulWidget {
  const ApplicationForm({Key? key}) : super(key: key);

  @override
  State<ApplicationForm> createState() => _ApplicationFormState();
}

class _ApplicationFormState extends State<ApplicationForm> {
  late List<String> _taluk_map;
  FilePickerResult? pickedFile;
  var logoBase64;
  FilePickerResult? result;
  bool isChecked = false;

  final _formKey = GlobalKey<FormState>();
  static late TextEditingController applicant_name,
      c_spouse,
      c_address,
      c_mobile,
      c_survey_no,
      c_total_acre,
      c_total_cent,
      c_total_fcent,
      c_req_acre,
      c_req_cent,
      c_req_fcent,
      controller7,
      controller8,
      controller9,
      controller10,
      controller11,
      controller12;

  bool _visible = false;

  addStringToSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('stringValue', "abc");
  }

  bool sub = false;
  String? selectedSub;
  String? selectedMain;
  List<String> talukEn = ['Virajpet', 'Somwarpet', 'Madikeri'];
  List<String> taluk_ka = ['ವಿರಾಜಪೇಟೆ', 'ಸೋಮವಾರಪೇಟೆ', 'ಸೋಮವಾರಪೇಟೆ'];
  List<String> hobli__ = [
    'Balele',
    'Virajpet',
    'Kanoor',
    'Murnadu',
    'Bhethri',
    'Kushalanagar'
  ];
  List<String> village__ = ['Karike', 'Bhagamandla', 'Balugodu', 'Shettigeri'];

  List<String> main_objective_ka = ['ವಸತಿ', 'ವಾಣಿಜ್ಯ', 'ಕೈಗಾರಿಕೆ', 'ಗಣಿಗಾರಿಕೆ'];
  List<String> main_objective_en = ['Housing', 'Business', 'Ag', 'Mining'];

  List<String> housing = ['ವೈಯಕ್ತಿಕ', 'ಲೆಔಟ್', 'ಅಪಾರ್ಟ್ಮೆಂಟ್', 'ಇತರೆ'];

  List<String> commercial = ['Resort', 'Hotel'];
  List<String> sub_intension = [''];
  String? selectedTaluk;
  String? selectedHobli;
  String? selectedVillage;
  DateTime _selectedDate = DateTime.now();
  int count = 0;
  int _currentStep = 0;
  //bool status = false;
  static late String text_name,
      t_h1,
      t_bin,
      t_c_address,
      t_c_mobile,
      t_taluk,
      t_hobli,
      t_village,
      t_survey,
      t_total,
      t_requested,
      t_main,
      t_sub,
      t_mutation,
      t_main1,
      t_distance,
      t_docs,
      t_rtc = 'R.T.C',
      t_akar = 'Akar Bandh',
      t_adhar = 'Adhar Copy Submitted ?';

  //initializing
  @override
  void initState() {
    super.initState();
    language_setter(status);
    applicant_name = TextEditingController();
    c_spouse = TextEditingController();
    c_address = TextEditingController();
    c_mobile = TextEditingController();
    c_survey_no = TextEditingController();
    c_total_cent = TextEditingController();
    c_total_fcent = TextEditingController();
    c_total_acre = TextEditingController();
    c_req_acre = TextEditingController();
    c_req_cent = TextEditingController();
    c_req_fcent = TextEditingController();
    controller7 = TextEditingController();
    controller8 = TextEditingController();
    controller9 = TextEditingController();
    controller10 = TextEditingController();
    controller11 = TextEditingController();
    controller12 = TextEditingController();
  }

  void language_setter(bool status) {
    setState(() {
      if (status == false) {
        selectedTaluk = null;
        _taluk_map = List.from(taluk_ka);

        t_taluk = 'ತಾಲೂಕು :';
        t_hobli = 'ಹೋಬಳಿ:';
        t_village = 'ಗ್ರಾಮ :';
        t_survey = 'ಸರ್ವೆ ನಂ. :';
        t_total = 'ಜಮೀನಿನ ಒಟ್ಟು ವಿಸ್ತೀರ್ಣ :';
        t_requested = 'ಭೂ ಪರಿವರ್ತನೆಗೆ ಕೋರಿರುವ ವಿಸ್ತೀರ್ಣ :';
        t_main = 'ಭೂ ಪರಿವರ್ತನೆಯ ಉದ್ಧೇಶ :';
        t_main1 = 'ಮುಖ್ಯ ಉದ್ಧೇಶ :';
        t_sub = 'ಉಪ ಉದ್ಧೇಶ :';
        t_docs = 'ಅರ್ಜಿದಾರರು ಭೂ ಪರಿವರ್ತನೆ ಕೋರಿ ಸಲ್ಲಿಸಬೇಕಾದ ದಾಖಲೆಗಳು :';
        t_rtc = 'ಅರ್.ಟಿ.ಸಿ :';
        t_akar = 'ಆಕಾರ ಬಂದ್ :';
        t_adhar = 'ಆಧಾರ್ ಪ್ರತಿಯನ್ನು ಸಲ್ಲಿಸಲಾಗಿದೆಯೇ?';
        // t_mutation;
        // t_distance;

      } else {
        selectedTaluk = null;
        _taluk_map = List.from(talukEn);

        t_taluk = 'Taluk :';
        t_hobli = 'Hobli :';
        t_village = 'Village :';
        t_survey = 'Survey No. :';
        t_total = 'Total land Area :';
        t_requested = 'Area sought for land conversion :';
        t_main = 'Purpose of land conversion:';
        t_main1 = 'Main objective :';
        t_sub = 'Sub objective :';
        t_docs =
            'Documents to be submitted by the applicant seeking land conversion:';
        t_rtc = 'R.T.C';
        t_akar = 'Akar Bandh';
        t_adhar = 'Adhar Copy Submitted ?';
        // t_mutation;
        // t_distance;

      }
    });
  }

  // void _presentDatePicker() {
  //   showDatePicker(
  //     context: context,
  //     initialDate: DateTime.now(),
  //     firstDate: DateTime(2019),
  //     lastDate: DateTime.now(),
  //   ).then((pickedDate) {
  //     if (pickedDate == null) {
  //       log(pickedDate.toString());

  //       return;
  //     }
  //     setState(() {
  //       count = count + 1;
  //       _selectedDate = pickedDate;
  //     });
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    log(width.toString());
    return Scaffold(
      // appBar: ResponsiveWrapper.of(context).isSmallerThan(DESKTOP)
      //     ? const PreferredSize(
      //         preferredSize: Size(double.infinity, 60), child: FlutterAppbar())
      //     : const PreferredSize(
      //         preferredSize: Size(double.infinity, 66), child: MenuBar()),
      backgroundColor: Color.fromRGBO(226, 223, 217, 1),
      body: Center(
        child: Container(
          // width: width * 1,
          padding: EdgeInsets.all(30.0),
          decoration: BoxDecoration(
              //border: Border.all(width: 2),
              borderRadius: BorderRadius.circular(16.0),
              color: tableBackground),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Container(
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
                                !status
                                    ? 'ಭೂ ಪರಿವರ್ತನೆಯ ನಿರಾಕ್ಷೇಪಣಾ ಪತ್ರ ಪಡೆಯುವ ಬಗ್ಗೆ ಅರ್ಜಿ '
                                    : 'Application for NOC for land conversion ',
                                style: headingTextStyle,
                              ),
                              SizedBox(
                                width: width * 0.04,
                              ),
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
                                    language_setter(status);
                                  });
                                },
                              ),
                            ],
                          ),
                        ),

                        const Divider(
                          color: Colors.black54,
                          thickness: 1,
                        ),

                        const SizedBox(),

                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Expanded(
                              child: Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Text(
                                    !status
                                        ? 'ಅರ್ಜಿದಾರರ ಹೆಸರು :'
                                        : 'Applicant Name :',
                                    style: const TextStyle(fontSize: 20),
                                  )),
                            ),
                            Expanded(
                              child: TextFormField(
                                controller: applicant_name,
                                //  controller: applicant_name,
                                onEditingComplete: () {
                                  //  prefs.setString('stringValue', "abc");
                                },
                                decoration: InputDecoration(
                                  labelText: "",
                                  labelStyle: TextStyle(fontSize: 14),
                                  fillColor: Colors.amber,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(16.0),
                                    borderSide: const BorderSide(),
                                  ),
                                  //fillColor: Colors.green
                                ),
                                validator: (val) {
                                  if (val == null || val.isEmpty) {
                                    return "Please enter your name.";
                                  } else {
                                    return null;
                                  }
                                },
                                //keyboardType: TextInputType.multiline,
                                style: const TextStyle(),
                              ),
                            ),
                          ],
                        ),

                        //Guardian Field

                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.all(20.0),
                                child: Text(
                                    !status
                                        ? 'ಬಿನ್/ಕೋo :'
                                        : 'Father/Spouse name:',
                                    style: TextStyle(fontSize: 20)),
                              ),
                            ),
                            Expanded(
                              child: TextFormField(
                                //  controller: applicant_name,
                                onEditingComplete: () {
                                  print(applicant_name.text);
                                },
                                controller: c_spouse,
                                decoration: InputDecoration(
                                  labelText: "",
                                  labelStyle: TextStyle(fontSize: 18),
                                  fillColor: Colors.amber,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(16.0),
                                    borderSide: const BorderSide(),
                                  ),
                                  //fillColor: Colors.green
                                ),
                                validator: (val) {
                                  if (val == null || val.isEmpty) {
                                    return "Please enter Parent or Guardian Name.";
                                  } else {
                                    return null;
                                  }
                                },
                                //keyboardType: TextInputType.multiline,
                                style: const TextStyle(),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(),

                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.all(20.0),
                                child: Text(
                                  !status
                                      ? 'ಪೂರ್ಣ ವಿಳಾಸ :'
                                      : 'Complete Address :',
                                  style: TextStyle(fontSize: 20),
                                ),
                              ),
                            ),
                            Expanded(
                              child: TextFormField(
                                controller: c_address,
                                onEditingComplete: () {
                                  print(c_address.text);
                                },
                                decoration: InputDecoration(
                                  labelText: "",
                                  labelStyle: TextStyle(fontSize: 14),
                                  fillColor: Colors.amber,
                                  border: OutlineInputBorder(
                                    borderRadius:
                                        new BorderRadius.circular(16.0),
                                    borderSide: const BorderSide(),
                                  ),
                                  //fillColor: Colors.green
                                ),
                                validator: (val) {
                                  if (val == null || val.isEmpty) {
                                    return "Please enter your adress.";
                                  } else {
                                    return null;
                                  }
                                },
                                //keyboardType: TextInputType.multiline,
                                style: const TextStyle(),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(),

                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Text(
                                  !status
                                      ? 'ದೂರವಾಣಿ / ಮೊಬೈಲ್ ಸಂಖ್ಯೆ :'
                                      : 'Mobile :',
                                  style: TextStyle(fontSize: 20),
                                ),
                              ),
                            ),
                            Expanded(
                              child: TextFormField(
                                controller: c_mobile,
                                onEditingComplete: () {},

                                decoration: InputDecoration(
                                  labelText: "",
                                  labelStyle: TextStyle(fontSize: 14),
                                  fillColor: Colors.amber,
                                  border: OutlineInputBorder(
                                    borderRadius:
                                        new BorderRadius.circular(16.0),
                                    borderSide: const BorderSide(),
                                  ),
                                  //fillColor: Colors.green
                                ),
                                validator: (val) {
                                  if (val == null || val.isEmpty) {
                                    return "Please fill the details..";
                                  } else {
                                    return null;
                                  }
                                },
                                //keyboardType: TextInputType.multiline,
                                style: const TextStyle(),
                              ),
                            ),
                          ],
                        ),

                        //Taluk field
                        // ignore: unnecessary_new
                        new Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.all(20.0),
                                child: Text(
                                  t_taluk,
                                  style: TextStyle(fontSize: 20),
                                ),
                              ),
                            ),
                            Expanded(
                              child: StatefulBuilder(
                                builder: (BuildContext context,
                                    StateSetter dropDownState) {
                                  return DropdownButtonFormField<String>(
                                    elevation: 16,
                                    hint: Padding(
                                      padding: leftRightPadding,
                                      child: Text(!status
                                          ? 'ತಾಲೂಕನ್ನು ಆಯ್ಕೆ ಮಾಡಿ'
                                          : 'Select Taluk'),
                                    ),
                                    // taluk_names.map(buildMenuItem).toList()

                                    items: talukEn
                                        .map(
                                          (e) => DropdownMenuItem(
                                            value: e,
                                            child: Text(
                                              e.toString(),
                                            ),
                                          ),
                                        )
                                        .toList(), //taluk_.map(buildMenuItem).toList(),
                                    validator: (_selectedTaluk) {
                                      _selectedTaluk == null
                                          ? 'Please fill the details.'
                                          : null;
                                    },
                                    onChanged: (String? value_) =>
                                        dropDownState(() {
                                      selectedTaluk = null;
                                      selectedTaluk = value_;
                                    }),
                                    value: selectedTaluk,
                                  );
                                },
                              ),
                            ),
                          ],
                        ),

                        //Hobli Field
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.all(20.0),
                                child: Text(t_hobli,
                                    style: TextStyle(fontSize: 20)),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                width: width * 0.3,
                                child: StatefulBuilder(
                                  builder: (BuildContext context,
                                      StateSetter dropDownState) {
                                    return DropdownButtonFormField<String>(
                                      elevation: 16,
                                      hint: Padding(
                                        padding: leftRightPadding,
                                        child: Text(
                                          !status
                                              ? 'ಹೋಬಳಿಯನ್ನು ಆಯ್ಕೆ ಮಾಡಿ'
                                              : 'Select Hobli',
                                        ),
                                      ),
                                      // taluk_names.map(buildMenuItem).toList()

                                      items: hobli__
                                          .map((e) => DropdownMenuItem(
                                                value: e,
                                                child: Text(e),
                                              ))
                                          .toList(),
                                      // hobli_.map(buildMenuItemHobli).toList(),
                                      validator: (_selectedHobli) {
                                        _selectedHobli == null
                                            ? 'Please fill the details.'
                                            : null;
                                      },
                                      onChanged: (String? value_) =>
                                          dropDownState(() {
                                        this.selectedHobli = value_;
                                      }),
                                      value: selectedHobli,
                                    );
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),

                        //Village
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.all(20.0),
                                child: Text(t_village,
                                    style: TextStyle(fontSize: 20)),
                              ),
                            ),
                            Expanded(
                              child: StatefulBuilder(
                                builder: (BuildContext context,
                                    StateSetter dropDownState) {
                                  return DropdownButtonFormField<String>(
                                    elevation: 16,
                                    hint: Padding(
                                      padding: leftRightPadding,
                                      child: Text(!status
                                          ? 'ಗ್ರಾಮವನ್ನು ಆಯ್ಕೆ ಮಾಡಿ'
                                          : 'Select Village'),
                                    ),
                                    // taluk_names.map(buildMenuItem).toList()

                                    items: village__
                                        .map((e) => DropdownMenuItem(
                                              value: e,
                                              child: Text(e),
                                            ))
                                        .toList(),
                                    validator: (_selectedVillage) {
                                      _selectedVillage == null
                                          ? 'Please fill the details.'
                                          : null;
                                    },
                                    onChanged: (String? value_) =>
                                        dropDownState(() {
                                      this.selectedVillage = value_;
                                    }),
                                    value: selectedVillage,
                                  );
                                },
                              ),
                            ),
                          ],
                        ),

                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.all(20.0),
                                child: Text(t_survey,
                                    style: TextStyle(fontSize: 20)),
                              ),
                            ),
                            Expanded(
                              child: TextFormField(
                                controller: c_survey_no,
                                onEditingComplete: () {},
                                decoration: InputDecoration(
                                  labelText: "Ex: 1/*/12",
                                  labelStyle: TextStyle(fontSize: 14),
                                  fillColor: Colors.amber,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(16.0),
                                    borderSide: const BorderSide(),
                                  ),
                                  //fillColor: Colors.green
                                ),
                                validator: (val) {
                                  if (val == null || val.isEmpty) {
                                    return "Please fill the details.";
                                  } else {
                                    return null;
                                  }
                                },
                                //keyboardType: TextInputType.multiline,
                                style: const TextStyle(),
                              ),
                            ),
                          ],
                        ),
//Family
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.all(20.0),
                                child: Text(
                                  t_total,
                                  style: TextStyle(fontSize: 20),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    width: width * 0.10,
                                    child: TextFormField(
                                      controller: c_total_acre,
                                      onEditingComplete: () {},
                                      decoration: new InputDecoration(
                                        labelText: !status ? "ಎಕರೆ" : "Acre",
                                        labelStyle: TextStyle(fontSize: 14),
                                        fillColor: Colors.amber,
                                        border: new OutlineInputBorder(
                                          borderRadius:
                                              new BorderRadius.circular(16.0),
                                          borderSide: const BorderSide(),
                                        ),
                                        //fillColor: Colors.green
                                      ),
                                      validator: (val) {
                                        if (val == null || val.isEmpty) {
                                          return "Please fill the details.";
                                        } else {
                                          return null;
                                        }
                                      },
                                      //keyboardType: TextInputType.multiline,
                                      style: const TextStyle(),
                                    ),
                                  ),
                                  SizedBox(
                                    width: width * .01,
                                  ),
                                  Container(
                                    width: width * 0.10,
                                    child: TextFormField(
                                      controller: c_total_cent,
                                      onEditingComplete: () {},
                                      decoration: new InputDecoration(
                                        labelText: !status ? "ಸೆoಟಿ" : "Cent",
                                        labelStyle: TextStyle(fontSize: 14),
                                        fillColor: Colors.amber,
                                        border: new OutlineInputBorder(
                                          borderRadius:
                                              new BorderRadius.circular(16.0),
                                          borderSide: const BorderSide(),
                                        ),
                                        //fillColor: Colors.green
                                      ),
                                      validator: (val) {
                                        if (val == null || val.isEmpty) {
                                          return "Please fill the details.";
                                        } else {
                                          return null;
                                        }
                                      },
                                      //keyboardType: TextInputType.multiline,
                                      style: const TextStyle(),
                                    ),
                                  ),
                                  SizedBox(
                                    width: width * .01,
                                  ),
                                  Container(
                                    width: width * 0.10,
                                    child: TextFormField(
                                      controller: c_total_fcent,
                                      onEditingComplete: () {},
                                      decoration: new InputDecoration(
                                        labelText:
                                            !status ? "F-ಸೆoಟಿ" : "FCent",
                                        labelStyle: TextStyle(fontSize: 14),
                                        fillColor: Colors.amber,
                                        border: new OutlineInputBorder(
                                          borderRadius:
                                              new BorderRadius.circular(16.0),
                                          borderSide: const BorderSide(),
                                        ),
                                        //fillColor: Colors.green
                                      ),
                                      validator: (val) {
                                        if (val == null || val.isEmpty) {
                                          return "Please fill the details.";
                                        } else {
                                          return null;
                                        }
                                      },
                                      //keyboardType: TextInputType.multiline,
                                      style: const TextStyle(),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),

                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Text(
                                  t_requested,
                                  style: const TextStyle(
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    width: width * 0.12,
                                    child: TextFormField(
                                      controller: c_req_acre,
                                      onEditingComplete: () {},
                                      decoration: new InputDecoration(
                                        labelText: !status ? "ಎಕರೆ" : "Acre",
                                        labelStyle: TextStyle(fontSize: 14),
                                        fillColor: Colors.amber,
                                        border: new OutlineInputBorder(
                                          borderRadius:
                                              new BorderRadius.circular(16.0),
                                          borderSide: const BorderSide(),
                                        ),
                                        //fillColor: Colors.green
                                      ),
                                      validator: (val) {
                                        if (val == null || val.isEmpty) {
                                          return "Please fill the details.";
                                        } else {
                                          return null;
                                        }
                                      },
                                      //keyboardType: TextInputType.multiline,
                                      style: const TextStyle(),
                                    ),
                                  ),
                                  SizedBox(
                                    width: width * .01,
                                  ),
                                  Container(
                                    width: width * 0.12,
                                    child: TextFormField(
                                      controller: c_req_cent,
                                      onEditingComplete: () {},
                                      decoration: new InputDecoration(
                                        labelText: !status ? "ಸೆoಟಿ" : "Cent",
                                        labelStyle: TextStyle(fontSize: 14),
                                        fillColor: Colors.amber,
                                        border: new OutlineInputBorder(
                                          borderRadius:
                                              new BorderRadius.circular(16.0),
                                          borderSide: const BorderSide(),
                                        ),
                                        //fillColor: Colors.green
                                      ),
                                      validator: (val) {
                                        if (val == null || val.isEmpty) {
                                          return "Please fill the details.";
                                        } else {
                                          return null;
                                        }
                                      },
                                      //keyboardType: TextInputType.multiline,
                                      style: const TextStyle(),
                                    ),
                                  ),
                                  SizedBox(
                                    width: width * .01,
                                  ),
                                  Container(
                                    width: width * 0.12,
                                    child: TextFormField(
                                      controller: c_req_fcent,
                                      onEditingComplete: () {},
                                      decoration: InputDecoration(
                                        labelText:
                                            !status ? "F-ಸೆoಟಿ" : "FCent",
                                        labelStyle:
                                            const TextStyle(fontSize: 14),
                                        fillColor: Colors.amber,
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(16.0),
                                          borderSide: const BorderSide(),
                                        ),
                                        //fillColor: Colors.green
                                      ),
                                      validator: (val) {
                                        if (val == null || val.isEmpty) {
                                          return "Please fill the details.";
                                        } else {
                                          return null;
                                        }
                                      },
                                      //keyboardType: TextInputType.multiline,
                                      style: const TextStyle(),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const Divider(
                          color: Colors.black54,
                          thickness: 1,
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Text(
                                  t_main,
                                  style: const TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                    shadows: [
                                      Shadow(
                                        color: Colors.black45,
                                        blurRadius: 6.0,
                                        offset: Offset(0.0, 2.0),
                                      ),
                                    ],
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const Divider(
                          color: Colors.black54,
                          thickness: 1,
                        ),
                        //Description
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Text(
                                  t_main1,
                                  style: const TextStyle(
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: StatefulBuilder(
                                builder: (BuildContext context,
                                    StateSetter dropDownState) {
                                  return DropdownButtonFormField<String>(
                                    elevation: 16,
                                    hint: Padding(
                                      padding: leftRightPadding,
                                      child: Text(!status
                                          ? 'ಮುಖ್ಯ ಉದ್ಧೇಶ ಆಯ್ಕೆ ಮಾಡಿ'
                                          : 'Please select'),
                                    ),
                                    // taluk_names.map(buildMenuItem).toList()

                                    items: main_objective_ka
                                        .map((e) => DropdownMenuItem(
                                              value: e,
                                              child: Text(e),
                                            ))
                                        .toList(),
                                    // hobli_.map(buildMenuItemHobli).toList(),
                                    validator: (_selectedHobli) {
                                      _selectedHobli == null
                                          ? 'Please fill the details.'
                                          : null;
                                    },

                                    isExpanded: false,

                                    onChanged: (String? value_) =>
                                        dropDownState(() {
                                      setState(() {
                                        selectedMain = null;
                                        selectedSub = null;
                                        selectedMain = value_;
                                        log('thi s');
                                        sub_intension.clear();
                                        _visible = true;

                                        if (value_ == 'ವಸತಿ' ||
                                            value_ == 'Housing') {
                                          sub_intension = List.from(housing);

                                          print(sub_intension);
                                        } else if (value_ == 'ವಾಣಿಜ್ಯ') {
                                          sub_intension = List.from(commercial);

                                          print(sub_intension);
                                        } else if (value_ == 'ಕೈಗಾರಿಕೆ') {
                                          _visible = false;
                                        } else if (value_ == 'ಗಣಿಗಾರಿಕೆ') {
                                        } else {}
                                      });
                                    }),
                                    value: selectedMain,
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                        Visibility(
                          visible: _visible,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Text(
                                    t_sub,
                                    style: const TextStyle(
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: StatefulBuilder(
                                  builder: (BuildContext context,
                                      StateSetter dropDownState) {
                                    return DropdownButtonFormField<String>(
                                      elevation: 16,
                                      hint: Padding(
                                        padding: leftRightPadding,
                                        child: Text(!status
                                            ? 'ಉಪ ಉದ್ಧೇಶ ಆಯ್ಕೆ ಮಾಡಿ'
                                            : 'Please select'),
                                      ),

                                      items: sub_intension
                                          .map((e) => DropdownMenuItem(
                                                value: e,
                                                child: Text(e),
                                              ))
                                          .toList(),
                                      // hobli_.map(buildMenuItemHobli).toList(),
                                      validator: (_selectedHobli) {
                                        _selectedHobli == null
                                            ? 'Please fill the details.'
                                            : null;
                                      },
                                      onChanged: (String? value_) =>
                                          dropDownState(() {
                                        selectedSub = value_;
                                      }),
                                      value: selectedSub,
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Divider(
                          color: Colors.black54,
                          thickness: 1,
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.all(20.0),
                                child: Text(
                                  t_docs,
                                  style: const TextStyle(shadows: [
                                    Shadow(
                                      color: Colors.black45,
                                      blurRadius: 6.0,
                                      offset: Offset(0.0, 2.0),
                                    ),
                                  ], fontSize: 22, fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const Divider(
                          color: Colors.black54,
                          thickness: 1,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Text(
                                  t_rtc,
                                  style: const TextStyle(
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30.0)),
                              constraints: BoxConstraints(
                                  maxWidth: 250.0, minHeight: 50.0),
                              margin: EdgeInsets.symmetric(
                                  vertical: 12, horizontal: 8),
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => Upload(),
                                      ));
                                },
                                //  color: Theme.of(context).accentColor,
                                child: Padding(
                                  padding: EdgeInsets.all(0),
                                  child: Container(
                                    alignment: Alignment.center,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: const <Widget>[
                                        Padding(
                                          padding: EdgeInsets.only(left: 24.0),
                                          child: Text(
                                            'Upload',
                                            style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                        Icon(
                                          Icons.upload_file,
                                          color: Colors.red,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.all(20.0),
                                child: Text(
                                  status ? 'Sketch' : 'ಸ್ಕೆಚ್',
                                  style: TextStyle(
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30.0)),
                              constraints: BoxConstraints(
                                  maxWidth: 250.0, minHeight: 50.0),
                              margin: EdgeInsets.symmetric(
                                  vertical: 12, horizontal: 8),
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const SignUpView(),
                                      ));
                                },
                                //  color: Theme.of(context).accentColor,
                                child: Padding(
                                  padding: EdgeInsets.all(0),
                                  child: Container(
                                    alignment: Alignment.center,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 24.0),
                                          child: Text(
                                            'Upload',
                                            style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                        const Icon(
                                          Icons.upload_file,
                                          color: Colors.redAccent,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Visibility(
                          visible: false,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsets.all(20.0),
                                  child: Text(
                                    t_adhar,
                                    style: TextStyle(
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                              ),
                              Checkbox(
                                checkColor: Colors.white,
                                // fillColor: MaterialStateProperty.resolveWith(),
                                value: isChecked,
                                shape: CircleBorder(),
                                onChanged: (bool? value) {
                                  setState(() {
                                    isChecked = value!;
                                  });
                                },
                              ),
                              // Container(
                              //   decoration: BoxDecoration(
                              //       borderRadius: BorderRadius.circular(30.0)),
                              //   constraints:
                              //       BoxConstraints(maxWidth: 250.0, minHeight: 50.0),
                              //   margin:
                              //       EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                              //   child: ElevatedButton(
                              //     onPressed: () {},
                              //     //  color: Theme.of(context).accentColor,
                              //     child: Padding(
                              //       padding: EdgeInsets.all(0),
                              //       child: Container(
                              //         alignment: Alignment.center,
                              //         child: Row(
                              //           mainAxisAlignment:
                              //               MainAxisAlignment.spaceBetween,
                              //           children: <Widget>[
                              //             Padding(
                              //               padding: const EdgeInsets.only(left: 24.0),
                              //               child: Text(
                              //                 'Upload',
                              //                 style: TextStyle(
                              //                   fontSize: 16,
                              //                   color: Colors.white,
                              //                 ),
                              //               ),
                              //             ),
                              //             const Icon(
                              //               Icons.upload_file,
                              //               color: Colors.redAccent,
                              //             )
                              //           ],
                              //         ),
                              //       ),
                              //     ),
                              //   ),
                              // ),
                            ],
                          ),
                        ),

                        const Divider(
                          color: Colors.black54,
                          thickness: 1,
                        ),

//Submit.
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30.0)),
                          constraints:
                              BoxConstraints(maxWidth: 250.0, minHeight: 50.0),
                          margin:
                              EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                          child: ElevatedButton(
                            onPressed: () async {
                              // log(controller1.text);
                              if (_formKey.currentState!.validate()) {
                                insertData(context);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text("Data Submitted Succesfully"),
                                  ),
                                );
                                // Future.delayed(Duration(seconds: 1), () {
                                //   Navigator.push(
                                //       context,
                                //       MaterialPageRoute(
                                //         builder: (context) => const ApplicationView(),
                                //       ));
                                // });
                                //Navigator.of(context).pop();
                                // } else {
                                //   log("Error Adding");
                                //   return;
                                // }
                              }
                            },
                            //  color: Theme.of(context).accentColor,
                            child: Padding(
                              padding: EdgeInsets.all(0),
                              child: Container(
                                alignment: Alignment.center,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 24.0),
                                      child: Text(
                                        'Submit',
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    Icon(
                                      Icons.done,
                                      color: successColor,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  var nameField = new Row(
    mainAxisSize: MainAxisSize.min,
    children: <Widget>[
      Expanded(
        child: const Padding(
          padding: const EdgeInsets.all(20.0),
          child: Text('Name :'),
        ),
      ),
      Expanded(
        child: new TextFormField(
          //controller: controller1,
          onEditingComplete: () {},
          decoration: new InputDecoration(
            labelText: "Name",
            labelStyle: TextStyle(fontSize: 14),
            fillColor: Colors.amber,
            border: new OutlineInputBorder(
              borderRadius: new BorderRadius.circular(16.0),
              borderSide: const BorderSide(),
            ),
            //fillColor: Colors.green
          ),
          validator: (val) {
            if (val == null || val.isEmpty) {
              return "Please enter your name.";
            } else {
              return null;
            }
          },
          //keyboardType: TextInputType.multiline,
          style: const TextStyle(),
        ),
      ),
    ],
  );

  Widget buildTextField({required String labelText}) {
    return Container(
      child: TextFormField(
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: TextStyle(fontSize: 14),
          fillColor: Colors.white,

          border: new OutlineInputBorder(
            borderRadius: new BorderRadius.circular(16.0),
            borderSide: const BorderSide(color: Colors.green),
          ),
          //fillColor: Colors.green
        ),
      ),
    );
  }

  void chooseImage() async {
    pickedFile = await FilePicker.platform.pickFiles();
    if (pickedFile != null) {
      try {
        setState(() {
          logoBase64 = pickedFile!.files.first.bytes;
          Image.memory(logoBase64!);
        });
      } catch (err) {
        print(err);
      }
    } else {
      print('No Image Selected');
    }
  }

  Future<void> insertData(
    BuildContext context,
  ) async {
    if (applicant_name.text.isEmpty || c_spouse.text.isEmpty) {
    } else {
      log('not empty');
      // SharedPreferences prefs = await SharedPreferences.getInstance();
      // prefs.setString('name', controller1.text);
      // prefs.setString('c_spouse', c_spouse.text);
      // prefs.setString('c_address', c_address.text);
      // prefs.setString('c_mobile', c_mobile.text);
      // prefs.setString('taluk', selectedTaluk!);
      // prefs.setString('hobli', selectedHobli!);
      // prefs.setString('village', selectedVillage!);
      // prefs.setString('survey_number', c_survey_no.text);
      // prefs.setString('total_area', c_total_land.text);
      // prefs.setString('converting', controller7.text);
      // prefs.setString('main_obj', selectedMain!);
      // prefs.setString('sub_obj', selectedSub!);
      log('here');
      ApplicationService.addApplication(
              applicant_name.text,
              c_spouse.text,
              c_address.text,
              c_mobile.text,
              c_survey_no.text,
              c_total_acre.text,
              c_total_cent.text,
              c_total_fcent.text,
              c_req_acre.text,
              c_req_cent.text,
              c_req_fcent.text,
              selectedTaluk.toString(),
              selectedHobli.toString(),
              selectedVillage.toString(),
              selectedMain.toString(),
              selectedSub.toString())
          .then(
        (result) {
          debugPrint('Debug report: $result');

          log('HTTP result: $result');
          if ('Success' == result) {
            //  _getTaluk();
            // _showSnackBar(context, result);
          }
          // _clearValues();
        },
      );

      // log('Here 1');
      // setState(() {
      //   ScaffoldMessenger.of(context).showSnackBar(
      //     SnackBar(
      //       backgroundColor: Colors.white,
      //       elevation: 10.0,
      //       shape: Border.all(
      //         color: Colors.green,
      //         width: 0.5,
      //         style: BorderStyle.solid,
      //       ),
      //       content: Text(
      //         "Successful",
      //         style: TextStyle(
      //           color: Colors.black,
      //           fontSize: 18.0,
      //           fontStyle: FontStyle.italic,
      //           fontWeight: FontWeight.bold,
      //           letterSpacing: 1.0,
      //         ),
      //         textAlign: TextAlign.center,
      //       ),
      //     ),
      //   );
      // });
    }
  }
}
