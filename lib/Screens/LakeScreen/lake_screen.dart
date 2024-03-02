import 'package:pakwanderer/Packages/packages.dart';

class LakeScreen extends StatefulWidget {
  String lakeName;
  String lakeInfo;
  String lakeLocation;
  List<String> lakePics;
  LakeScreen(
      {super.key,
      required this.lakeName,
      required this.lakeInfo,
      required this.lakeLocation,
      required this.lakePics});

  @override
  State<LakeScreen> createState() => _LakeScreenState();
}

class _LakeScreenState extends State<LakeScreen> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.sizeOf(context).height;
    return Scaffold(
      body: Container(
        height: height,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: CachedNetworkImageProvider(widget.lakePics[0]),
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
                    widget.lakeName,
                    style: roboto2Italic,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Text(
                    widget.lakeLocation,
                    style: openSans2,
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
                        widget.lakeInfo,
                        style: openSans2,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: widget.lakePics.length,
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
                                    widget.lakePics[index]),
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
