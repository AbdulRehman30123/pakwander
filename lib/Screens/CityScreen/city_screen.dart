import 'package:pakwanderer/Packages/packages.dart';

class CityScreen extends StatefulWidget {
  String cityName;
  CityScreen({super.key, required this.cityName});

  @override
  State<CityScreen> createState() => _CityScreenState();
}

class _CityScreenState extends State<CityScreen> {
  late Future<List<Map<String, dynamic>>> _hotelsFuture;
  late Future<List<Map<String, dynamic>>> _placesFuture;
  late Future<List<Map<String, dynamic>>> _restaurantFuture;
  @override
  void initState() {
    _hotelsFuture = FirestoreService().getHotels(widget.cityName);
    _placesFuture = FirestoreService().getPlaces(widget.cityName);
    _restaurantFuture = FirestoreService().getRestaurants(widget.cityName);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.sizeOf(context).height;
    var width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Text(
              'Discover your dream place\nto visit or stay...',
              style: GoogleFonts.plusJakartaSans(
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.w500),
              textAlign: TextAlign.center,
            ),
            // hotels section
            SizedBox(height: height * 0.02),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  smallBlueButton('Hotels'),
                  GestureDetector(
                      onTap: () {
                        debugPrint(widget.cityName);
                        screenFunctions.nextScreen(
                            context, AllHotels(cityName: widget.cityName));
                      },
                      child: const Text('See All')),
                ],
              ),
            ),
            Expanded(
              child: FutureBuilder<List<Map<String, dynamic>>>(
                future: _hotelsFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                        child: CircularProgressIndicator(
                      color: secondaryColor,
                    ));
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else {
                    List<Map<String, dynamic>> hotels = snapshot.data ?? [];
                    return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: hotels.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                            onTap: () {
                              screenFunctions.nextScreen(
                                context,
                                HotelScreen(
                                  hotelName: hotels[index]['name'],
                                  hotelLocation: hotels[index]['location'],
                                  hotelRent: hotels[index]['rent'],
                                  hotelInfo: hotels[index]['info'],
                                  hotelPics: hotels[index]['pics'],
                                  cityName: widget.cityName,
                                ),
                              );
                              debugPrint('hello');
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ClipRRect(
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(15),
                                    topRight: Radius.circular(15),
                                  ), // Adjust the radius as needed
                                  child: SizedBox(
                                    height: height * 0.168,
                                    width: width *
                                        0.45, // Adjust the width as needed
                                    child: CachedNetworkImage(
                                        imageUrl: hotels[index]['pics'][0],
                                        placeholder: (context, url) =>
                                            const Center(
                                                child:
                                                    CircularProgressIndicator()),
                                        errorWidget: (context, url, error) =>
                                            const Icon(Icons.error),
                                        fit: BoxFit.fill),
                                  ),
                                ),
                                Text(
                                  hotels[index]['name'],
                                  style: GoogleFonts.plusJakartaSans(
                                      fontSize: 15,
                                      color: secondaryColor,
                                      fontWeight: FontWeight.w700),
                                ),
                                Text(
                                  'Rs: ${hotels[index]['rent']} / night',
                                  style: GoogleFonts.plusJakartaSans(
                                      fontSize: 10,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w700),
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ),
            //  Restaurants  section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  smallBlueButton('Restaurants'),
                  GestureDetector(
                    onTap: () {
                      screenFunctions.nextScreen(
                        context,
                        AllRestraunts(cityName: widget.cityName),
                      );
                    },
                    child: const Text('See All'),
                  ),
                ],
              ),
            ),
            Expanded(
              child: FutureBuilder<List<Map<String, dynamic>>>(
                future: _restaurantFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                        child: CircularProgressIndicator(
                      color: secondaryColor,
                    ));
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else {
                    List<Map<String, dynamic>> restaurant = snapshot.data ?? [];
                    return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: restaurant.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                            onTap: () {
                              screenFunctions.nextScreen(
                                  context,
                                  RestaurantScreen.RestaurantScreen(
                                    restaurantName: restaurant[index]['name'],
                                    restaurantInfo: restaurant[index]['info'],
                                    restaurantLocation: restaurant[index]
                                        ['location'],
                                    restaurantPics: restaurant[index]['pics'],
                                    restaurantMenu: restaurant[index]
                                        ['menupic'],
                                  ));
                              debugPrint('hello');
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ClipRRect(
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(15),
                                    topRight: Radius.circular(15),
                                  ), // Adjust the radius as needed
                                  child: SizedBox(
                                    height: height * 0.168,
                                    width: width *
                                        0.45, // Adjust the width as needed
                                    child: CachedNetworkImage(
                                        imageUrl: restaurant[index]['pics'][0],
                                        placeholder: (context, url) =>
                                            const Center(
                                                child:
                                                    CircularProgressIndicator()),
                                        errorWidget: (context, url, error) =>
                                            const Icon(Icons.error),
                                        fit: BoxFit.fill),
                                  ),
                                ),
                                Text(
                                  restaurant[index]['name'],
                                  style: GoogleFonts.plusJakartaSans(
                                      fontSize: 15,
                                      color: secondaryColor,
                                      fontWeight: FontWeight.w700),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ),
            // places to visit section

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  smallBlueButton('Places to Visit'),
                  GestureDetector(
                    onTap: () {
                      screenFunctions.nextScreen(
                        context,
                        AllLakes(cityName: widget.cityName),
                      );
                    },
                    child: const Text('See All'),
                  ),
                ],
              ),
            ),
            Expanded(
              child: FutureBuilder<List<Map<String, dynamic>>>(
                future: _placesFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                        child: CircularProgressIndicator(
                      color: secondaryColor,
                    ));
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else {
                    List<Map<String, dynamic>> places = snapshot.data ?? [];
                    return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: places.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                            onTap: () {
                              screenFunctions.nextScreen(
                                  context,
                                  LakeScreen(
                                    lakePics: places[index]['pics'],
                                    lakeInfo: places[index]['info'],
                                    lakeName: places[index]['name'],
                                    lakeLocation: places[index]['location'],
                                  ));
                              debugPrint('hello');
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ClipRRect(
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(15),
                                    topRight: Radius.circular(15),
                                  ), // Adjust the radius as needed
                                  child: SizedBox(
                                    height: height * 0.168,
                                    width: width *
                                        0.45, // Adjust the width as needed
                                    child: CachedNetworkImage(
                                        imageUrl: places[index]['pics'][0],
                                        placeholder: (context, url) =>
                                            const Center(
                                                child:
                                                    CircularProgressIndicator()),
                                        errorWidget: (context, url, error) =>
                                            const Icon(Icons.error),
                                        fit: BoxFit.fill),
                                  ),
                                ),
                                Text(
                                  places[index]['name'],
                                  style: GoogleFonts.plusJakartaSans(
                                      fontSize: 15,
                                      color: secondaryColor,
                                      fontWeight: FontWeight.w700),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget smallBlueButton(buttonTitle) {
    return Container(
      alignment: Alignment.center,
      height: 30,
      decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4.0),
        child: Text(
          buttonTitle,
          style: roboto20,
        ),
      ),
    );
  }
}
