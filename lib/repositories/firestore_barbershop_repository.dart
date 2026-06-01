import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/barbershop_model.dart';
import '../models/barber_member_model.dart';
import '../models/service_model.dart';

class FirestoreBarbershopRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  static const String _collection = 'barbershops';

  Future<List<BarbershopModel>> getAllBarbershops() async {
    final snapshot = await _db.collection(_collection).get();
    return snapshot.docs.map((doc) => BarbershopModel.fromMap(doc.id, doc.data()!)).toList();
  }

  Future<BarbershopModel?> getBarbershop(String shopId) async {
    final doc = await _db.collection(_collection).doc(shopId).get();
    if (!doc.exists) return null;
    return BarbershopModel.fromMap(doc.id, doc.data()!);
  }

  Future<List<BarbershopModel>> getBarbershopsByOwner(String ownerId) async {
    final snapshot = await _db.collection(_collection).where('ownerId', isEqualTo: ownerId).get();
    return snapshot.docs.map((doc) => BarbershopModel.fromMap(doc.id, doc.data()!)).toList();
  }

  Future<void> createBarbershop(BarbershopModel shop) async {
    final docRef = _db.collection(_collection).doc();
    final shopWithId = shop.copyWith(id: docRef.id);
    await docRef.set(shopWithId.toMap());
  }

  Future<void> updateBarbershop(String shopId, Map<String, dynamic> data) async {
    await _db.collection(_collection).doc(shopId).update(data);
  }

  Future<void> deleteBarbershop(String shopId) async {
    await _db.collection(_collection).doc(shopId).delete();
  }

  Future<List<BarberMemberModel>> getShopMembers(String shopId) async {
    final snapshot = await _db.collection(_collection).doc(shopId).collection('members').get();
    return snapshot.docs.map((doc) => BarberMemberModel.fromMap(doc.data()!)).toList();
  }

  Future<void> addShopMember(String shopId, BarberMemberModel member) async {
    await _db.collection(_collection).doc(shopId).collection('members').add(member.toMap());
  }

  Future<void> removeShopMember(String shopId, String barberId) async {
    final snapshot = await _db.collection(_collection).doc(shopId).collection('members')
        .where('barberId', isEqualTo: barberId).get();
    for (final doc in snapshot.docs) {
      await doc.reference.delete();
    }
  }

  Future<List<ServiceModel>> getShopServices(String shopId) async {
    final snapshot = await _db.collection(_collection).doc(shopId).collection('services').get();
    return snapshot.docs.map((doc) => ServiceModel.fromMap(doc.id, doc.data()!)).toList();
  }

  Future<void> addShopService(String shopId, ServiceModel service) async {
    final docRef = _db.collection(_collection).doc(shopId).collection('services').doc();
    final serviceWithId = service.copyWith(id: docRef.id);
    await docRef.set(serviceWithId.toMap());
  }

  Future<void> updateShopService(String shopId, String serviceId, Map<String, dynamic> data) async {
    await _db.collection(_collection).doc(shopId).collection('services').doc(serviceId).update(data);
  }

  Future<void> deleteShopService(String shopId, String serviceId) async {
    await _db.collection(_collection).doc(shopId).collection('services').doc(serviceId).delete();
  }
}