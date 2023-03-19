import 'dart:developer';
import 'dart:typed_data';

// ignore: depend_on_referenced_packages
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:http_parser/http_parser.dart';
import 'package:http/http.dart' as http;

import 'package:dio/dio.dart';

class UploadToNode extends StatefulWidget {
  @override
  _FileUploadFormState createState() => _FileUploadFormState();
}

class _FileUploadFormState extends State<UploadToNode> {
  ProjectProvider1 provider = ProjectProvider1();
  List<PlatformFile>? _paths;
  late List<int> bytes;
  late Uint8List uint;
  // int flag = 0;
  @override
  Widget build(BuildContext context) {
    // TODO: implement bu
    return GestureDetector(
      onTap: test,
      child: Column(
        children: [
          Text(provider.respFlag.toString()),
          Stack(
            alignment: Alignment.bottomRight,
            children: [
              provider.uintflag == 1 &&
                      provider.sizeflag == 1 &&
                      provider.respFlag == 1
                  ? Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        height: 100.00,
                        width: 100.00,
                        margin: const EdgeInsets.only(
                          left: 113.00,
                          top: 10.00,
                          right: 113.00,
                        ),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                              8.00,
                            ),
                            image: DecorationImage(image: MemoryImage(uint))),
                      ),
                    )
                  : Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        height: 100.00,
                        width: 100.00,
                        margin: const EdgeInsets.only(
                          left: 113.00,
                          top: 10.00,
                          right: 113.00,
                        ),
                        decoration: BoxDecoration(
                            color: Colors.grey.shade400,
                            borderRadius: BorderRadius.circular(
                              8.00,
                            ),
                            image: const DecorationImage(
                                image: AssetImage('assets/images/logo.png'))),
                      ),
                    ),
              (provider.sizeflag == 2)
                  ? Center(
                      child: AlertDialog(
                        title: Text('Alert'),
                        content: Text('Image is larger than 500kb'),
                        actions: [
                          TextButton(
                            child: Text('OK'),
                            onPressed: () {
                              // Close the dialog
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      ),
                    )
                  : Container(),
            ],
          ),
        ],
      ),
    );
  }

  test() async {
    // * Pick a File
    FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowCompression: true,
        allowMultiple: false,
        onFileLoading: (FilePickerStatus status) => print(status),
        allowedExtensions: ['jpeg', 'png', 'jpg']);

    if (result != null) {
      // * cast it to bytes
      bytes = result.files.single.bytes!.cast();
      setState(() {
        uint = Uint8List.fromList(bytes);
        provider.uintflag = 1;
      });

      // * Get its name, will use it later.
      var name = result.files.single.name;
      int fileSizeInBytes = bytes.length;
      double fileSizeInKB = fileSizeInBytes / 1024;

      // Check if the file size is less than 500KB
      if (fileSizeInKB <= 500) {
        log(fileSizeInKB.toString());
        setState(() {
          provider.sizeflag = 1;
        });
      } else {
        provider.sizeflag = 0;
        setState(() {
          provider.sizeflag = 2;
        });
      }
      provider.test(bytes, name);
    }
  }
}

class ProjectProvider1 extends ChangeNotifier {
  // * constructor
  ProjectProvider1() : _dio = Dio();
  int demo = 1;
  int uintflag = 0;
  int sizeflag = 0;
  int respFlag = 0;
  late Response _response;
  late final Dio _dio;
  late Uint8List uint;
  // * rest api
  final _baseUrl = "http://192.168.1.101:3000";

  test(List<int> bytes, String name) async {
    String extension = name.split(".").last;

    var formData = FormData.fromMap({
      "file": MultipartFile.fromBytes(
        bytes,
        filename: name,
        contentType: MediaType("File", extension),
      ),
    });

    try {
      if (sizeflag == 1) {
        notifyListeners();
        _response = await _dio.post("$_baseUrl/upload", data: formData);
      }
      if (_response.statusCode == 200) {
        respFlag = 1;
        notifyListeners();
      } else {
        respFlag = 0;
        notifyListeners();
      }
    } catch (error) {
      // Handle error response here
      if (error is DioError) {
        // Handle DioError
        if (error.response != null) {
          // Handle DioError with response
          print(error.response!.data);
          print(error.response!.headers);
        } else {
          // Handle DioError without response
          print(error.message);
        }
      } else {
        // Handle other errors
        print(error.toString());
      }
    }
  }
}
