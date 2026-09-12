/// Foundation trip lifecycle states. Full state machine comes later.
enum TripStatus {
  idle,
  searching,
  requested,
  driverAssigned,
  driverArriving,
  driverArrived,
  started,
  completed,
  cancelled,
}

extension TripStatusX on TripStatus {
  bool get isActive =>
      this != TripStatus.idle &&
      this != TripStatus.completed &&
      this != TripStatus.cancelled;

  String get displayName {
    switch (this) {
      case TripStatus.idle:
        return 'Idle';
      case TripStatus.searching:
        return 'Searching';
      case TripStatus.requested:
        return 'Requested';
      case TripStatus.driverAssigned:
        return 'Driver assigned';
      case TripStatus.driverArriving:
        return 'Driver arriving';
      case TripStatus.driverArrived:
        return 'Driver arrived';
      case TripStatus.started:
        return 'In progress';
      case TripStatus.completed:
        return 'Completed';
      case TripStatus.cancelled:
        return 'Cancelled';
    }
  }
}
