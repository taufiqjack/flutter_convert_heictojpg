import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_convert_heictojpg/core/component/toast.dart';
import 'package:flutter_convert_heictojpg/interfaces/views/home_view.dart';
import 'package:heif_converter/heif_converter.dart';
import 'package:image_gallery_saver_plus/image_gallery_saver_plus.dart';

import 'package:path/path.dart' as path;

class HomeController extends State<HomeView> {
  final httpClient = HttpClient();

  File? heicFiles;
  FilePickerResult? result;
  FilePickerResult? newResult;
  List<String> convertedPaths = [];
  dynamic pickImageError;

  String? convertPath;
  String? jpgPath;
  String? targetFile;
  String resultScan = "";

  void removeItem(item) async {
    result?.files.remove(item);
    setState(() {});
  }

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

  Future pickImageOther() async {
    newResult = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowMultiple: true,
      allowedExtensions: ['heic', 'HEIC'],
    );
    debugPrint('list path ${result?.files.first.path}');

    if (newResult == null || newResult?.files == null) {
      debugPrint('User canceled the picker.');
      return;
    }
    if (result != null || result!.files.isNotEmpty) {
      debugPrint('User canceled the picker.');
      result!.files.addAll(newResult!.files);
    } else {
      result = newResult;
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
        toast(context, 'Please selected photos');
      }
      return [];
    }
  }

  Future<List<String>?> saveCompressImage() async {
    try {
      for (var file in result!.files) {
        if (file.path == null) continue;

        File heicFile = File(file.path!);

        final bytes = await File(heicFile.path).readAsBytes();
        await ImageGallerySaverPlus.saveImage(
          bytes,
          quality: 60,
          name: path.basenameWithoutExtension(heicFile.path),
        );

        debugPrint('✅ Saved: $heicFile');
        if (mounted) {
          toast(context, '✅ Saved: $heicFile');
        }
      }
      return convertedPaths;
    } catch (e) {
      debugPrint('❌ Error: $e');
      if (mounted) {
        toast(context, 'Please selected photos');
      }
      return [];
    }
  }

  @override
  Widget build(BuildContext context) => widget.build(context, this);
}
