class ClientModel {
  final String id;
  final String name;
  final String email;
  final String phone;
  final int totalAppointments;
  final DateTime lastAppointment;
  final bool isActive;

  const ClientModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.totalAppointments,
    required this.lastAppointment,
    required this.isActive,
  });
}
