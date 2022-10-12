import 'dart:convert';
import 'dart:io';

class User {
  final String id;
  final String name;
  final String email;
  final String password;
  final String level;
  final String alamat;
  final String no_hp;
  final String access_token;
  final String gambar;
  final File? picture;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.level,
    required this.password,
    required this.alamat,
    required this.no_hp,
    required this.access_token,
    required this.gambar,
    this.picture,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'level': level,
      'password': password,
      'alamat': alamat,
      'no_hp': no_hp,
      'gambar': gambar,
      'access_token': access_token,
      // 'picture': picture,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      level: map['level'] ?? '',
      password: map['password'] ?? '',
      alamat: map['alamat'] ?? '',
      no_hp: map['no_hp'] ?? '',
      gambar: map['gambar'] ?? '',
      access_token: map['access_token'] ?? '',
      // picture: map['picture'],
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));
}
