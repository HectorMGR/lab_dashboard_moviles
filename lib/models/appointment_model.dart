enum AppointmentStatus {
  pending,
  confirmed,
  completed,
  cancelled;

  String get label {
    switch (this) {
      case AppointmentStatus.pending:
        return 'Pending';
      case AppointmentStatus.confirmed:
        return 'Confirmed';
      case AppointmentStatus.completed:
        return 'Completed';
      case AppointmentStatus.cancelled:
        return 'Cancelled';
    }
  }
}

class AppointmentModel {
  final String id;
  final String clientName;
  final String barberName;
  final String barberShop;
  final String service;
  final DateTime dateTime;
  final AppointmentStatus status;
  final double price;

  const AppointmentModel({
    required this.id,
    required this.clientName,
    required this.barberName,
    required this.barberShop,
    required this.service,
    required this.dateTime,
    required this.status,
    required this.price,
  });
}
