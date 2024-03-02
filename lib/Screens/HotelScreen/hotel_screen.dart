// ignore_for_file: must_be_immutable

import 'package:pakwanderer/Packages/packages.dart';

class HotelScreen extends StatefulWidget {
  String hotelName;
  String hotelLocation;
  String hotelRent;
  String hotelInfo;
  List<dynamic> hotelPics;
  String cityName;
  HotelScreen(
      {super.key,
      required this.hotelName,
      required this.hotelLocation,
      required this.hotelRent,
      required this.hotelInfo,
      required this.hotelPics,
      required this.cityName});

  @override
  State<HotelScreen> createState() => _HotelScreenState();
}

class _HotelScreenState extends State<HotelScreen> {
  bool makingReservation = false;
  Future<void> storeReservationData(String bookingByName, String bookingById,
      String userEmail, String userNumber, String hotelName) async {
    setState(() {
      makingReservation = true;
    });
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        await FirebaseFirestore.instance.collection('reservations').add({
          'name': bookingByName,
          'userid': bookingById,
          'email': userEmail,
          'number': userNumber,
          'timestamp': Timestamp.now(),
          'hotelName': hotelName,
          // If you want to add timestamp of reservation
        });
        setState(() {
          makingReservation = false;
        });
        showMessage(context, Colors.green,
            'Reservation Made , You will recieve a confirmation call shortly!!');
      } else {
        print('User not signed in');
      }
    } catch (e) {
      setState(() {
        makingReservation = false;
      });
      print('Error storing reservation data: $e');
    }
  }

  Future<Map<String, dynamic>?> fetchUserInfo(String userId) async {
    try {
      DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .get();
      if (snapshot.exists) {
        return snapshot.data()
            as Map<String, dynamic>; // Explicit cast to Map<String, dynamic>
      } else {
        print('User data does not exist');
        return null;
      }
    } catch (e) {
      print('Error fetching user info: $e');
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.sizeOf(context).height;
    return Scaffold(
      body: Container(
        height: height,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: CachedNetworkImageProvider(widget.hotelPics[0]),
              fit: BoxFit.cover,
              filterQuality: FilterQuality.high),
        ),
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: height * .78,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 20.0, left: 10),
                  child: Text(
                    widget.hotelName,
                    style: roboto2Italic,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.hotelLocation,
                        style: openSans2,
                      ),
                      GestureDetector(
                        onTap: () {
                          screenFunctions.nextScreen(
                              context, AllLakes(cityName: widget.cityName));
                        },
                        child: Container(
                          alignment: Alignment.center,
                          height: 20,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: secondaryColor),
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 4.0),
                            child: Text(
                              'See nearby places',
                              style: GoogleFonts.roboto(
                                  fontSize: 10,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5.0, left: 10),
                  child: Text(
                    'Hotel Rent',
                    style: roboto2Italic,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: Text(
                    'Rs: ${widget.hotelRent} / Night',
                    style: openSans3,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5.0, left: 10),
                  child: Text(
                    'Information',
                    style: roboto2Italic,
                  ),
                ),
                SizedBox(
                  height: 80,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      child: Text(
                        widget.hotelInfo,
                        style: openSans2,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 300,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: widget.hotelPics.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(
                            top: 5.0,
                            right: 5,
                            left: 5,
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: SizedBox(
                              width: 250,
                              child: Image(
                                image: CachedNetworkImageProvider(
                                    widget.hotelPics[index]),
                                filterQuality: FilterQuality.high,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        );
                      }),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 5.0, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      circularButton(
                        Icons.favorite_outline,
                        () {
                          hotelData.saveHotelData(
                              hotelName: widget.hotelName,
                              hotelLocation: widget.hotelLocation,
                              hotelRent: widget.hotelRent,
                              hotelInfo: widget.hotelInfo,
                              hotelPics: widget.hotelPics,
                              context: context,
                              cityName: widget.cityName);
                        },
                      ),
                      rectangularButton('See on Map', () {
                        openGoogleMaps(widget.hotelLocation);
                      }),
                      rectangularButton(
                          makingReservation ? 'Booking..' : 'Book Now', () {
                        firebaseAuth.currentUser == null
                            ? screenFunctions.nextScreen(
                                context, const LoginScreen())
                            : fetchUserInfo(firebaseAuth.currentUser!.uid)
                                .then((userInfo) {
                                if (userInfo != null) {
                                  storeReservationData(
                                      userInfo['name'],
                                      firebaseAuth.currentUser!.uid,
                                      userInfo['email'],
                                      userInfo['number'],
                                      widget.hotelName);
                                } else {
                                  debugPrint('User Info not found');
                                }
                              });
                      }),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget circularButton(IconData? icon, Function()? onTap) {
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(50)),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          color: Colors.red,
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Icon(
              icon,
              color: Colors.white,
              size: 30,
            ),
          ),
        ),
      ),
    );
  }

  Widget rectangularButton(String buttonTitle, Function()? onTap) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(5),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          alignment: Alignment.center,
          width: 150,
          color: secondaryColor,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 5),
            child: Text(
              buttonTitle,
              style: roboto20,
            ),
          ),
        ),
      ),
    );
  }

  void openGoogleMaps(String address) async {
    // Encode the address to make it URL-safe
    String encodedAddress = Uri.encodeComponent(address);

    var url = 'https://www.google.com/maps/search/?api=1&query=$encodedAddress';

    // Check if the Google Maps app is installed
    await launch(url);
  }
}
