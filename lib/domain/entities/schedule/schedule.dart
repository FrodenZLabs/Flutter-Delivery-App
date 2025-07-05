class Schedule {
  final String id;
  final String userId;
  final String serviceId;
  final String deliveryInfoId;
  final DateTime scheduleDate;
  final String scheduleTime; // e.g. '10:00 AM - 12:00 PM'
  final String status;

  Schedule({
    required this.id,
    required this.userId,
    required this.serviceId,
    required this.deliveryInfoId,
    required this.scheduleDate,
    required this.scheduleTime,
    required this.status,
  });
}
