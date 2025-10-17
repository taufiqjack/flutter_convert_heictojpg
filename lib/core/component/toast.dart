import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void toast(BuildContext ctx, String text) async {
  FToast fToast = FToast();
  fToast.init(ctx);
  fToast.showToast(
      child: Container(
    padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(color: Color(0xFFDDDDDD).withValues(alpha: 0.8))
        ]),
    child: Text(
      text,
      style: TextStyle(color: Colors.black),
    ),
  ));
}
