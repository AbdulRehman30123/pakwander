class Reservation {
  final String email;
  final String name;
  final String number;
  final DateTime timestamp;
  final String userId;
  final String hotelName;

  Reservation({
    required this.email,
    required this.name,
    required this.number,
    required this.timestamp,
    required this.userId,
    required this.hotelName,
  });
}
