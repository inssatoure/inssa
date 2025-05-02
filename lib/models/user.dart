// ignore_for_file: constant_identifier_names

import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

const String ADMIN_PERMISSION = "admin";
const String CUSTOMER_PERMISSION = "customer";

@immutable
class UserData extends Equatable {
  final String uid;
  final String email;
  final String username;
  final String phone;
  final String profileImageUrl;
  final int createdAt;
  final int updatedAt;
  final bool isActive;
  final int dob;
  final List<String> permisions;
  final String logos;

  bool get isAdmin => permisions.contains(ADMIN_PERMISSION);

  const UserData({
    required this.uid,
    required this.email,
    required this.username,
    required this.phone,
    required this.profileImageUrl,
    required this.createdAt,
    required this.updatedAt,
    required this.isActive,
    required this.dob,
    required this.permisions,
    required this.logos,
  });

  @override
  List<Object> get props {
    return [
      uid,
      email,
      username,
      phone,
      profileImageUrl,
      createdAt,
      updatedAt,
      isActive,
      dob,
      permisions,
      logos
    ];
  }

  UserData copyWith({
    String? uid,
    String? email,
    String? username,
    String? phone,
    String? profileImageUrl,
    int? createdAt,
    int? updatedAt,
    bool? isActive,
    int? dob,
    List<String>? permisions,
    String? logos,
  }) {
    return UserData(
      uid: uid ?? this.uid,
      email: email ?? this.email,
      username: username ?? this.username,
      phone: phone ?? this.phone,
      profileImageUrl: profileImageUrl ?? this.profileImageUrl,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      isActive: isActive ?? this.isActive,
      dob: dob ?? this.dob,
      permisions: permisions ?? this.permisions,
      logos: logos ?? this.logos,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'username': username,
      'phone': phone,
      'profileImageUrl': profileImageUrl,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'isActive': isActive,
      'dob': dob,
      'permisions': permisions,
      'logos': logos,
    };
  }

  factory UserData.fromMap(Map<String, dynamic> map) {
    return UserData(
      uid: map['uid'] ?? '',
      email: map['email'] ?? '',
      username: map['username'] ?? '',
      phone: map['phone'] ?? '',
      profileImageUrl: map['profileImageUrl'] ?? '',
      createdAt: map['createdAt'] ?? 0,
      updatedAt: map['updatedAt'] ?? 0,
      isActive: map['isActive'] ?? false,
      dob: map['dob'] ?? 0,
      permisions: List<String>.from(map['permisions'] ?? []),
      logos: map['logos'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory UserData.fromJson(String source) =>
      UserData.fromMap(json.decode(source));

  @override
  String toString() {
    return 'User(uid: $uid, email: $email, username: $username, phone: $phone, profileImageUrl: $profileImageUrl, createdAt: $createdAt, updatedAt: $updatedAt, isActive: $isActive, dob: $dob, permisions: $permisions, logos: $logos)';
  }
}
