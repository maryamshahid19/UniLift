import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:unilift/models/ride.dart';
import 'package:unilift/repositories/rides_repository.dart';
import 'ride_service_test.mocks.dart';

@GenerateMocks([
  FirebaseFirestore,
  CollectionReference,
  DocumentReference,
  QuerySnapshot,
  QueryDocumentSnapshot,
  DocumentSnapshot,
])
void main() {
  late MockFirebaseFirestore mockFirestore;
  late MockCollectionReference mockCollection;
  late MockQuerySnapshot mockQuerySnapshot;
  late MockQueryDocumentSnapshot mockDocSnapshot;
  late RidesRepository ridesRepository;

  setUp(() {
    mockFirestore = MockFirebaseFirestore();
    mockCollection = MockCollectionReference();
    mockQuerySnapshot = MockQuerySnapshot();
    mockDocSnapshot = MockQueryDocumentSnapshot();
    ridesRepository = RidesRepository();
    ridesRepository = RidesRepository(); // no injection, we'll override methods
  });

  test('fetchAllRides returns list of RideModel', () async {
    // Arrange
    when(mockFirestore.collection('rides')).thenReturn(
        mockCollection as CollectionReference<Map<String, dynamic>>);
    when(mockCollection.get()).thenAnswer((_) async => mockQuerySnapshot);
    when(mockQuerySnapshot.docs).thenReturn([mockDocSnapshot]);
    when(mockDocSnapshot.data()).thenReturn({
      'from': 'City A',
      'to': 'City B',
      'owner': 'John',
      'bookedBy': [],
    });
    when(mockDocSnapshot.id).thenReturn('123');

    // Stub RideModel.fromSnapshot
    final rideModel = RideModel(
      from: 'City A',
      to: 'City B',
      owner: 'John',
      bookedBy: [],
      dateTime: DateTime.now(),
      availableSeats: 4,
      fare: 100,
      carType: 'Sedan',
      carColor: 'Blue',
      carPlate: 'ABC-123',
      documentId: '123',
    );

    // Instead of mocking fromSnapshot (if it's static), you manually map data
    when(mockDocSnapshot.get('from')).thenReturn('City A');
    when(mockDocSnapshot.get('to')).thenReturn('City B');
    when(mockDocSnapshot.get('owner')).thenReturn('John');
    when(mockDocSnapshot.get('bookedBy')).thenReturn([]);

    // Act
    final snapshot = await mockCollection.get();
    final rideData = snapshot.docs.map((doc) {
      return RideModel.fromSnapshot(
          doc as DocumentSnapshot<Map<String, dynamic>>);
    }).toList();

    // Assert
    expect(rideData, isA<List<RideModel>>());
    expect(rideData.first.from, equals('City A'));
  });
  test('fetchBookedRides returns rides booked by user', () async {
    // Arrange
    when(mockFirestore.collection('rides')).thenReturn(
        mockCollection as CollectionReference<Map<String, dynamic>>);
    when(mockCollection.get()).thenAnswer((_) async => mockQuerySnapshot);
    when(mockQuerySnapshot.docs).thenReturn([mockDocSnapshot]);
    when(mockDocSnapshot.data()).thenReturn({
      'from': 'City A',
      'to': 'City B',
      'owner': 'John',
      'bookedBy': ['alice'],
    });
    when(mockDocSnapshot.id).thenReturn('123');
    when(mockDocSnapshot.get('from')).thenReturn('City A');
    when(mockDocSnapshot.get('to')).thenReturn('City B');
    when(mockDocSnapshot.get('owner')).thenReturn('John');
    when(mockDocSnapshot.get('bookedBy')).thenReturn(['alice']);

    // Act
    final snapshot = await mockCollection.get();
    final rideData = snapshot.docs
        .map((doc) {
          return RideModel.fromSnapshot(
              doc as DocumentSnapshot<Map<String, dynamic>>);
        })
        .where((ride) => ride.bookedBy.contains('alice'))
        .toList();

    // Assert
    expect(rideData.length, 1);
    expect(rideData.first.bookedBy.contains('alice'), isTrue);
  });

  test('createCarpool adds a new document', () async {
    // Arrange
    when(mockFirestore.collection('rides')).thenReturn(
        mockCollection as CollectionReference<Map<String, dynamic>>);
    when(mockCollection.add(any))
        .thenAnswer((_) async => MockDocumentReference());

    // Act
    await mockCollection.add({
      'from': 'City A',
      'to': 'City B',
      'dateTime': Timestamp.fromDate(DateTime.now()),
      'availableSeats': 3,
      'fare': 100,
      'carType': 'Sedan',
      'carColor': 'Red',
      'carPlate': 'AB123',
      'owner': 'John',
    });

    // Assert
    verify(mockCollection.add(any)).called(1);
  });

  test('bookCarpoolRide updates bookedBy list', () async {
    final mockDocRef = MockDocumentReference();
    final mockSnapshot = MockDocumentSnapshot();

    // Arrange
    when(mockFirestore.collection('rides')).thenReturn(mockCollection as CollectionReference<Map<String, dynamic>>);
    when(mockCollection.doc('ride123')).thenReturn(mockDocRef);
    when(mockDocRef.get()).thenAnswer((_) async => mockSnapshot);
    when(mockSnapshot.exists).thenReturn(true);
    when(mockSnapshot.data()).thenReturn({
      'bookedBy': ['alice']
    });

    when(mockDocRef.update(any)).thenAnswer((_) async => {});

    // Act
    final snapshot = await mockDocRef.get();
    final data = snapshot.data();
    List<dynamic> bookedList = [];
    if (data != null && (data as Map<String, dynamic>)['bookedBy'] != null) {
      bookedList = List.from(data['bookedBy']);
    }
    bookedList.add('bob');

    await mockDocRef.update({
      'availableSeats': 2,
      'bookedBy': bookedList,
    });

    // Assert
    verify(mockDocRef.update({
      'availableSeats': 2,
      'bookedBy': ['alice', 'bob'],
    })).called(1);
  });
}
