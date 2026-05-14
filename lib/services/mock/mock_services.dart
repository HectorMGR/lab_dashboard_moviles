import '../../models/service_model.dart';

class MockServices {
  MockServices._();

  static final List<ServiceModel> _services = [
    const ServiceModel(id: 'SRV001', name: 'Classic Haircut', description: 'Traditional scissor and clipper cut with styling', price: 25.0, durationMinutes: 30, barberShop: 'Barberly Central', isActive: true),
    const ServiceModel(id: 'SRV002', name: 'Fade + Beard', description: 'Skin fade haircut with beard trim and lineup', price: 40.0, durationMinutes: 45, barberShop: 'Barberly Central', isActive: true),
    const ServiceModel(id: 'SRV003', name: 'Beard Trim', description: 'Precision beard trim with hot towel finish', price: 15.0, durationMinutes: 20, barberShop: 'Barberly North', isActive: true),
    const ServiceModel(id: 'SRV004', name: 'Hair Color', description: 'Professional hair coloring and treatment', price: 60.0, durationMinutes: 60, barberShop: 'Barberly South', isActive: true),
    const ServiceModel(id: 'SRV005', name: 'Kids Haircut', description: 'Gentle cut for children under 12', price: 18.0, durationMinutes: 25, barberShop: 'Barberly East', isActive: true),
    const ServiceModel(id: 'SRV006', name: 'Shave', description: 'Classic straight razor hot shave', price: 20.0, durationMinutes: 30, barberShop: 'Barberly North', isActive: true),
    const ServiceModel(id: 'SRV007', name: 'Buzz Cut', description: 'Uniform clipper cut all around', price: 15.0, durationMinutes: 15, barberShop: 'Barberly Central', isActive: true),
    const ServiceModel(id: 'SRV008', name: 'Hair Treatment', description: 'Deep conditioning hair treatment', price: 35.0, durationMinutes: 40, barberShop: 'Barberly South', isActive: true),
    const ServiceModel(id: 'SRV009', name: 'Hot Towel Shave', description: 'Luxury hot towel and straight razor shave', price: 30.0, durationMinutes: 35, barberShop: 'Barberly East', isActive: true),
    const ServiceModel(id: 'SRV010', name: 'Design & Patterns', description: 'Creative hair designs and patterns', price: 45.0, durationMinutes: 50, barberShop: 'Barberly Central', isActive: false),
  ];

  static List<ServiceModel> getAll() => List.unmodifiable(_services);

  static int get activeCount => _services.where((s) => s.isActive).length;
  static int get totalCount => _services.length;
}
