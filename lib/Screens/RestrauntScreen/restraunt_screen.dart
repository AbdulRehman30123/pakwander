// ignore_for_file: must_be_immutable, non_constant_identifier_names

import 'package:pakwanderer/Packages/packages.dart';

class RestaurantScreen extends StatefulWidget {
  String restaurantName;
  String restaurantInfo;
  String restaurantLocation;
  String restaurantMenu;
  List<String> restaurantPics;
  RestaurantScreen.RestaurantScreen(
      {super.key,
      required this.restaurantName,
      required this.restaurantInfo,
      required this.restaurantLocation,
      required this.restaurantMenu,
      required this.restaurantPics});

  @override
  State<RestaurantScreen> createState() => _RestaurantScreenState();
}

class _RestaurantScreenState extends State<RestaurantScreen> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.sizeOf(context).height;
    var width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      body: Container(
        height: height,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: CachedNetworkImageProvider(widget.restaurantPics[0]),
              fit: BoxFit.cover,
              filterQuality: FilterQuality.high),
        ),
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: height * .55,
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
                    widget.restaurantName,
                    style: roboto2Italic,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.restaurantLocation,
                        style: openSans2,
                      ),
                      GestureDetector(
                        onTap: () {
                          showLakeBottomSheet(context, height / 2, width / 2,
                              widget.restaurantMenu);
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
                              'Menu',
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
                        widget.restaurantInfo,
                        style: openSans2,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: widget.restaurantPics.length,
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
                                    widget.restaurantPics[index]),
                                filterQuality: FilterQuality.high,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        );
                      }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
