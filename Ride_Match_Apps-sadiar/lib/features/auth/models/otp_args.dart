/// Arguments passed into the OTP screen.
class OtpArgs {
  const OtpArgs({
    required this.destination,
    required this.isNewUser,
  });

  /// Email or phone the code was sent to.
  final String destination;

  /// New users go to Verification Hub; existing users go to home.
  final bool isNewUser;

  static OtpArgs? tryParse(Object? raw) {
    if (raw is OtpArgs) return raw;
    if (raw is String && raw.isNotEmpty) {
      return OtpArgs(destination: raw, isNewUser: true);
    }
    if (raw is Map) {
      final destination = raw['destination']?.toString() ?? '';
      if (destination.isEmpty) return null;
      final isNew = raw['isNewUser'] == true;
      return OtpArgs(destination: destination, isNewUser: isNew);
    }
    return null;
  }
}
