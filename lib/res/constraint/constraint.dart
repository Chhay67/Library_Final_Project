import 'package:flutter/material.dart';

const TextStyle headingStyle =
    TextStyle(fontSize: 25, fontWeight: FontWeight.w900, color: Colors.white);
const backgroundColor = Color(0xFF38c172);
const titleText = TextStyle(fontSize: 15, fontWeight: FontWeight.w300);
const titleContent = TextStyle(fontWeight: FontWeight.bold, fontSize: 17);
const boxDecoration = BoxDecoration(color: Colors.white, borderRadius: BorderRadius.only(
        topRight: Radius.circular(30), topLeft: Radius.circular(30)));
const borderOutLineInputBorder = OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(20)));
const focusedBorderOutLineInputBorder =OutlineInputBorder(
    borderRadius: BorderRadius.all(
        Radius.circular(20)),
    borderSide: BorderSide(
        color: Colors.black,
    ));
enum Option { ADDBOOK, EDITBOOK,ADDAUTHOR,EDITAUTHOR }
