import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

class ApplicationService {
  static const ROOT = "http://localhost/land_conversion/application_form.php";

  static const _CREATE_TABLE_ACTION = 'CREATE_TABLE';
  static const _GET_ALL_ACTION = 'FETCH_APPLICATION';
  static const _ADD_ACTION = 'APPLY';

  static Future<String> createTable() async {
    var map = Map<String, dynamic>();
    map['action'] = _CREATE_TABLE_ACTION;
    map['name'] = 'Rathanaa';
    map['bin'] = 'Rachan';
    final response = await http.post(Uri.parse(ROOT), body: map);
    print('Create table APPLICATION: ${response.body}');
    return response.body;
  }

  static Future<String> addApplication(
      String name,
      String spouse,
      String address,
      String mobile,
      String survey_no,
      String tot_acre,
      String tot_cent,
      String tot_fcent,
      String req_acre,
      String req_cent,
      String req_fcent,
      String taluk,
      String hobli,
      String village,
      String main,
      String sub) async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = _ADD_ACTION;
      map['applicant_name'] = name;
      map['spouse'] = spouse;
      map['full_address'] = address;
      map['mobile'] = mobile;
      map['survey_num'] = survey_no;
      map['tot_acre'] = tot_acre;
      map['tot_cent'] = tot_cent;
      map['tot_fcent'] = tot_fcent;
      map['req_acre'] = req_acre;
      map['req_cent'] = req_cent;
      map['req_fcent'] = req_fcent;
      map['taluk'] = taluk;
      map['hobli'] = hobli;
      map['village'] = village;
      map['main_objective'] = main;
      map['sub_objective'] = sub;

      log(name);

      final response = await http.post(Uri.parse(ROOT), body: map);

      String v = response.statusCode.toString();
      log('Response string :$v');
      if (200 == response.statusCode) {
        // getTaluk();
        log('200 man');
        return response.body;
      } else {
        return "Error Adding ";
      }
    } catch (e) {
      log('Exception :$e');

      return "Something went wrong";
    }
  }
}
