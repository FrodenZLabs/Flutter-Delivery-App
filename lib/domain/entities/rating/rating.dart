class Rating {
  final String id;
  final String userId;
  final String scheduleId;
  final String driverId;
  final String serviceId;
  final String comment;
  final int rating;
  final DateTime createdAt;

  Rating({
    required this.id,
    required this.userId,
    required this.driverId,
    required this.comment,
    required this.scheduleId,
    required this.serviceId,
    required this.rating,
    required this.createdAt,
  });
}
