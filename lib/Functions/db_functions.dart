import 'package:pakwanderer/Packages/packages.dart';

class FirestoreService {
  Future<List<Map<String, dynamic>>> getHotels(String collectionName) async {
    final CollectionReference hotelCollection =
        FirebaseFirestore.instance.collection(collectionName);
    List<Map<String, dynamic>> hotels = [];

    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot = await hotelCollection
          .doc('yEXDQt2kDZdTinqSGL55')
          .collection('hotel')
          .get();

      for (var doc in querySnapshot.docs) {
        Map<String, dynamic> hotelData = {
          'id': doc.id,
          'info': doc['info'],
          'location': doc['location'],
          'name': doc['name'],
          'rent': doc['rent'],
          'pics': List<String>.from(doc['pics']),
        };
        hotels.add(hotelData);
      }
    } catch (e) {
      debugPrint('Error fetching data: $e');
    }

    return hotels;
  }

  Future<List<Map<String, dynamic>>> getPlaces(String collectionName) async {
    final CollectionReference placesCollection =
        FirebaseFirestore.instance.collection(collectionName);
    List<Map<String, dynamic>> places = [];

    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot = await placesCollection
          .doc('yEXDQt2kDZdTinqSGL55')
          .collection('visitingplaces')
          .get();

      for (var doc in querySnapshot.docs) {
        Map<String, dynamic> placesData = {
          'id': doc.id,
          'info': doc['info'],
          'location': doc['location'],
          'name': doc['name'],
          'pics': List<String>.from(doc['pics']),
        };
        places.add(placesData);
      }
    } catch (e) {
      debugPrint('Error fetching data: $e');
    }

    return places;
  }

  Future<List<Map<String, dynamic>>> getRestaurants(
      String collectionName) async {
    final CollectionReference placesCollection =
        FirebaseFirestore.instance.collection(collectionName);
    List<Map<String, dynamic>> places = [];

    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot = await placesCollection
          .doc('yEXDQt2kDZdTinqSGL55')
          .collection('restraunt')
          .get();

      for (var doc in querySnapshot.docs) {
        Map<String, dynamic> placesData = {
          'id': doc.id,
          'info': doc['info'],
          'location': doc['location'],
          'name': doc['name'],
          'menupic': doc['menupic'],
          'pics': List<String>.from(doc['pics']),
        };
        places.add(placesData);
      }
    } catch (e) {
      debugPrint('Error fetching data: $e');
    }

    return places;
  }

  // stream builder functions
  Stream<List<Map<String, dynamic>>> streamHotels(String cityName) async* {
    final CollectionReference hotelCollection =
        FirebaseFirestore.instance.collection(cityName);

    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot = await hotelCollection
          .doc('yEXDQt2kDZdTinqSGL55')
          .collection('hotel')
          .get();

      List<Map<String, dynamic>> hotels = querySnapshot.docs.map((doc) {
        return {
          'id': doc.id,
          'info': doc['info'],
          'location': doc['location'],
          'name': doc['name'],
          'rent': doc['rent'],
          'pics': List<String>.from(doc['pics']),
        };
      }).toList();

      yield hotels;
    } catch (e) {
      debugPrint('Error fetching data: $e');
      yield []; // Return an empty list in case of an error
    }
  }

  Stream<List<Map<String, dynamic>>> getPlacesStream(String cityName) {
    final CollectionReference placesCollection =
        FirebaseFirestore.instance.collection(cityName);

    return placesCollection
        .doc('yEXDQt2kDZdTinqSGL55')
        .collection('visitingplaces')
        .snapshots()
        .map((querySnapshot) {
      List<Map<String, dynamic>> places = [];
      for (var doc in querySnapshot.docs) {
        Map<String, dynamic> placeData = {
          'id': doc.id,
          'info': doc['info'],
          'location': doc['location'],
          'name': doc['name'],
          'pics': List<String>.from(doc['pics']),
        };
        places.add(placeData);
      }
      return places;
    });
  }

  Stream<List<Map<String, dynamic>>> getRestaurantsStream(String cityName) {
    final CollectionReference restaurantsCollection =
        FirebaseFirestore.instance.collection(cityName);

    return restaurantsCollection
        .doc('yEXDQt2kDZdTinqSGL55')
        .collection('restraunt')
        .snapshots()
        .map((querySnapshot) {
      List<Map<String, dynamic>> restaurants = [];
      for (var doc in querySnapshot.docs) {
        Map<String, dynamic> restaurantData = {
          'id': doc.id,
          'info': doc['info'],
          'location': doc['location'],
          'name': doc['name'],
          'menupic': doc['menupic'],
          'pics': List<String>.from(doc['pics']),
        };
        restaurants.add(restaurantData);
      }
      return restaurants;
    });
  }

  // get user reservations
  final CollectionReference reservationsCollection =
      FirebaseFirestore.instance.collection('reservations');

  Stream<List<Reservation>> getReservationsStream(userId) {
    return reservationsCollection
        .where('userid', isEqualTo: userId)
        .snapshots()
        .map((querySnapshot) => querySnapshot.docs.map((doc) {
              Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
              return Reservation(
                email: data['email'],
                name: data['name'],
                number: data['number'],
                timestamp: (data['timestamp'] as Timestamp).toDate(),
                userId: data['userid'],
                hotelName: data['hotelName'],
              );
            }).toList());
  }
}
