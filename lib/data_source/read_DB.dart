import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/business_model.dart';
import '../model/service_model.dart';
import '../model/active_booking.dart';
import '../model/business_bookinginfo.dart';

class ReadDataBase {
  static Stream<List<BusinessInfo>> readbusinessinfo() {
    final businessinfocollection =
        FirebaseFirestore.instance.collection('BusinessList');
    return businessinfocollection.snapshots().map((querySnapshot) =>
        querySnapshot.docs.map((e) => BusinessInfo.fromSnapshot(e)).toList());
  }

  static Stream<List<BusinessInfo>> readpersonalcareinfo() {
    final personalcarecollection = FirebaseFirestore.instance
        .collection('BusinessList')
        .where('businessType', isEqualTo: "Personal Care");
    return personalcarecollection.snapshots().map((querySnapshot) =>
        querySnapshot.docs.map((e) => BusinessInfo.fromSnapshot(e)).toList());
  }

  static Stream<List<BusinessInfo>> readhealthcareinfo() {
    final healthcarecollection = FirebaseFirestore.instance
        .collection('BusinessList')
        .where('businessType', isEqualTo: "Health Care");
    return healthcarecollection.snapshots().map((querySnapshot) =>
        querySnapshot.docs.map((e) => BusinessInfo.fromSnapshot(e)).toList());
  }

  static Stream<List<ServiceInfo>> readserviceinfo() {
    final servicecollection = FirebaseFirestore.instance.collection('Services');
    return servicecollection.snapshots().map((querySnapshot) =>
        querySnapshot.docs.map((e) => ServiceInfo.fromSnapshot(e)).toList());
  }

  static Stream<List<BookingInfo>> readtimeslot(String id, String date) {
    final bookingcollection = FirebaseFirestore.instance
        .collection('BusinessList')
        .doc(id)
        .collection('All Bookings')
        .doc(date)
        .collection('Slots');
    return bookingcollection.snapshots().map((querySnapshot) =>
        querySnapshot.docs.map((e) => BookingInfo.fromSnapshot(e)).toList());
  }

  static Stream<List<ActiveBooking>> readactivebooking(String userid) {
    final userbookingcollection = FirebaseFirestore.instance
    .collection('Users')
    .doc(userid)
    .collection('Active Booking');
    return userbookingcollection.snapshots().map((querySnapshot) =>
        querySnapshot.docs.map((e) => ActiveBooking.fromSnapshot(e)).toList());
  }
}
