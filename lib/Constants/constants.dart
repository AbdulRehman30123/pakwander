// text styles

import 'package:pakwanderer/Packages/packages.dart';

// app color scheme
Color secondaryColor = const Color(0xff428ADD);
TextStyle openSans =
    GoogleFonts.plusJakartaSans(fontSize: 20, color: Colors.yellow);

TextStyle openSans2 = GoogleFonts.plusJakartaSans(
    fontSize: 10, color: const Color(0xff808080), fontWeight: FontWeight.w600);
TextStyle openSans3 = GoogleFonts.plusJakartaSans(
    fontSize: 15, color: const Color(0xff808080), fontWeight: FontWeight.w600);
TextStyle roboto40 = GoogleFonts.plusJakartaSans(
    fontSize: 40, color: Colors.white, fontWeight: FontWeight.w700);
TextStyle roboto25 = GoogleFonts.plusJakartaSans(
    fontSize: 25, color: Colors.white, fontWeight: FontWeight.w700);
TextStyle roboto20 = GoogleFonts.plusJakartaSans(
    fontSize: 15, color: Colors.white, fontWeight: FontWeight.w500);
TextStyle roboto2 = GoogleFonts.plusJakartaSans(
    fontSize: 15, color: Colors.black, fontWeight: FontWeight.w500);
TextStyle roboto2Italic = GoogleFonts.plusJakartaSans(
  fontSize: 20,
  color: Colors.black,
  fontWeight: FontWeight.w500,
);
// classes objects
ScreenFunctions screenFunctions = ScreenFunctions();
FirestoreService firestoreService = FirestoreService();
HotelData hotelData = HotelData();
// city names lists
List<String> cityNames1 = [
  'Karachi',
  'Quetta',
  'Lahore',
  'Multan',
  'Faisalabad',
  'Islamabad'
];
List<String> cityImages1 = [
  'assets/Karachi 1.jpg',
  'assets/Quetta 1..jpg',
  'assets/Lahore (1).jpg',
  'assets/Multan 1.jpeg',
  'assets/Faisalabad 3.jpg',
  'assets/Islamabad 1.jpg'
];

List<String> cityNames2 = [
  'Peshawar',
  'Haripur',
  'Abbotabad',
  'Sawat Kalam',
  'Murree',
  'Azad Kashmir',
  'Galyat',
  'Gilgit',
];
List<String> cityImages2 = [
  'assets/Peshawar 1.jpg',
  'assets/Haripur 1.jpg',
  'assets/Abbotabad.jpg',
  'assets/Swat Kalam.jpg',
  'assets/Murree.jpg',
  'assets/Abbotabad.jpg',
  'assets/Galyat.jpg',
  'assets/Gilgit.jpg'
];
List<String> sliderImages = [
  'assets/Karachi 1.jpg',
  'assets/Quetta 1..jpg',
  'assets/Lahore (1).jpg',
  'assets/Multan 1.jpeg',
  'assets/Faisalabad 3.jpg',
  'assets/Islamabad 1.jpg',
  'assets/Peshawar 1.jpg',
  'assets/Haripur 1.jpg',
  'assets/Abbotabad.jpg',
  'assets/Swat Kalam.jpg',
  'assets/Murree.jpg',
  'assets/Abbotabad.jpg',
  'assets/Galyat.jpg',
  'assets/Gilgit.jpg'
];

List<String> tileTitles = ['Favorites', 'Reservations', 'Logout'];

// text editing controllers
TextEditingController emailController = TextEditingController();
TextEditingController nameController = TextEditingController();
TextEditingController passwordController = TextEditingController();
TextEditingController numberController = TextEditingController();

// firebase auth instance
FirebaseAuth firebaseAuth = FirebaseAuth.instance;
