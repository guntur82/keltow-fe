import 'dart:convert';

// import 'package:flutter_project/models/rating.dart';

class Product {
  final int? id;
  final String name;
  final double harga;
  final String gambar;
  final String deskripsi;
  final String tanggal;
  final int stok;
  final int brandId;

  Product({
    this.id,
    required this.name,
    required this.harga,
    required this.gambar,
    required this.deskripsi,
    required this.tanggal,
    required this.stok,
    required this.brandId,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'harga': harga,
      'gambar': gambar,
      'deskripsi': deskripsi,
      'tanggal': tanggal,
      'stok': stok,
      'brandId': brandId,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      harga: map['harga']?.toDouble() ?? 0.0,
      gambar: map['gambar'] ?? '',
      deskripsi: map['deskripsi'] ?? '',
      tanggal: map['tanggal'] ?? '',
      stok: map['stok'] ?? '',
      brandId: map['brandId'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Product.fromJson(String source) =>
      Product.fromMap(json.decode(source));
}
