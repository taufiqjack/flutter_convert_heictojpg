import 'package:flutter/material.dart';
import 'package:flutter_convert_heictojpg/core/component/constants.dart';
import 'package:flutter_convert_heictojpg/interfaces/views/home_view.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> main() async {
  await dotenv.load(fileName: ENV_PATH);
  runApp(MaterialApp(
    theme: ThemeData(useMaterial3: false),
    home: HomeView(),
  ));
}
