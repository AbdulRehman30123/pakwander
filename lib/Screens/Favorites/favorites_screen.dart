import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:pakwanderer/Packages/packages.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  late Future<List<Map<String, dynamic>>> _hotelDataFuture;

  void initState() {
    super.initState();
    _hotelDataFuture = hotelData.getHotelDataSF();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: const Text('Favorite Hotels'),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _hotelDataFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
            List<Map<String, dynamic>> hotelData = snapshot.data ?? [];
            return GridView.builder(
              itemCount: hotelData.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10.0,
                mainAxisSpacing: 10.0,
                childAspectRatio: 0.8,
              ),
              itemBuilder: (context, index) {
                Map<String, dynamic> hotel = hotelData[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        children: [
                          ClipRRect(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(15),
                              topRight: Radius.circular(15),
                            ),
                            child: SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.168,
                              width: MediaQuery.of(context).size.width *
                                  0.45, // Adjust the width as needed
                              child: CachedNetworkImage(
                                imageUrl: hotel['hotelPics'][0],
                                placeholder: (context, url) => const Center(
                                  child: CircularProgressIndicator(),
                                ),
                                errorWidget: (context, url, error) =>
                                    const Icon(Icons.error),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              child: GestureDetector(
                                onTap: () {
                                  removeHotelFromFavorites(hotel);
                                },
                                child: Container(
                                  color: secondaryColor,
                                  child: const Padding(
                                    padding: EdgeInsets.all(5.0),
                                    child: Icon(
                                      Icons.favorite_border_outlined,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ))
                        ],
                      ),
                      Text(
                        hotel['hotelName'],
                        style: GoogleFonts.roboto(
                          fontSize: 15,
                          color: Colors.black,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        'Rs: ${hotel['hotelRent']} / night',
                        style: GoogleFonts.roboto(
                          fontSize: 10,
                          color: Colors.black,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }

  Future<void> removeHotelFromFavorites(Map<String, dynamic> hotel) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      List<String> hotelList = prefs.getStringList('hotel_list') ?? [];

      hotelList.removeWhere((encodedHotelData) {
        Map<String, dynamic> decodedHotelData = json.decode(encodedHotelData);
        return decodedHotelData['hotelName'] == hotel['hotelName'] &&
            decodedHotelData['cityName'] == hotel['cityName'];
      });

      await prefs.setStringList('hotel_list', hotelList);

      // Reload data to reflect changes
      setState(() {
        _hotelDataFuture = hotelData.getHotelDataSF();
      });

      showMessage(context, Colors.green, 'Hotel removed from favorites');
    } catch (e) {
      print(e);
    }
  }
}
