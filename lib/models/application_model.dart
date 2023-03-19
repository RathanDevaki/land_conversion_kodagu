import 'dart:typed_data';

class ApplicationModel {
  String fullname;
  String address;
  String spouse;
  String mobile;
  String selectedTaluk;
  String selectedHobli;
  String selectedVilage;
  String surveyNumber;
  String tot_acre, tot_cent, tot_fcent;
  String con_acre, con_cent, con_fcent;

  String main_obj;
  String sub_obj;

  Uint8List rtc;
  Uint8List akarBandh;

  ApplicationModel({
    required this.fullname,
    required this.spouse,
    required this.address,
    required this.mobile,
    required this.selectedTaluk,
    required this.selectedHobli,
    required this.selectedVilage,
    required this.surveyNumber,
    required this.tot_fcent,
    required this.tot_acre,
    required this.tot_cent,
    required this.con_acre,
    required this.con_cent,
    required this.con_fcent,
    required this.main_obj,
    required this.sub_obj,
    required this.rtc,
    required this.akarBandh,
    //test
  });

  @override
  String toString() {
    return 'ApplicationModel{name: $fullname, address: $address}}';
  }
}
