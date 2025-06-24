class Rating {
  final String id;
  final String userId;
  final String driverId;
  final String comment;
  final String ratingLevel; // e.g., "good", "bad", "better"
  final double? tip; // optional

  Rating({
    required this.id,
    required this.userId,
    required this.driverId,
    required this.comment,
    required this.ratingLevel,
    this.tip,
  });
}
