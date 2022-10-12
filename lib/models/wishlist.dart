import 'dart:convert';

class WishList {
  final int userId;
  final int itemId;

  WishList({
    required this.userId,
    required this.itemId,
  });

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'itemId': itemId,
    };
  }

  factory WishList.fromMap(Map<String, dynamic> map) {
    return WishList(
      userId: map['userId'] ?? '',
      itemId: map['itemId'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory WishList.fromJson(String source) =>
      WishList.fromMap(json.decode(source));
}
