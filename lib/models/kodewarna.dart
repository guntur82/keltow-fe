import 'dart:convert';
// import 'package:flutter_project/models/warna.dart';

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

class KodeWarna {
  final int? id;
  final int itemId;
  final int warnaId;
  final Warna? warna;

  KodeWarna({
    this.id,
    required this.itemId,
    required this.warnaId,
    required this.warna,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'itemId': itemId,
      'warnaId': warnaId,
      // 'warna': warna.map((x) => x.toMap()).toList(),
      'warna': warna,
    };
  }

  factory KodeWarna.fromMap(Map<String, dynamic> map) {
    return KodeWarna(
      id: map['id'],
      itemId: map['itemId'] ?? '',
      warnaId: map['warnaId'] ?? '',
      warna: map['warna'] == null
          ? null
          : Warna.fromMap(map['warna'] as Map<String, dynamic>),
      // warna:
      //     List<Warna>.from(map['warna']?.map((x) => Warna.fromMap(x['warna']))),
    );
  }

  String toJson() => json.encode(toMap());

  factory KodeWarna.fromJson(String source) =>
      KodeWarna.fromMap(json.decode(source));
}
