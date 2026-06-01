import 'package:cloud_firestore/cloud_firestore.dart';

class BarberMemberModel {
  final String barberId;
  final String barberName;
  final String role;
  final DateTime joinedAt;

  const BarberMemberModel({
    required this.barberId,
    required this.barberName,
    required this.role,
    required this.joinedAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'barberId': barberId,
      'barberName': barberName,
      'role': role,
      'joinedAt': Timestamp.fromMillisecondsSinceEpoch(joinedAt.millisecondsSinceEpoch),
    };
  }

  factory BarberMemberModel.fromMap(Map<String, dynamic> map) {
    Timestamp ts = map['joinedAt'];
    DateTime joinedAtDate = DateTime.fromMillisecondsSinceEpoch(ts.millisecondsSinceEpoch);
    return BarberMemberModel(
      barberId: map['barberId'] as String? ?? '',
      barberName: map['barberName'] as String? ?? '',
      role: map['role'] as String? ?? 'barber',
      joinedAt: joinedAtDate,
    );
  }

  bool get isOwner => role == 'owner';
  bool get isBarber => role == 'barber';
}