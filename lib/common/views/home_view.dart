import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:heic_to_jpg/heic_to_jpg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  File? imageFile;
  dynamic pickImageError;
  final picker = ImagePicker();
  String? convertPath;
  String? jpgPath;

  void _onSelectImagePicker(ImageSource source) async {
    try {
      final pickedFile = await picker.pickImage(source: source);
      if (pickedFile != null) {
        imageFile = File(pickedFile.path);
      } else {
        if (kDebugMode) {
          print('No image selected');
        }
      }
    } catch (e) {
      pickImageError = e;
    }
    if (imageFile != null) {}
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          imageFile == null
              ? const SizedBox()
              : ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.file(
                    File(imageFile!.path),
                    height: MediaQuery.of(context).size.height / 2,
                  ),
                ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              InkWell(
                onTap: () {
                  _onSelectImagePicker(ImageSource.gallery);
                },
                child: Container(
                  height: 40,
                  width: MediaQuery.of(context).size.width / 3,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Color.fromARGB(255, 0, 185, 172),
                  ),
                  child: const Center(
                    child: Text(
                      'Pilih Foto',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () async {
                  convertPath = (await getTemporaryDirectory()).path;
                  jpgPath = await HeicToJpg.convert(imageFile!.path);
                  imageFile = File(jpgPath!);
                },
                child: Container(
                  height: 40,
                  width: MediaQuery.of(context).size.width / 3,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Color.fromARGB(255, 0, 185, 172),
                  ),
                  child: const Center(
                    child: Text(
                      'Convert ke Jpg',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      )),
    );
  }
}
