import '../../models/barber_model.dart';

class MockBarbers {
  MockBarbers._();

  static final List<BarberModel> _barbers = [
    const BarberModel(id: 'BAR001', name: 'Miguel Torres', barberShop: 'Barberly Central', specialty: 'Fades & Classic Cuts', availability: 'Mon-Fri 9AM-6PM', rating: 4.8, isActive: true),
    const BarberModel(id: 'BAR002', name: 'Pedro Ramírez', barberShop: 'Barberly North', specialty: 'Beard Grooming', availability: 'Mon-Sat 10AM-7PM', rating: 4.5, isActive: true),
    const BarberModel(id: 'BAR003', name: 'Juan López', barberShop: 'Barberly Central', specialty: 'Hair Color & Styling', availability: 'Tue-Sat 9AM-5PM', rating: 4.7, isActive: true),
    const BarberModel(id: 'BAR004', name: 'Diego Sánchez', barberShop: 'Barberly South', specialty: 'Classic Barbering', availability: 'Mon-Fri 8AM-4PM', rating: 4.3, isActive: true),
    const BarberModel(id: 'BAR005', name: 'Andrés Vargas', barberShop: 'Barberly East', specialty: 'Modern Styles', availability: 'Mon-Sat 11AM-8PM', rating: 4.6, isActive: true),
    const BarberModel(id: 'BAR006', name: 'Alejandro Cruz', barberShop: 'Barberly North', specialty: 'Kids & Family Cuts', availability: 'Wed-Sun 10AM-6PM', rating: 4.4, isActive: true),
    const BarberModel(id: 'BAR007', name: 'Ricardo Mora', barberShop: 'Barberly South', specialty: 'Fades & Designs', availability: 'Mon-Fri 9AM-5PM', rating: 4.9, isActive: true),
    const BarberModel(id: 'BAR008', name: 'Sebastián Ríos', barberShop: 'Barberly East', specialty: 'Beard & Hot Towel', availability: 'Tue-Sat 9AM-6PM', rating: 4.2, isActive: false),
    const BarberModel(id: 'BAR009', name: 'Mateo Guzmán', barberShop: 'Barberly Central', specialty: 'Haircuts & Shaves', availability: 'Mon-Fri 8AM-4PM', rating: 4.6, isActive: true),
    const BarberModel(id: 'BAR010', name: 'Emilio Paredes', barberShop: 'Barberly North', specialty: 'Color & Highlights', availability: 'Wed-Sun 10AM-7PM', rating: 4.0, isActive: false),
  ];

  static List<BarberModel> getAll() => List.unmodifiable(_barbers);

  static int get activeCount => _barbers.where((b) => b.isActive).length;
  static int get totalCount => _barbers.length;
}
