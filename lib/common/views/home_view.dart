import 'dart:io';
import 'package:any_image_view/any_image_view.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_convert_heictojpg/core/component/toast.dart';
import 'package:heif_converter/heif_converter.dart';
import 'package:image_gallery_saver_plus/image_gallery_saver_plus.dart';
import 'package:path/path.dart' as path;

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  dynamic pickImageError;

  String? convertPath;
  String? jpgPath;
  final httpClient = HttpClient();

  File? heicFiles;
  FilePickerResult? result;
  List<String> convertedPaths = [];

  Future pickImageConvert() async {
    result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowMultiple: true,
      allowedExtensions: ['heic', 'HEIC'],
    );
    debugPrint('list path ${result?.files.first.path}');

    if (result == null || result?.files == null) {
      debugPrint('User canceled the picker.');
      return null;
    }
    setState(() {});
  }

  Future<List<String>?> saveImageConvert() async {
    try {
      for (var file in result!.files) {
        if (file.path == null) continue;

        File heicFile = File(file.path!);

        final convertedPath = await HeifConverter.convert(
          heicFile.path,
          format: 'jpg',
        );

        if (convertedPath != null) {
          convertedPaths.add(convertedPath);

          final bytes = await File(convertedPath).readAsBytes();
          await ImageGallerySaverPlus.saveImage(
            bytes,
            quality: 100,
            name: path.basenameWithoutExtension(heicFile.path),
          );

          debugPrint('✅ Saved: $convertedPath');
          if (mounted) {
            toast(context, '✅ Saved: $convertedPath');
          }
        }
      }
      return convertedPaths;
    } catch (e) {
      debugPrint('❌ Error: $e');
      if (mounted) {
        toast(context, '$e');
      }
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'CONVERT HEIC TO JPG',
            style: TextStyle(fontWeight: FontWeight.w700),
          ),
          centerTitle: true,
        ),
        body: Padding(
          padding: EdgeInsetsGeometry.only(top: 30),
          child: Center(
              child: Column(
            children: [
              result == null
                  ? const SizedBox()
                  : GridView.builder(
                      padding: EdgeInsets.only(left: 10),
                      shrinkWrap: true,
                      itemCount: result?.files.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          childAspectRatio: 3 / 3,
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 10),
                      itemBuilder: (context, index) => ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: AnyImageView(
                          height: 230,
                          width: 200,
                          borderRadius: BorderRadius.circular(10),
                          fadeDuration: Duration(milliseconds: 300),
                          imagePath: result!.files[index].path!,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
              const SizedBox(
                height: 20,
              ),
            ],
          )),
        ),
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsetsGeometry.only(left: 30),
              child: InkWell(
                onTap: () {
                  pickImageConvert();
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
                      'Select Photos',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: () async {
                saveImageConvert();
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
                    'Convert to JPG',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}
