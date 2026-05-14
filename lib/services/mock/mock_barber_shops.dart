import '../../models/barber_shop_model.dart';

class MockBarberShops {
  MockBarberShops._();

  static final List<BarberShopModel> _shops = [
    const BarberShopModel(id: 'SHP001', name: 'Barberly Central', owner: 'Marco Estrada', location: 'Av. Principal 123, Downtown', phone: '+1 555-1001', barberCount: 4, appointmentCount: 245, isActive: true),
    const BarberShopModel(id: 'SHP002', name: 'Barberly North', owner: 'Lucía Fernández', location: 'Calle Norte 456, Uptown', phone: '+1 555-1002', barberCount: 3, appointmentCount: 188, isActive: true),
    const BarberShopModel(id: 'SHP003', name: 'Barberly South', owner: 'Raúl Morales', location: 'Blvd Sur 789, Midtown', phone: '+1 555-1003', barberCount: 2, appointmentCount: 142, isActive: true),
    const BarberShopModel(id: 'SHP004', name: 'Barberly East', owner: 'Elena Castillo', location: 'Calle Este 321, Eastside', phone: '+1 555-1004', barberCount: 2, appointmentCount: 156, isActive: true),
    const BarberShopModel(id: 'SHP005', name: 'Barberly West', owner: 'Tomás Vega', location: 'Av. Oeste 654, Westend', phone: '+1 555-1005', barberCount: 1, appointmentCount: 87, isActive: false),
  ];

  static List<BarberShopModel> getAll() => List.unmodifiable(_shops);

  static int get activeCount => _shops.where((s) => s.isActive).length;
  static int get totalCount => _shops.length;
}
