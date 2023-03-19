import 'dart:convert';
import 'dart:developer';
import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class Upload extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Upload> {
  XFile? image;

  List _images = [];

  late ImagePicker picker = ImagePicker();

  //we can upload image from camera or from gallery based on parameter
  Future sendImage(ImageSource media) async {
    var img = await picker.pickImage(source: media);

    var uri = "http://192.168.1.101/land_conversion/login.php";
    log(uri);
    var request = http.MultipartRequest('POST', Uri.parse(uri));
    log(uri);
    try {
      if (img != null) {
        var pic = await http.MultipartFile.fromPath("image", img.path);

        request.files.add(pic);

        await request.send().then((result) {
          http.Response.fromStream(result).then((response) {
            var message = jsonDecode(response.body);

            // show snackbar if input data successfully
            final snackBar = SnackBar(content: Text(message['message']));
            ScaffoldMessenger.of(context).showSnackBar(snackBar);

            //get new list images
            getImageServer();
          });
        }).catchError((e) {
          print(e);
        });
      }
    } catch (e) {
      print(e);
    }
  }

  Future getImageServer() async {
    try {
      final response = await http
          .get(Uri.parse('http://192.168.1.101/land_conversion/login.php'));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        setState(() {
          _images = data;
        });
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
    sendImage(ImageSource.gallery);

    getImageServer();
  }

  //show popup dialog
  void myAlert() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            title: Text('Please choose media to select'),
            content: Container(
              height: MediaQuery.of(context).size.height / 6,
              child: Column(
                children: [
                  ElevatedButton(
                    //if user click this button, user can upload image from gallery
                    onPressed: () {
                      Navigator.pop(context);
                      sendImage(ImageSource.gallery);
                    },
                    child: Row(
                      children: [
                        Icon(Icons.image),
                        Text('From Gallery'),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    //if user click this button. user can upload image from camera
                    onPressed: () {
                      Navigator.pop(context);
                      sendImage(ImageSource.camera);
                    },
                    child: Row(
                      children: [
                        Icon(Icons.camera),
                        Text('From Camera'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _images.length != 0
            ? GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                itemCount: _images.length,
                itemBuilder: (_, index) {
                  return const Padding(
                    padding: EdgeInsets.all(10),

                    // child: Image(
                    //   image: NetworkImage(
                    //       'http://192.168.1.4/latihan/flutter_upload_image/images/' +
                    //           _images[index]['image']),
                    //   fit: BoxFit.cover,
                    // ),
                  );
                })
            : const Center(
                child: Text("No Image"),
              ));
  }
}
