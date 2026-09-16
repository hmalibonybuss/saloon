import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class BookingController extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  Future<String?> createBooking({
    required String salonId,
    required String serviceId,
    required DateTime appointmentDate,
    required String timeSlot,
    required double price,
    String? notes,
  }) async {
    try {
      _isLoading = true;
      notifyListeners();

      final userId = _auth.currentUser?.uid;
      if (userId == null) return 'User not authenticated';

      // Get service details
      final serviceDoc = await _firestore.collection('services').doc(serviceId).get();
      final serviceData = serviceDoc.data();
      if (serviceData == null) return 'Service not found';

      // Create booking
      await _firestore.collection('bookings').add({
        'userId': userId,
        'salonId': salonId,
        'serviceId': serviceId,
        'serviceName': serviceData['name'],
        'appointmentDate': Timestamp.fromDate(appointmentDate),
        'timeSlot': timeSlot,
        'price': price,
        'status': 'pending',
        'notes': notes,
        'createdAt': FieldValue.serverTimestamp(),
      });

      _isLoading = false;
      notifyListeners();
      return null;
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      return e.toString();
    }
  }

  Stream<QuerySnapshot> getUserBookings() {
    final userId = _auth.currentUser?.uid;
    if (userId == null) return Stream.empty();

    return _firestore
        .collection('bookings')
        .where('userId', isEqualTo: userId)
        .orderBy('appointmentDate', descending: true)
        .snapshots();
  }

  Future<String?> cancelBooking(String bookingId) async {
    try {
      _isLoading = true;
      notifyListeners();

      await _firestore.collection('bookings').doc(bookingId).update({
        'status': 'cancelled',
        'cancelledAt': FieldValue.serverTimestamp(),
      });

      _isLoading = false;
      notifyListeners();
      return null;
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      return e.toString();
    }
  }

  Stream<QuerySnapshot> getSalonServices(String salonId) {
    return _firestore
        .collection('services')
        .where('salonId', isEqualTo: salonId)
        .orderBy('name')
        .snapshots();
  }

  Stream<QuerySnapshot> getAvailableSalons() {
    return _firestore
        .collection('salons')
        .where('isActive', isEqualTo: true)
        .orderBy('name')
        .snapshots();
  }

  Future<List<String>> getAvailableTimeSlots({
    required String salonId,
    required DateTime date,
  }) async {
    try {
      // Get salon's working hours
      final salonDoc = await _firestore.collection('salons').doc(salonId).get();
      final salonData = salonDoc.data() as Map<String, dynamic>;
      final workingHours = salonData['workingHours'] as Map<String, dynamic>;
      
      // Get day of week (1 = Monday, 7 = Sunday)
      final dayOfWeek = date.weekday;
      
      // Get today's working hours
      final todayHours = workingHours[dayOfWeek.toString()];
      if (todayHours == null) return [];

      final startTime = TimeOfDay.fromDateTime(DateTime.parse(todayHours['start']));
      final endTime = TimeOfDay.fromDateTime(DateTime.parse(todayHours['end']));

      // Generate time slots (30 minutes interval)
      List<String> allSlots = [];
      DateTime current = DateTime(date.year, date.month, date.day, startTime.hour, startTime.minute);
      final end = DateTime(date.year, date.month, date.day, endTime.hour, endTime.minute);

      while (current.isBefore(end)) {
        allSlots.add('${current.hour.toString().padLeft(2, '0')}:${current.minute.toString().padLeft(2, '0')}');
        current = current.add(const Duration(minutes: 30));
      }

      // Get booked slots
      final bookedSlots = await _firestore
          .collection('bookings')
          .where('salonId', isEqualTo: salonId)
          .where('appointmentDate', isEqualTo: Timestamp.fromDate(DateTime(date.year, date.month, date.day)))
          .get();

      // Remove booked slots
      bookedSlots.docs.forEach((doc) {
        final data = doc.data();
        allSlots.remove(data['timeSlot']);
      });

      return allSlots;
    } catch (e) {
      return [];
    }
  }

  Future<String?> rateBooking({
    required String bookingId,
    required double rating,
    String? review,
  }) async {
    try {
      _isLoading = true;
      notifyListeners();

      final userId = _auth.currentUser?.uid;
      if (userId == null) return 'User not authenticated';

      await _firestore.collection('bookings').doc(bookingId).update({
        'rating': rating,
        'review': review,
        'ratedAt': FieldValue.serverTimestamp(),
      });

      _isLoading = false;
      notifyListeners();
      return null;
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      return e.toString();
    }
  }
} 