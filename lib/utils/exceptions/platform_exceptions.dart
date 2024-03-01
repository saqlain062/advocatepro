

/// Custom exception class to handle various platform-related errors.
class SPlatformException implements Exception {
  /// The error code associated with the exception,
  final String code;

  /// Constructor that takes an error code.
  SPlatformException(this.code );

  /// Get the corresponding error message based on the error code.
  String get message {
    switch (code) {
      case 'INVALID-LOGIN-CREDENTIALS':
        return 'Invalid login credentials. Please double-check your information.';
      case 'too-many-requests':
        return 'Too many requests. Please try again later.';
      case 'invalid-argument':
        return 'Invalid argument provided to the authentication method.';
      case 'invalid-password':
      return 'Incorrect password. Please try again.';
      case 'invalid-phone-number':
      return 'The provided phone number is invalid.';
      case 'operaton-not-allowed':
      return 'The sign-in provider is disabled for your Firebase project.';
      case 'session-cookie-expired':
      return 'The Firebase session cookie has expired. Please sign in again';
      case 'uid-already-exists':
      return ' The provided user ID is already in use by another user.';
      case 'sign_in_failed':
      return 'Sign-in Failed. Please try again';
      case 'network-request-failed':
      return 'Network request failed. Please check your internet connection.';
      default :
      return 'platform $code Please try again';

    }
  }
}