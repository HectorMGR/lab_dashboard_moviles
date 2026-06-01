import 'package:cloud_firestore/cloud_firestore.dart';

class BarbershopModel {
  final String id;
  final String ownerId;
  final String ownerName;
  final String name;
  final String phone;
  final String address;
  final double lat;
  final double lng;
  final String imageUrl;
  final double rating;
  final int reviewCount;
  final bool hasActivePromotion;
  final List<String> tags;
  final bool isActive;
  final DateTime createdAt;

  const BarbershopModel({
    required this.id,
    required this.ownerId,
    required this.ownerName,
    required this.name,
    required this.phone,
    required this.address,
    required this.lat,
    required this.lng,
    required this.imageUrl,
    required this.rating,
    required this.reviewCount,
    required this.hasActivePromotion,
    required this.tags,
    required this.isActive,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'ownerId': ownerId,
      'ownerName': ownerName,
      'name': name,
      'phone': phone,
      'address': address,
      'lat': lat,
      'lng': lng,
      'imageUrl': imageUrl,
      'rating': rating,
      'reviewCount': reviewCount,
      'hasActivePromotion': hasActivePromotion,
      'tags': tags,
      'isActive': isActive,
      'createdAt': Timestamp.fromMillisecondsSinceEpoch(createdAt.millisecondsSinceEpoch),
    };
  }

  factory BarbershopModel.fromMap(String id, Map<String, dynamic> map) {
    Timestamp ts = map['createdAt'];
    DateTime createdAtDate = DateTime.fromMillisecondsSinceEpoch(ts.millisecondsSinceEpoch);
    return BarbershopModel(
      id: id,
      ownerId: map['ownerId'] as String? ?? '',
      ownerName: map['ownerName'] as String? ?? '',
      name: map['name'] as String? ?? '',
      phone: map['phone'] as String? ?? '',
      address: map['address'] as String? ?? '',
      lat: (map['lat'] as num?)?.toDouble() ?? 0.0,
      lng: (map['lng'] as num?)?.toDouble() ?? 0.0,
      imageUrl: map['imageUrl'] as String? ?? '',
      rating: (map['rating'] as num?)?.toDouble() ?? 0.0,
      reviewCount: map['reviewCount'] as int? ?? 0,
      hasActivePromotion: map['hasActivePromotion'] as bool? ?? false,
      tags: List<String>.from(map['tags'] ?? []),
      isActive: map['isActive'] as bool? ?? true,
      createdAt: createdAtDate,
    );
  }

  BarbershopModel copyWith({
    String? id,
    String? ownerId,
    String? ownerName,
    String? name,
    String? phone,
    String? address,
    double? lat,
    double? lng,
    String? imageUrl,
    double? rating,
    int? reviewCount,
    bool? hasActivePromotion,
    List<String>? tags,
    bool? isActive,
    DateTime? createdAt,
  }) {
    return BarbershopModel(
      id: id ?? this.id,
      ownerId: ownerId ?? this.ownerId,
      ownerName: ownerName ?? this.ownerName,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      address: address ?? this.address,
      lat: lat ?? this.lat,
      lng: lng ?? this.lng,
      imageUrl: imageUrl ?? this.imageUrl,
      rating: rating ?? this.rating,
      reviewCount: reviewCount ?? this.reviewCount,
      hasActivePromotion: hasActivePromotion ?? this.hasActivePromotion,
      tags: tags ?? this.tags,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}