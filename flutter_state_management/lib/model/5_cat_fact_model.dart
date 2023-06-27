// ignore_for_file: public_member_api_docs, sort_constructors_first
// To parse this JSON data, do
//
//     final kedi = kediFromMap(jsonString);

import 'dart:convert';

import 'package:meta/meta.dart';

class Datum {
    final String fact;
    final int length;
  Datum({
    required this.fact,
    required this.length,
  });

  Datum copyWith({
    String? fact,
    int? length,
  }) {
    return Datum(
      fact: fact ?? this.fact,
      length: length ?? this.length,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'fact': fact,
      'length': length,
    };
  }

  factory Datum.fromMap(Map<String, dynamic> map) {
    return Datum(
      fact: map['fact'] as String,
      length: map['length'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory Datum.fromJson(String source) => Datum.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Datum(fact: $fact, length: $length)';

  @override
  bool operator ==(covariant Datum other) {
    if (identical(this, other)) return true;
  
    return 
      other.fact == fact &&
      other.length == length;
  }

  @override
  int get hashCode => fact.hashCode ^ length.hashCode;
}

