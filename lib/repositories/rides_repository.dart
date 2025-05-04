import 'package:cloud_firestore/cloud_firestore.dart';

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

  Future<void> createCarpool(
    String from,
    String to,
    DateTime dateTime,
    int availableSeats,
    int fare,
    String carType,
    String carColor,
    String carPlate,
    String owner,
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
      'owner': owner,
    });
  }
}
