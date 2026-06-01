import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

enum BookingStatus {
  pending,
  confirmed,
  inProgress,
  completed,
  cancelled;

  String get label {
    switch (this) {
      case BookingStatus.pending:
        return 'Pending';
      case BookingStatus.confirmed:
        return 'Confirmed';
      case BookingStatus.inProgress:
        return 'In Progress';
      case BookingStatus.completed:
        return 'Completed';
      case BookingStatus.cancelled:
        return 'Cancelled';
    }
  }

  Color get color {
    switch (this) {
      case BookingStatus.pending:
        return Colors.orange;
      case BookingStatus.confirmed:
        return Colors.blue;
      case BookingStatus.inProgress:
        return Colors.purple;
      case BookingStatus.completed:
        return Colors.green;
      case BookingStatus.cancelled:
        return Colors.red;
    }
  }

  static BookingStatus fromString(String value) {
    return BookingStatus.values.firstWhere(
      (e) => e.name == value,
      orElse: () => BookingStatus.pending,
    );
  }
}

class BookingModel {
  final String id;
  final String barberId;
  final String barbershopId;
  final String clientId;
  final String serviceId;
  final String dateKey;
  final DateTime slotStart;
  final DateTime slotEnd;
  final BookingStatus status;
  final double price;
  final int durationMinutes;
  final Map<String, dynamic> clientSnapshot;
  final Map<String, dynamic> barberSnapshot;
  final Map<String, dynamic> shopSnapshot;
  final Map<String, dynamic> serviceSnapshot;

  const BookingModel({
    required this.id,
    required this.barberId,
    required this.barbershopId,
    required this.clientId,
    required this.serviceId,
    required this.dateKey,
    required this.slotStart,
    required this.slotEnd,
    required this.status,
    required this.price,
    required this.durationMinutes,
    required this.clientSnapshot,
    required this.barberSnapshot,
    required this.shopSnapshot,
    required this.serviceSnapshot,
  });

  Map<String, dynamic> toMap() {
    return {
      'barberId': barberId,
      'barbershopId': barbershopId,
      'clientId': clientId,
      'serviceId': serviceId,
      'dateKey': dateKey,
      'slotStart': Timestamp.fromMillisecondsSinceEpoch(slotStart.millisecondsSinceEpoch),
      'slotEnd': Timestamp.fromMillisecondsSinceEpoch(slotEnd.millisecondsSinceEpoch),
      'status': status.name,
      'price': price,
      'durationMinutes': durationMinutes,
      'clientSnapshot': clientSnapshot,
      'barberSnapshot': barberSnapshot,
      'shopSnapshot': shopSnapshot,
      'serviceSnapshot': serviceSnapshot,
    };
  }

  factory BookingModel.fromMap(String id, Map<String, dynamic> map) {
    Timestamp startTs = map['slotStart'];
    Timestamp endTs = map['slotEnd'];
    DateTime startDate = DateTime.fromMillisecondsSinceEpoch(startTs.millisecondsSinceEpoch);
    DateTime endDate = DateTime.fromMillisecondsSinceEpoch(endTs.millisecondsSinceEpoch);
    return BookingModel(
      id: id,
      barberId: map['barberId'] as String? ?? '',
      barbershopId: map['barbershopId'] as String? ?? '',
      clientId: map['clientId'] as String? ?? '',
      serviceId: map['serviceId'] as String? ?? '',
      dateKey: map['dateKey'] as String? ?? '',
      slotStart: startDate,
      slotEnd: endDate,
      status: BookingStatus.fromString(map['status'] as String? ?? 'pending'),
      price: (map['price'] as num?)?.toDouble() ?? 0.0,
      durationMinutes: map['durationMinutes'] as int? ?? 0,
      clientSnapshot: Map<String, dynamic>.from(map['clientSnapshot'] ?? {}),
      barberSnapshot: Map<String, dynamic>.from(map['barberSnapshot'] ?? {}),
      shopSnapshot: Map<String, dynamic>.from(map['shopSnapshot'] ?? {}),
      serviceSnapshot: Map<String, dynamic>.from(map['serviceSnapshot'] ?? {}),
    );
  }

  BookingModel copyWith({
    String? id,
    String? barberId,
    String? barbershopId,
    String? clientId,
    String? serviceId,
    String? dateKey,
    DateTime? slotStart,
    DateTime? slotEnd,
    BookingStatus? status,
    double? price,
    int? durationMinutes,
    Map<String, dynamic>? clientSnapshot,
    Map<String, dynamic>? barberSnapshot,
    Map<String, dynamic>? shopSnapshot,
    Map<String, dynamic>? serviceSnapshot,
  }) {
    return BookingModel(
      id: id ?? this.id,
      barberId: barberId ?? this.barberId,
      barbershopId: barbershopId ?? this.barbershopId,
      clientId: clientId ?? this.clientId,
      serviceId: serviceId ?? this.serviceId,
      dateKey: dateKey ?? this.dateKey,
      slotStart: slotStart ?? this.slotStart,
      slotEnd: slotEnd ?? this.slotEnd,
      status: status ?? this.status,
      price: price ?? this.price,
      durationMinutes: durationMinutes ?? this.durationMinutes,
      clientSnapshot: clientSnapshot ?? this.clientSnapshot,
      barberSnapshot: barberSnapshot ?? this.barberSnapshot,
      shopSnapshot: shopSnapshot ?? this.shopSnapshot,
      serviceSnapshot: serviceSnapshot ?? this.serviceSnapshot,
    );
  }

  String get clientName => clientSnapshot['name'] as String? ?? '';
  String get barberName => barberSnapshot['name'] as String? ?? '';
  String get shopName => shopSnapshot['name'] as String? ?? '';
  String get serviceName => serviceSnapshot['name'] as String? ?? '';
}