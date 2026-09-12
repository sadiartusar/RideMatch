import 'package:flutter/material.dart';

class DriverPickupDropCard extends StatelessWidget {
  const DriverPickupDropCard({
    super.key,
    required this.departFrom,
    required this.destination,
    required this.departureTime,
    required this.departurePeriod,
    required this.arrivalTime,
    required this.arrivalPeriod,
    required this.onEditDepart,
    required this.onEditDestination,
    required this.onPickDepartureTime,
    required this.onPickArrivalTime,
  });

  final String departFrom;
  final String destination;
  final String departureTime;
  final String departurePeriod;
  final String arrivalTime;
  final String arrivalPeriod;
  final VoidCallback onEditDepart;
  final VoidCallback onEditDestination;
  final VoidCallback onPickDepartureTime;
  final VoidCallback onPickArrivalTime;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFF171A1D),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color(0xFF262B32),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Depart From Row
          InkWell(
            onTap: onEditDepart,
            borderRadius: BorderRadius.circular(12),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Row(
                children: [
                  Container(
                    width: 8,
                    height: 8,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'DEPART FROM',
                          style: TextStyle(
                            color: Color(0xFF9CA3AF),
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 0.8,
                          ),
                        ),
                        const SizedBox(height: 3),
                        Text(
                          departFrom,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Icon(
                    Icons.edit_outlined,
                    color: Color(0xFF9CA3AF),
                    size: 18,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.only(left: 22),
            child: Container(
              height: 1,
              color: const Color(0xFF24282F),
            ),
          ),
          const SizedBox(height: 12),
          // Destination Row
          InkWell(
            onTap: onEditDestination,
            borderRadius: BorderRadius.circular(12),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Row(
                children: [
                  Container(
                    width: 8,
                    height: 8,
                    decoration: const BoxDecoration(
                      color: Color(0xFF32E116),
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'DESTINATION',
                          style: TextStyle(
                            color: Color(0xFF9CA3AF),
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 0.8,
                          ),
                        ),
                        const SizedBox(height: 3),
                        Text(
                          destination,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Icon(
                    Icons.edit_outlined,
                    color: Color(0xFF9CA3AF),
                    size: 18,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 18),
          // Departure & Arrival Time Boxes
          Row(
            children: [
              // Departure Box
              Expanded(
                child: InkWell(
                  onTap: onPickDepartureTime,
                  borderRadius: BorderRadius.circular(14),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 12,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFF121417),
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                        color: const Color(0xFF242931),
                        width: 1,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'DEPARTURE',
                          style: TextStyle(
                            color: Color(0xFF9CA3AF),
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 0.6,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              departureTime,
                              style: const TextStyle(
                                color: Color(0xFF32E116),
                                fontSize: 18,
                                fontWeight: FontWeight.w900,
                                height: 1.0,
                              ),
                            ),
                            const SizedBox(width: 4),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 1),
                              child: Text(
                                departurePeriod,
                                style: const TextStyle(
                                  color: Color(0xFF9CA3AF),
                                  fontSize: 11,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              // Arrival Box
              Expanded(
                child: InkWell(
                  onTap: onPickArrivalTime,
                  borderRadius: BorderRadius.circular(14),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 12,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFF121417),
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                        color: const Color(0xFF242931),
                        width: 1,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'ARRIVAL',
                          style: TextStyle(
                            color: Color(0xFF9CA3AF),
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 0.6,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              arrivalTime,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w900,
                                height: 1.0,
                              ),
                            ),
                            const SizedBox(width: 4),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 1),
                              child: Text(
                                arrivalPeriod,
                                style: const TextStyle(
                                  color: Color(0xFF9CA3AF),
                                  fontSize: 11,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
