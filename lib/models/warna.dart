import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';

// import 'package:flutter_project/models/rating.dart';
// @JsonSerializable(fieldRename: FieldRename.snake)
class Warna {
  final int? id;
  final String nama_warna;

  Warna({
    this.id,
    required this.nama_warna,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nama_warna': nama_warna,
    };
  }

  factory Warna.fromMap(Map<String, dynamic> map) {
    return Warna(
      id: map['id'],
      nama_warna: map['nama_warna'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Warna.fromJson(String source) => Warna.fromMap(json.decode(source));
}
