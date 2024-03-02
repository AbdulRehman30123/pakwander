import 'package:pakwanderer/Packages/packages.dart';

void showLakeBottomSheet(
    BuildContext context, double height, double width, String imageLink) {
  showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      return SizedBox(
          width: double.infinity,
          height: height,
          child: CachedNetworkImage(imageUrl: imageLink));
    },
  );
}
