import 'dart:convert';

class Cart {
  final int? id;
  final String tanggal;
  final int jumlah;
  final double ratting;
  final int status_barang;
  final int status_pengiriman;
  final int itemId;
  final int userId;

  Cart({
    this.id,
    required this.tanggal,
    required this.jumlah,
    required this.ratting,
    required this.status_barang,
    required this.status_pengiriman,
    required this.itemId,
    required this.userId,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'tanggal': tanggal,
      'jumlah': jumlah,
      'ratting': ratting,
      'status_barang': status_barang,
      'status_pengiriman': status_pengiriman,
      'itemId': itemId,
      'userId': userId,
    };
  }

  factory Cart.fromMap(Map<String, dynamic> map) {
    return Cart(
      id: map['id'],
      tanggal: map['tanggal'] ?? '',
      jumlah: map['jumlah'] ?? 0,
      ratting: map['ratting']?.toDouble() ?? 0.0,
      status_barang: map['status_barang'] ?? '',
      status_pengiriman: map['status_pengiriman'] ?? '',
      itemId: map['itemId'] ?? '',
      userId: map['userId'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Cart.fromJson(String source) => Cart.fromMap(json.decode(source));
}
