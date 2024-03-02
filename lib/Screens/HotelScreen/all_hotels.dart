import 'package:flutter/material.dart';
import 'package:pakwanderer/Packages/packages.dart';

class AllHotels extends StatefulWidget {
  String cityName;
  AllHotels({super.key, required this.cityName});

  @override
  State<AllHotels> createState() => _AllHotelsState();
}

class _AllHotelsState extends State<AllHotels> {
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                onChanged: (value) {
                  searchController.text = value;
                  setState(() {});
                },
                controller: searchController,
                decoration: InputDecoration(
                  hintText: 'Search hotels by name or rent',
                  hintStyle: const TextStyle(color: Colors.grey, fontSize: 15),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(color: secondaryColor),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(color: secondaryColor),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(color: secondaryColor),
                  ),
                  suffixIcon: Icon(
                    Icons.search,
                    color: secondaryColor,
                  ),
                ),
              ),
            ),
            StreamBuilder<List<Map<String, dynamic>>>(
              stream: firestoreService.streamHotels(
                  widget.cityName), // Provide your collection name
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                      child: CircularProgressIndicator(
                    color: secondaryColor,
                  ));
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('No hotels found.'));
                } else {
                  // Here you can build your UI using the snapshot data
                  List<Map<String, dynamic>> filteredHotels =
                      searchController.text.isEmpty
                          ? snapshot.data!
                          : snapshot.data!
                              .where(
                                (hotel) => hotel['name'].toLowerCase().contains(
                                      searchController.text.toLowerCase(),
                                    ),
                              )
                              .toList();

                  return Expanded(
                    child: GridView.builder(
                      itemCount: filteredHotels.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10.0,
                        mainAxisSpacing: 10.0,
                        childAspectRatio: 0.8,
                      ),
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                            onTap: () {
                              // Navigate to HotelScreen
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => HotelScreen(
                                    hotelName: filteredHotels[index]['name'],
                                    hotelLocation: filteredHotels[index]
                                        ['location'],
                                    hotelRent: filteredHotels[index]['rent'],
                                    hotelInfo: filteredHotels[index]['info'],
                                    hotelPics: filteredHotels[index]['pics'],
                                    cityName: widget.cityName,
                                  ),
                                ),
                              );
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ClipRRect(
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(15),
                                    topRight: Radius.circular(15),
                                  ),
                                  child: SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.168,
                                    width: MediaQuery.of(context).size.width *
                                        0.45, // Adjust the width as needed
                                    child: CachedNetworkImage(
                                      imageUrl: filteredHotels[index]['pics']
                                          [0],
                                      placeholder: (context, url) =>
                                          const Center(
                                        child: CircularProgressIndicator(),
                                      ),
                                      errorWidget: (context, url, error) =>
                                          const Icon(Icons.error),
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                                Text(
                                  filteredHotels[index]['name'],
                                  style: GoogleFonts.roboto(
                                    fontSize: 15,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                Text(
                                  'Rs: ${filteredHotels[index]['rent']} / night',
                                  style: GoogleFonts.roboto(
                                    fontSize: 10,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w700,
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
