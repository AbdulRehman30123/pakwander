import 'package:pakwanderer/Packages/packages.dart';

class ReservationScreen extends StatefulWidget {
  const ReservationScreen({
    super.key,
  });

  @override
  _ReservationScreenState createState() => _ReservationScreenState();
}

class _ReservationScreenState extends State<ReservationScreen> {
  late Stream<List<Reservation>> _reservationsStream;
  TextStyle roboto15 = GoogleFonts.roboto(
      fontSize: 15, color: Colors.white, fontWeight: FontWeight.w700);
  TextStyle roboto10 = GoogleFonts.roboto(
      fontSize: 10, color: Colors.white, fontWeight: FontWeight.w500);
  Future<void> deleteReservation(String userId, String hotelName) async {
    final CollectionReference reservationsCollection =
        FirebaseFirestore.instance.collection('reservations');

    try {
      // Query the reservations collection to find the document with matching userId and hotelName
      QuerySnapshot querySnapshot = await reservationsCollection
          .where('userid', isEqualTo: userId)
          .where('hotelName', isEqualTo: hotelName)
          .get();

      // Get the reference to the document to be deleted
      DocumentReference documentReference = querySnapshot.docs.first.reference;

      // Delete the document
      await documentReference.delete();
      showMessage(context, Colors.green, 'Reservation is cancelled');
      setState(() {});
    } catch (e) {
      // Handle any errors that occur
      print('Error deleting reservation: $e');
      throw Exception('Failed to delete reservation');
    }
  }

  @override
  void initState() {
    super.initState();
    _reservationsStream =
        firestoreService.getReservationsStream(firebaseAuth.currentUser!.uid);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reservations'),
      ),
      body: StreamBuilder<List<Reservation>>(
        stream: _reservationsStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return const Center(
              child: Text('Error fetching reservations'),
            );
          } else {
            List<Reservation> reservations = snapshot.data ?? [];
            return ListView.builder(
              itemCount: reservations.length,
              itemBuilder: (context, index) {
                Reservation reservation = reservations[index];
                debugPrint(reservation.timestamp.toString());
                String date = 'not matched';
                String time = 'not matched';
                // Extracting date and time from timestamp
                RegExp regExp =
                    RegExp(r"(\d{4}-\d{2}-\d{2})\s(\d{2}:\d{2}:\d{2})");
                Match? match =
                    regExp.firstMatch(reservation.timestamp.toString());
                if (match != null) {
                  date = match.group(1) ?? '';
                  time = match.group(2) ?? '';
                }

                return Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8.0, horizontal: 15),
                  child: Container(
                    decoration: BoxDecoration(
                      color: secondaryColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Hotel Name: ${reservation.hotelName} ',
                            style: roboto15,
                          ),
                          Text(
                            'Booing Date: $date ',
                            style: roboto10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Booing Time: $time ',
                                style: roboto10,
                              ),
                              GestureDetector(
                                onTap: () {
                                  deleteReservation(
                                      firebaseAuth.currentUser!.uid,
                                      reservation.hotelName);
                                },
                                child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.red),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8),
                                      child: Text(
                                        'Cancel Reservation',
                                        style: roboto10,
                                      ),
                                    )),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
