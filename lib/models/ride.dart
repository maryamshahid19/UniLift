import 'package:cloud_firestore/cloud_firestore.dart';

class RideModel {
  final String from;
  final String to;
  final DateTime dateTime;
  final int availableSeats;
  final int fare;
  final String carType;
  final String carColor;
  final String carPlate;
  final String owner;
  final List bookedBy;

  RideModel({
    required this.from,
    required this.to,
    required this.dateTime,
    required this.availableSeats,
    required this.fare,
    required this.carType,
    required this.carColor,
    required this.carPlate,
    required this.owner,
    required this.bookedBy,
  });

  factory RideModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return RideModel(
      from: data['from'] ?? '',
      to: data['to'] ?? '',
      dateTime: (data['dateTime'] as Timestamp).toDate(),
      availableSeats: data['availableSeats'] ?? '',
      fare: data['fare'] ?? '',
      carType: data['carType'] ?? '',
      carColor: data['carColor'] ?? '',
      carPlate: data['carPlate'] ?? '',
      owner: data['owner'] ?? '',
      bookedBy: data['bookedBy'] ?? [],
    );
  }

  // Map<String, dynamic> toMap() {
  //   return {
  //     'from': from,
  //     'to': to,
  //     'dateTime': Timestamp.fromDate(dateTime),
  //     'availableSeats': availableSeats,
  //     'fare': fare,
  //     'carType': carType,
  //     'carColor': carColor,
  //     'carPlate': carPlate,
  //     'owner': owner,
  //     'bookedBy': bookedBy,
  //   };
  // }
}
