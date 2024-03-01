/// Custom exception class to handle various Firbase-related errors.
class SFirebaseException implements Exception {
  /// The error code associated with the exception,
  final String code;

  /// Constructor that takes an error code.
  SFirebaseException(this.code);

  /// Get the corresponding error message based on the error code.
  String get message {
    switch (code) {
      case 'permission-denied':
      return 'Permission denied. You do not have permission to access this resource.';
    case 'aborted':
      return 'The operation was aborted, typically due to a concurrency issue.';
    case 'unavailable':
      return 'The service is currently unavailable. Please try again later.';
    case 'cancelled':
      return 'The operation was cancelled.';
    case 'deadline-exceeded':
      return 'The deadline for the operation has been exceeded.';
    case 'internal':
      return 'An internal error occurred. Please try again later.';
    case 'unknown':
      return 'An unknown error occurred.';
    case 'email-already-in-use':
      return 'The email address is already registered. Please use a different email.';
    case 'invalid-email':
      return 'The email address provided is invalid. Please enter a valid email.';
    case 'weak-password':
      return 'The password is too weak. Please choose a stronger password.';
    case 'user-disabled':
      return 'This user account has been disabled. Please contact support for assistance.';
    case 'user-not-found':
      return 'Invalid login details. User not found.';
    case 'wrong-password':
      return 'Incorrect password. Please check your password and try again.';
    default:
      return 'Firebase Exceptions $code Please try again';
    }
  }
}