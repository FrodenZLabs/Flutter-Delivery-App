class Service {
  final String id;
  final String name; // e.g. Dry Cleaning
  final String subName; // e.g. Expert Dry Cleaning Services
  final String description;
  final String imageUrl;
  final double baseFee; // Base service charge
  final double perKmFee; // Delivery/travel fee per kilometer
  final bool available; // Is the service currently available?
  final String openDays; // e.g. ['Monday', 'Tuesday', ...]
  final String closeDay; // e.g. 'Friday'
  final String openTime; // e.g. '8:00 AM'
  final String closeTime; // e.g. '5:00 PM'

  const Service({
    required this.id,
    required this.name,
    required this.subName,
    required this.description,
    required this.imageUrl,
    required this.baseFee,
    required this.perKmFee,
    required this.available,
    required this.openDays,
    required this.closeDay,
    required this.openTime,
    required this.closeTime,
  });
}
