import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker_web/image_picker_web.dart';
import 'package:image_picker_web/image_picker_web.dart';

import 'package:flutter_web_plugins/flutter_web_plugins.dart';

// ignore: public_member_api_docs
void registerPlugins(Registrar registrar) {
  ImagePickerWeb.registerWith(registrar);
  registrar.registerMessageHandler();
}

class WebImage extends StatefulWidget {
  const WebImage({Key? key}) : super(key: key);

  @override
  State<WebImage> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<WebImage> {
  bool imageAvailable = false;
  late Uint8List imageFile;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 120,
              width: 120,
              color: Colors.blue,
              child:
                  imageAvailable ? Image.memory(imageFile) : const SizedBox(),
            ),
            GestureDetector(
              onTap: () async {
                final image = await ImagePickerWeb.getImageAsBytes();

                setState(() {
                  imageFile = image!;
                  imageAvailable = true;
                });
              },
              child: Container(
                height: 50,
                width: 150,
                color: Colors.orange,
                child: Center(
                  child: Text("Pick Image"),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
