import 'dart:io';

import 'package:pakwanderer/Packages/packages.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.sizeOf(context).height;
    var width = MediaQuery.sizeOf(context).width;
    return WillPopScope(
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            toolbarHeight: 40,
            centerTitle: true,
            automaticallyImplyLeading: false,
            elevation: 0,
            title: Text(
              'Pak Wanderer',
              style: roboto2,
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: IconButton(
                  onPressed: () async {
                    showProfileOptions(context);
                  },
                  icon: const Icon(Icons.person),
                ),
              )
            ],
          ),
          body: SafeArea(
            child: Column(
              children: [
                SizedBox(height: height * 0.03),
                Text(
                  'Lets Explore The beauty of Pakistan with us.',
                  style: GoogleFonts.plusJakartaSans(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.w500),
                  textAlign: TextAlign.center,
                ),
                CarouselSlider(
                  options: CarouselOptions(
                    autoPlay: true, // Set to true for automatic sliding
                    aspectRatio:
                        10 / 5, // Adjust aspect ratio as per your requirement
                    enlargeCenterPage: true,
                    viewportFraction: 0.8,
                    autoPlayCurve: Curves.fastOutSlowIn,
                  ),
                  items: [
                    // List of Widgets (usually images)
                    for (int i = 0; i < sliderImages.length; i++)
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.asset(
                          sliderImages[i],
                          fit: BoxFit.fill,
                        ),
                      ),

                    // Add more items as needed
                  ],
                ),

                // First ListView.builder
                SizedBox(
                  height: height * 0.28,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    itemCount: cityNames1.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: () {
                            screenFunctions.nextScreen(
                                context,
                                CityScreen(
                                  cityName: cityNames1[index].toLowerCase(),
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
                                  height: height * 0.2,
                                  width: width *
                                      0.45, // Adjust the width as needed
                                  child: Image.asset(
                                    cityImages1[index],
                                    fit: BoxFit
                                        .cover, // Use BoxFit.cover to maintain aspect ratio
                                    filterQuality: FilterQuality.high,
                                  ),
                                ),
                              ),
                              Text(
                                cityNames1[index],
                                style: GoogleFonts.plusJakartaSans(
                                    fontSize: 15,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                // Second ListView.builder
                SizedBox(
                  height: height * 0.28,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    itemCount: cityNames2.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: () {
                            screenFunctions.nextScreen(
                                context,
                                CityScreen(
                                  cityName: cityNames2[index].toLowerCase(),
                                ));
                            debugPrint(cityNames2[index]);
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
                                  height: height * 0.2,
                                  width: width *
                                      0.45, // Adjust the width as needed
                                  child: Image.asset(
                                    cityImages2[index],
                                    fit: BoxFit
                                        .cover, // Use BoxFit.cover to maintain aspect ratio
                                    filterQuality: FilterQuality.high,
                                  ),
                                ),
                              ),
                              Text(
                                cityNames2[index],
                                style: GoogleFonts.plusJakartaSans(
                                    fontSize: 15,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
        onWillPop: () async {
          showExitPopup(context, () {
            screenFunctions.popScreen(context);
          }, () {
            exit(0);
          });
          return false;
        });
  }
}
