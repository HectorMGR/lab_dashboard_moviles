import '../../models/appointment_model.dart';

class MockAppointments {
  MockAppointments._();

  static final List<AppointmentModel> _appointments = [
    AppointmentModel(
      id: 'APT001', clientName: 'Carlos Mendoza', barberName: 'Miguel Torres',
      barberShop: 'Barberly Central', service: 'Classic Haircut', dateTime: _dt(9, 0),
      status: AppointmentStatus.confirmed, price: 25.0,
    ),
    AppointmentModel(
      id: 'APT002', clientName: 'Ana García', barberName: 'Pedro Ramírez',
      barberShop: 'Barberly North', service: 'Beard Trim', dateTime: _dt(9, 30),
      status: AppointmentStatus.pending, price: 15.0,
    ),
    AppointmentModel(
      id: 'APT003', clientName: 'Luis Hernández', barberName: 'Juan López',
      barberShop: 'Barberly Central', service: 'Fade + Beard', dateTime: _dt(10, 0),
      status: AppointmentStatus.completed, price: 40.0,
    ),
    AppointmentModel(
      id: 'APT004', clientName: 'María Rodríguez', barberName: 'Diego Sánchez',
      barberShop: 'Barberly South', service: 'Hair Color', dateTime: _dt(10, 30),
      status: AppointmentStatus.confirmed, price: 60.0,
    ),
    AppointmentModel(
      id: 'APT005', clientName: 'José Martínez', barberName: 'Miguel Torres',
      barberShop: 'Barberly Central', service: 'Kids Haircut', dateTime: _dt(11, 0),
      status: AppointmentStatus.cancelled, price: 18.0,
    ),
    AppointmentModel(
      id: 'APT006', clientName: 'Diana López', barberName: 'Andrés Vargas',
      barberShop: 'Barberly East', service: 'Classic Haircut', dateTime: _dt(11, 30),
      status: AppointmentStatus.pending, price: 25.0,
    ),
    AppointmentModel(
      id: 'APT007', clientName: 'Roberto Díaz', barberName: 'Pedro Ramírez',
      barberShop: 'Barberly North', service: 'Shave', dateTime: _dt(12, 0),
      status: AppointmentStatus.completed, price: 20.0,
    ),
    AppointmentModel(
      id: 'APT008', clientName: 'Sofía Morales', barberName: 'Juan López',
      barberShop: 'Barberly Central', service: 'Fade + Beard', dateTime: _dt(12, 30),
      status: AppointmentStatus.confirmed, price: 40.0,
    ),
    AppointmentModel(
      id: 'APT009', clientName: 'Fernando Ruiz', barberName: 'Diego Sánchez',
      barberShop: 'Barberly South', service: 'Beard Trim', dateTime: _dt(14, 0),
      status: AppointmentStatus.pending, price: 15.0,
    ),
    AppointmentModel(
      id: 'APT010', clientName: 'Gabriela Torres', barberName: 'Miguel Torres',
      barberShop: 'Barberly Central', service: 'Classic Haircut', dateTime: _dt(14, 30),
      status: AppointmentStatus.completed, price: 25.0,
    ),
    AppointmentModel(
      id: 'APT011', clientName: 'Javier Campos', barberName: 'Andrés Vargas',
      barberShop: 'Barberly East', service: 'Hair Color', dateTime: _dt(15, 0),
      status: AppointmentStatus.confirmed, price: 60.0,
    ),
    AppointmentModel(
      id: 'APT012', clientName: 'Valentina Castro', barberName: 'Pedro Ramírez',
      barberShop: 'Barberly North', service: 'Kids Haircut', dateTime: _dt(15, 30),
      status: AppointmentStatus.cancelled, price: 18.0,
    ),
    AppointmentModel(
      id: 'APT013', clientName: 'Ricardo Peña', barberName: 'Juan López',
      barberShop: 'Barberly Central', service: 'Shave', dateTime: _dt(16, 0),
      status: AppointmentStatus.pending, price: 20.0,
    ),
    AppointmentModel(
      id: 'APT014', clientName: 'Natalia Vargas', barberName: 'Diego Sánchez',
      barberShop: 'Barberly South', service: 'Fade + Beard', dateTime: _dt(16, 30),
      status: AppointmentStatus.completed, price: 40.0,
    ),
    AppointmentModel(
      id: 'APT015', clientName: 'Hugo Mendoza', barberName: 'Miguel Torres',
      barberShop: 'Barberly Central', service: 'Beard Trim', dateTime: _dt(17, 0),
      status: AppointmentStatus.confirmed, price: 15.0,
    ),
    AppointmentModel(
      id: 'APT016', clientName: 'Andrea Salazar', barberName: 'Andrés Vargas',
      barberShop: 'Barberly East', service: 'Classic Haircut', dateTime: _dt(17, 30),
      status: AppointmentStatus.completed, price: 25.0,
    ),
    AppointmentModel(
      id: 'APT017', clientName: 'Daniel Ortiz', barberName: 'Pedro Ramírez',
      barberShop: 'Barberly North', service: 'Fade + Beard', dateTime: _dt(18, 0),
      status: AppointmentStatus.pending, price: 40.0,
    ),
    AppointmentModel(
      id: 'APT018', clientName: 'Camila Rojas', barberName: 'Juan López',
      barberShop: 'Barberly Central', service: 'Hair Color', dateTime: _dt(18, 30),
      status: AppointmentStatus.confirmed, price: 60.0,
    ),
  ];

  static List<AppointmentModel> getAll() => List.unmodifiable(_appointments);

  static List<AppointmentModel> getToday() {
    final now = DateTime.now();
    return _appointments.where((a) =>
    a.dateTime.year == now.year && a.dateTime.month == now.month && a.dateTime.day == now.day
    ).toList();
  }

  static DateTime _dt(int hour, int minute) {
    final now = DateTime.now();
    return DateTime(now.year, now.month, now.day, hour, minute);
  }
}
