import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/service_model.dart';

class FirestoreServiceRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<List<ServiceModel>> getAllServices() async {
    final shopsSnapshot = await _db.collection('barbershops').get();
    final List<ServiceModel> allServices = [];

    for (final shopDoc in shopsSnapshot.docs) {
      final servicesSnapshot = await shopDoc.reference.collection('services').get();
      for (final serviceDoc in servicesSnapshot.docs) {
        allServices.add(ServiceModel.fromMap(serviceDoc.id, serviceDoc.data()));
      }
    }
    return allServices;
  }

  Future<List<ServiceModel>> getServicesByShop(String shopId) async {
    final snapshot = await _db.collection('barbershops').doc(shopId).collection('services').get();
    return snapshot.docs.map((doc) => ServiceModel.fromMap(doc.id, doc.data()!)).toList();
  }

  Future<ServiceModel?> getService(String shopId, String serviceId) async {
    final doc = await _db.collection('barbershops').doc(shopId).collection('services').doc(serviceId).get();
    if (!doc.exists) return null;
    return ServiceModel.fromMap(doc.id, doc.data()!);
  }

  Future<void> createService(String shopId, ServiceModel service) async {
    final docRef = _db.collection('barbershops').doc(shopId).collection('services').doc();
    final serviceWithId = service.copyWith(id: docRef.id);
    await docRef.set(serviceWithId.toMap());
  }

  Future<void> updateService(String shopId, String serviceId, Map<String, dynamic> data) async {
    await _db.collection('barbershops').doc(shopId).collection('services').doc(serviceId).update(data);
  }

  Future<void> deleteService(String shopId, String serviceId) async {
    await _db.collection('barbershops').doc(shopId).collection('services').doc(serviceId).delete();
  }
}