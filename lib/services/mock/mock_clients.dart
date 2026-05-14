import '../../models/client_model.dart';

class MockClients {
  MockClients._();

  static final List<ClientModel> _clients = [
    ClientModel(id: 'CLI001', name: 'Carlos Mendoza', email: 'carlos@email.com', phone: '+1 555-0101', totalAppointments: 12, lastAppointment: DateTime(2026, 5, 10), isActive: true),
    ClientModel(id: 'CLI002', name: 'Ana García', email: 'ana@email.com', phone: '+1 555-0102', totalAppointments: 8, lastAppointment: DateTime(2026, 5, 12), isActive: true),
    ClientModel(id: 'CLI003', name: 'Luis Hernández', email: 'luis@email.com', phone: '+1 555-0103', totalAppointments: 15, lastAppointment: DateTime(2026, 5, 13), isActive: true),
    ClientModel(id: 'CLI004', name: 'María Rodríguez', email: 'maria@email.com', phone: '+1 555-0104', totalAppointments: 6, lastAppointment: DateTime(2026, 5, 11), isActive: true),
    ClientModel(id: 'CLI005', name: 'José Martínez', email: 'jose@email.com', phone: '+1 555-0105', totalAppointments: 3, lastAppointment: DateTime(2026, 4, 28), isActive: false),
    ClientModel(id: 'CLI006', name: 'Diana López', email: 'diana@email.com', phone: '+1 555-0106', totalAppointments: 10, lastAppointment: DateTime(2026, 5, 13), isActive: true),
    ClientModel(id: 'CLI007', name: 'Roberto Díaz', email: 'roberto@email.com', phone: '+1 555-0107', totalAppointments: 7, lastAppointment: DateTime(2026, 5, 12), isActive: true),
    ClientModel(id: 'CLI008', name: 'Sofía Morales', email: 'sofia@email.com', phone: '+1 555-0108', totalAppointments: 5, lastAppointment: DateTime(2026, 5, 13), isActive: true),
    ClientModel(id: 'CLI009', name: 'Fernando Ruiz', email: 'fernando@email.com', phone: '+1 555-0109', totalAppointments: 2, lastAppointment: DateTime(2026, 3, 15), isActive: false),
    ClientModel(id: 'CLI010', name: 'Gabriela Torres', email: 'gabriela@email.com', phone: '+1 555-0110', totalAppointments: 9, lastAppointment: DateTime(2026, 5, 11), isActive: true),
    ClientModel(id: 'CLI011', name: 'Javier Campos', email: 'javier@email.com', phone: '+1 555-0111', totalAppointments: 4, lastAppointment: DateTime(2026, 5, 10), isActive: true),
    ClientModel(id: 'CLI012', name: 'Valentina Castro', email: 'valentina@email.com', phone: '+1 555-0112', totalAppointments: 11, lastAppointment: DateTime(2026, 5, 12), isActive: true),
  ];

  static List<ClientModel> getAll() => List.unmodifiable(_clients);

  static int get activeCount => _clients.where((c) => c.isActive).length;
  static int get totalCount => _clients.length;
}
