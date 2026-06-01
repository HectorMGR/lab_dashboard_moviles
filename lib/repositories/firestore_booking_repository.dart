import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/booking_model.dart';

class FirestoreBookingRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  static const String _collection = 'bookings';

  Future<List<BookingModel>> getAllBookings() async {
    final snapshot = await _db.collection(_collection).get();
    return snapshot.docs.map((doc) => BookingModel.fromMap(doc.id, doc.data()!)).toList();
  }

  Future<List<BookingModel>> getBookingsByShop(String shopId) async {
    final snapshot = await _db
        .collection(_collection)
        .where('barbershopId', isEqualTo: shopId)
        .get();
    return snapshot.docs.map((doc) => BookingModel.fromMap(doc.id, doc.data()!)).toList();
  }

  Future<List<BookingModel>> getBookingsByDateRange(DateTime start, DateTime end) async {
    final snapshot = await _db
        .collection(_collection)
        .where('slotStart', isGreaterThanOrEqualTo: start)
        .where('slotStart', isLessThan: end)
        .get();
    return snapshot.docs.map((doc) => BookingModel.fromMap(doc.id, doc.data()!)).toList();
  }

  Future<List<BookingModel>> getBookingsByShopAndDateRange(
      String shopId, DateTime start, DateTime end) async {
    final snapshot = await _db
        .collection(_collection)
        .where('barbershopId', isEqualTo: shopId)
        .where('slotStart', isGreaterThanOrEqualTo: start)
        .where('slotStart', isLessThan: end)
        .get();
    return snapshot.docs.map((doc) => BookingModel.fromMap(doc.id, doc.data()!)).toList();
  }

  Future<List<BookingModel>> getBookingsByClient(String clientId) async {
    final snapshot = await _db.collection(_collection).where('clientId', isEqualTo: clientId).get();
    return snapshot.docs.map((doc) => BookingModel.fromMap(doc.id, doc.data()!)).toList();
  }

  Future<List<BookingModel>> getBookingsByBarber(String barberId) async {
    final snapshot = await _db.collection(_collection).where('barberId', isEqualTo: barberId).get();
    return snapshot.docs.map((doc) => BookingModel.fromMap(doc.id, doc.data()!)).toList();
  }

  Future<BookingModel?> getBooking(String bookingId) async {
    final doc = await _db.collection(_collection).doc(bookingId).get();
    if (!doc.exists) return null;
    return BookingModel.fromMap(doc.id, doc.data()!);
  }

  Future<String> createBooking(BookingModel booking) async {
    final docRef = _db.collection(_collection).doc();
    final bookingWithId = booking.copyWith(id: docRef.id);
    await docRef.set(bookingWithId.toMap());
    return docRef.id;
  }

  Future<void> updateBookingStatus(String bookingId, BookingStatus status) async {
    await _db.collection(_collection).doc(bookingId).update({'status': status.name});
  }

  Future<void> cancelBooking(String bookingId) async {
    await _db.collection(_collection).doc(bookingId).update({'status': 'cancelled'});
  }

  Future<void> updateBooking(String bookingId, Map<String, dynamic> data) async {
    await _db.collection(_collection).doc(bookingId).update(data);
  }
}