import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String uid;
  final String? barbershopId;
  final String fullName;
  final String email;
  final String role;
  final bool isActive;
  final DateTime createdAt;

  const UserModel({
    required this.uid,
    this.barbershopId,
    required this.fullName,
    required this.email,
    required this.role,
    this.isActive = true,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'barbershopId': barbershopId,
      'fullName': fullName,
      'email': email,
      'role': role,
      'isActive': isActive,
      'createdAt': Timestamp.fromMillisecondsSinceEpoch(createdAt.millisecondsSinceEpoch),
    };
  }

  factory UserModel.fromMap(String uid, Map<String, dynamic> map) {
    Timestamp ts = map['createdAt'];
    DateTime createdAtDate = DateTime.fromMillisecondsSinceEpoch(ts.millisecondsSinceEpoch);
    return UserModel(
      uid: uid,
      barbershopId: map['barbershopId'] as String?,
      fullName: map['fullName'] as String? ?? '',
      email: map['email'] as String? ?? '',
      role: map['role'] as String? ?? 'client',
      isActive: map['isActive'] as bool? ?? true,
      createdAt: createdAtDate,
    );
  }

  UserModel copyWith({
    String? uid,
    String? barbershopId,
    String? fullName,
    String? email,
    String? role,
    bool? isActive,
    DateTime? createdAt,
  }) {
    return UserModel(
      uid: uid ?? this.uid,
      barbershopId: barbershopId ?? this.barbershopId,
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      role: role ?? this.role,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}