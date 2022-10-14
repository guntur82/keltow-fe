import 'dart:convert';

class Transaction {
  final int? id;
  final String tanggal;
  final String kode_transaksi;
  final int totalHarga;
  final int cartId;

  Transaction({
    this.id,
    required this.tanggal,
    required this.kode_transaksi,
    required this.totalHarga,
    required this.cartId,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'tanggal': tanggal,
      'kode_transaksi': kode_transaksi,
      'totalHarga': totalHarga,
      'cartId': cartId,
    };
  }

  factory Transaction.fromMap(Map<String, dynamic> map) {
    return Transaction(
      id: map['id'],
      tanggal: map['tanggal'] ?? '',
      kode_transaksi: map['kode_transaksi'] ?? '',
      totalHarga: map['totalHarga'] ?? 0,
      cartId: map['cartId'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Transaction.fromJson(String source) =>
      Transaction.fromMap(json.decode(source));
}
