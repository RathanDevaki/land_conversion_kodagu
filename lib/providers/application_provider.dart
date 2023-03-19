import 'dart:developer';
import 'dart:typed_data';

import 'package:flutter/material.dart';

import '../models/application_model.dart';

class ApplicationProvider extends ChangeNotifier {
  late String fullname;
  late String address;
  late String spouse;
  late String mobile;
  late String selectedTaluk;
  late String selectedHobli;
  late String selectedVilage;
  late String surveyNumber;
  late String tot_acre, tot_cent, tot_fcent;
  late String con_acre, con_cent, con_fcent;

  late String main_obj;
  late String sub_obj;

  late Uint8List rtc;
  late Uint8List akarBandh;

  String? selectedMain;

  void addMain(String? st) {
    selectedMain = st;
    notifyListeners();
    log('Prov--> $selectedMain');
  }

  void addApplication(ApplicationModel apm) {
    fullname = apm.fullname;
    address = apm.address;
    spouse = apm.spouse;
    mobile = apm.spouse;
    selectedTaluk = apm.selectedTaluk;
    selectedHobli = apm.selectedHobli;
    selectedVilage = apm.selectedVilage;
    surveyNumber = apm.surveyNumber;
    tot_acre = apm.tot_acre;
    tot_cent = apm.tot_cent;
    tot_fcent = apm.tot_fcent;
    con_acre = apm.con_acre;
    con_cent = apm.con_cent;
    con_fcent = apm.con_fcent;

    main_obj = apm.main_obj;
    sub_obj = apm.sub_obj;

    rtc = apm.rtc;
    akarBandh = apm.akarBandh;

    log('ApplicationProvider => $akarBandh');
    log('$fullname');
  }
}
