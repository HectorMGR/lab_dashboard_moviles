class BarberModel {
  final String id;
  final String name;
  final String barberShop;
  final String specialty;
  final String availability;
  final double rating;
  final bool isActive;

  const BarberModel({
    required this.id,
    required this.name,
    required this.barberShop,
    required this.specialty,
    required this.availability,
    required this.rating,
    required this.isActive,
  });
}
