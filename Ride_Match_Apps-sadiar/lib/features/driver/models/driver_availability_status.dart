import 'package:flutter/material.dart';

enum DriverAvailabilityStatus {
  available,
  busy,
  offline,
  scheduledCommute;

  String get label => switch (this) {
        DriverAvailabilityStatus.available => 'Available',
        DriverAvailabilityStatus.busy => 'Busy',
        DriverAvailabilityStatus.offline => 'Offline',
        DriverAvailabilityStatus.scheduledCommute => 'Scheduled Commute',
      };

  String get subtitle => switch (this) {
        DriverAvailabilityStatus.available => 'Ready for rides',
        DriverAvailabilityStatus.busy => 'Currently driving',
        DriverAvailabilityStatus.offline => 'Hidden',
        DriverAvailabilityStatus.scheduledCommute => 'Set time routine',
      };

  IconData get icon => switch (this) {
        DriverAvailabilityStatus.available => Icons.check_circle_rounded,
        DriverAvailabilityStatus.busy => Icons.block_rounded,
        DriverAvailabilityStatus.offline => Icons.visibility_off_outlined,
        DriverAvailabilityStatus.scheduledCommute => Icons.access_time_rounded,
      };
}
