import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:unilift/models/ride.dart';

class RidesRepository {
  final _db = FirebaseFirestore.instance;

  // Future<List<Alert>> fetchAllAlerts() async {
  //   final snapshot = await _db
  //       .collection('alerts')
  //       .orderBy('timestamp', descending: true)
  //       .get();
  //   final alertData =
  //       snapshot.docs.map((doc) => Alert.fromSnapshot(doc)).toList();

  //   return alertData;
  // }

  // Future<List<Alert>> fetchAssignedAlerts(String volId) async {
  //   final snapshot = await _db
  //       .collection('alerts')
  //       .orderBy('timestamp', descending: true)
  //       .get();
  //   final alertData = snapshot.docs
  //       .map((doc) => Alert.fromSnapshot(doc))
  //       .where((alert) => alert.assignedTo == volId)
  //       .toList();

  //   return alertData;
  // }

  // Future<List<Alert>> fetchGeneratedAlerts(String volId) async {
  //   final snapshot = await _db
  //       .collection('alerts')
  //       .orderBy('timestamp', descending: true)
  //       .get();
  //   final alertData = snapshot.docs
  //       .map((doc) => Alert.fromSnapshot(doc))
  //       .where((alert) => alert.source == volId)
  //       .toList();

  //   return alertData;
  // }

  // Future<int> fetchTaskCompletedCount(String volId) async {
  //   final snapshot = await _db.collection('alerts').get();

  //   final taskCompleted = snapshot.docs
  //       .map((doc) => Alert.fromSnapshot(doc))
  //       .where(
  //           (alert) => alert.assignedTo == volId && alert.status == 'resolved')
  //       .toList();

  //   return taskCompleted.length;
  // }

  // Future<int> fetchTaskGeneratedCount(String volId) async {
  //   final snapshot = await _db.collection('alerts').get();

  //   final taskGenerated = snapshot.docs
  //       .map((doc) => Alert.fromSnapshot(doc))
  //       .where((alert) => alert.source == volId)
  //       .toList();

  //   return taskGenerated.length;
  // }

  // Future<int> fetchTaskOngoingCount(String volId) async {
  //   final snapshot = await _db.collection('alerts').get();

  //   final taskOngoing = snapshot.docs
  //       .map((doc) => Alert.fromSnapshot(doc))
  //       .where(
  //           (alert) => alert.assignedTo == volId && alert.status == 'assigned')
  //       .toList();

  //   return taskOngoing.length;
  // }

  // Future<void> updateAlertStatus(
  //     String documentId, String newStatus, String volId) async {
  //   await _db.collection('alerts').doc(documentId).update({
  //     'status': newStatus,
  //     'assigned_to': volId,
  //   });
  // }
  Future<List<RideModel>> fetchAllRides() async {
    final snapshot = await _db.collection('rides').get();
    final rideData =
        snapshot.docs.map((doc) => RideModel.fromSnapshot(doc)).toList();

    return rideData;
  }

  Future<void> createCarpool(
    String from,
    String to,
    DateTime dateTime,
    int availableSeats,
    int fare,
    String carType,
    String carColor,
    String carPlate,
    String ownerId,
  ) async {
    await _db.collection('rides').add({
      'from': from,
      'to': to,
      'dateTime': Timestamp.fromDate(dateTime),
      'availableSeats': availableSeats,
      'fare': fare,
      'carType': carType,
      'carColor': carColor,
      'carPlate': carPlate,
      'owner': ownerId,
    });
  }

  Future<void> bookCarpoolRide(
      String documentId, int availableSeats, String userId) async {
    final docRef = _db.collection('rides').doc(documentId);
    final snapshot = await docRef.get();

    if (snapshot.exists) {
      List<dynamic> bookedList = [];
      final data = snapshot.data();

      if (data != null && data['bookedBy'] != null) {
        bookedList = List.from(data['bookedBy']);
      }

      bookedList.add(userId);

      await docRef.update({
        'availableSeats': availableSeats,
        'bookedBy': bookedList,
      });
    }
  }
}
