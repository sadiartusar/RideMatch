/// Placeholder for future realtime connectivity (WebSocket / Socket.IO).
///
/// Intended flow when implemented:
/// RealtimeService → Feature Service → Controller → UI
///
/// UI widgets must never manage sockets directly.
abstract class RealtimeService {
  Future<void> connect();

  Future<void> disconnect();

  bool get isConnected;
}
