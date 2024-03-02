import 'dart:convert';

import 'package:pakwanderer/Packages/packages.dart';

class HotelData {
  static const String _kHotelListKey = 'hotel_list';

Future<void> saveHotelData(
    {required String hotelName,
    required String hotelLocation,
    required String hotelRent,
    required String hotelInfo,
    required List<dynamic> hotelPics,
    required BuildContext context,
    required String cityName}) async {
  try {
    final prefs = await SharedPreferences.getInstance();
    List<String> hotelList = prefs.getStringList(_kHotelListKey) ?? [];

    // Check if the hotel data already exists
    bool alreadyExists = false;
    for (String encodedHotelData in hotelList) {
      Map<String, dynamic> decodedHotelData = json.decode(encodedHotelData);
      if (decodedHotelData['hotelName'] == hotelName &&
          decodedHotelData['cityName'] == cityName) {
        alreadyExists = true;
        break;
      }
    }

    if (alreadyExists) {
      showMessage(context, Colors.red, 'Hotel already saved');
    } else {
      final newHotelData = {
        'hotelName': hotelName,
        'hotelLocation': hotelLocation,
        'hotelRent': hotelRent,
        'hotelInfo': hotelInfo,
        'hotelPics': hotelPics,
        'cityName': cityName,
      };
      hotelList.add(json.encode(newHotelData)); // Store data as JSON string
      await prefs.setStringList(_kHotelListKey, hotelList);
      
      showMessage(context, Colors.green, 'Saved in Favorites');
      debugPrint(hotelList.toString());
    }
  } catch (e) {
    print(e);
  }
}


  Future<List<Map<String, dynamic>>> getHotelData() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> hotelList = prefs.getStringList(_kHotelListKey) ?? [];
    return hotelList.map((hotelDataString) {
      Map<String, dynamic> hotelData = {};
      var items = hotelDataString.split(', '); // Split by ', ' first
      for (var item in items) {
        var keyValue = item.split(': '); // Then split each item by ': '
        if (keyValue.length == 2) {
          // Ensure we have a key and a value
          hotelData[keyValue[0]] = keyValue[1];
        }
      }
      return hotelData;
    }).toList();
  }

  Future<List<Map<String, dynamic>>> getHotelDataSF() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      List<String>? hotelList = prefs.getStringList(_kHotelListKey);
      List<Map<String, dynamic>> parsedHotelList = [];

      if (hotelList != null) {
        for (String hotelData in hotelList) {
          Map<String, dynamic> parsedHotelData = json.decode(hotelData);
          parsedHotelList.add(parsedHotelData);
        }
      }
      return parsedHotelList;
    } catch (e) {
      print(e);
      return [];
    }
  }
}
