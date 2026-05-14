class BarberShopModel {
  final String id;
  final String name;
  final String owner;
  final String location;
  final String phone;
  final int barberCount;
  final int appointmentCount;
  final bool isActive;

  const BarberShopModel({
    required this.id,
    required this.name,
    required this.owner,
    required this.location,
    required this.phone,
    required this.barberCount,
    required this.appointmentCount,
    required this.isActive,
  });
}
