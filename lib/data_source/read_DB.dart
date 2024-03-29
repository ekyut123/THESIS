import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/rating_model.dart';
import '../model/counter_model.dart';
import '../model/booking_history.dart';
import '../model/business_model.dart';
import '../model/service_model.dart';
import '../model/active_booking.dart';
import '../model/b_bookinginfo.dart';
//added search
class ReadDataBase {
  static Stream<List<BusinessInfo>> readbusinessinfo() {
    final businessinfocollection =
        FirebaseFirestore.instance
        .collection('BusinessList')
        .orderBy('counter', descending: true);
    return businessinfocollection.snapshots().map((querySnapshot) =>
        querySnapshot.docs.map((e) => BusinessInfo.fromSnapshot(e)).toList());
  }

  static Stream<List<BusinessInfo>> readqueryinfo(String query) {
    final businessinfocollection = FirebaseFirestore.instance
        .collection('BusinessList')
        .where('bname', isGreaterThanOrEqualTo: query)
        .where('bname', isLessThan: '${query}z');
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
        .collection('Active Booking')
        .orderBy('date');
    return userbookingcollection.snapshots().map((querySnapshot) =>
        querySnapshot.docs.map((e) => ActiveBooking.fromSnapshot(e)).toList());
  }

  static Stream<List<BookingHistory>> readbookinghistory(String userid) {
    final userbookinghistorycollection = FirebaseFirestore.instance
        .collection('Users')
        .doc(userid)
        .collection('Booking History')
        .orderBy('date');
    return userbookinghistorycollection.snapshots().map((querySnapshot) =>
        querySnapshot.docs.map((e) => BookingHistory.fromSnapshot(e)).toList());
  }

  static Stream<List<RatingModel>> readrating(String businessid) {
    final ratingcollection = FirebaseFirestore.instance
        .collection('BusinessList')
        .doc(businessid)
        .collection('Ratings')
        .orderBy('date', descending: true);
    return ratingcollection.snapshots().map((querySnapshot) =>
        querySnapshot.docs.map((e) => RatingModel.fromSnapshot(e)).toList());
  }
  
  static Stream<List<CounterModel>> readbookedcounter(String userid, String label) {
    final ratingcollection = FirebaseFirestore.instance
    .collection('Users')
    .doc(userid)
    .collection('Booked Counter')
    .where('businessType', isEqualTo: label)
    .orderBy('counter', descending: true);
    return ratingcollection.snapshots().map((querySnapshot) =>
        querySnapshot.docs.map((e) => CounterModel.fromSnapshot(e)).toList());
  }
}
