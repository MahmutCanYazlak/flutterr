// To parse this JSON data, do
//
//     final catogories = catogoriesFromMap(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<String> catogoriesFromMap(String str) => List<String>.from(json.decode(str).map((x) => x));

String catogoriesToMap(List<String> data) => json.encode(List<dynamic>.from(data.map((x) => x)));
