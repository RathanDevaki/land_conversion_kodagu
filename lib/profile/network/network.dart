import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';

class ApiClient {
  static var dio = Dio();
  static Future<String> uploadFile(List<int> file, String fileName) async {
    log('Here---1');
    // var formData1 = {
    //   "name": fileName,
    //   "image": file,
    // };
    FormData formData = FormData.fromMap({
      "file": MultipartFile.fromBytes(
        file,
        filename: fileName,
        contentType: MediaType("image", "png"),
      )
    });
    print(formData.files);
    var response =
        await dio.post("https://localhost:3000/upload", data: formData);
    log('${response.statusCode}');
    if (response.statusCode == 200) {
      log('Succ');
    } else {
      log('Failu');
    }
    return response.data['FileId'];
  }
}
