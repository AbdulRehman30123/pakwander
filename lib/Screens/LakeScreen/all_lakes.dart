import 'package:pakwanderer/Packages/packages.dart';

class AllLakes extends StatefulWidget {
  String cityName;
  AllLakes({super.key, required this.cityName});

  @override
  State<AllLakes> createState() => _AllLakesState();
}

class _AllLakesState extends State<AllLakes> {
  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.sizeOf(context).height;
    var width = MediaQuery.sizeOf(context).width;
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
                  hintText: 'Search places by name',
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
              stream: firestoreService.getPlacesStream(
                  widget.cityName), // Provide your collection name
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('No Places to Visit Found.'));
                } else {
                  // Here you can build your UI using the snapshot data
                  List<Map<String, dynamic>> filteredPlaces =
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
                      itemCount: filteredPlaces.length,
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
                              screenFunctions.nextScreen(
                                  context,
                                  LakeScreen(
                                    lakePics: filteredPlaces[index]['pics'],
                                    lakeInfo: filteredPlaces[index]['info'],
                                    lakeName: filteredPlaces[index]['name'],
                                    lakeLocation: filteredPlaces[index]
                                        ['location'],
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
                                        imageUrl: filteredPlaces[index]['pics']
                                            [0],
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
                                  filteredPlaces[index]['name'],
                                  style: GoogleFonts.roboto(
                                      fontSize: 15,
                                      color: secondaryColor,
                                      fontWeight: FontWeight.w700),
                                ),
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
