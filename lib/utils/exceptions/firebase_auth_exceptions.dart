/// Custom exception class to handle various Firbase authentication-related errors.
class SFirebaseAuthException implements Exception {
  /// The error code associated with the exception,
  final String code;

  /// Constructor that takes an error code.
  SFirebaseAuthException(this.code);

  /// Get the corresponding error message based on the error code.
  String get message {
    switch (code) {
      case 'email-already-in-use':
        return 'The email address is already registered. Please use a different email.';
      case 'invalid-email':
        return 'The email address provided is invalid. Please enter a valid email.';
      case 'weak-password':
        return 'The password is too weak. Please choose a stranger password.';
      case 'user-disabled':
        return 'This user account has been disabled. Please contact support for assistance.';
      case 'user-not-found':
        return 'Invalid login details. User not found.';
      case 'wrong-password':
        return 'Incorrect password. Please check your password and try agian';
      case 'invalid-verification-code':
        return 'Invalid verification code. Please enter a valid code.';
      case 'invalid-verification-id':
        return 'Invalid verificaiton ID, Please request a new verification code.';
      case 'quota-exceeded':
        return 'Quota-exceeded. Please try again later.';
      case 'email-already-exists':
        return 'The email address already exists. Please use a different email.';
      case 'provider-already-linked':
        return 'Teh account is already linked with another provider.';
      case 'requires-recent-login':
        return 'This operation is sensitive and requires recent authentication. Please log in again.';
      case 'credential-already-in-use':
        return 'This credential is already asseciated with a different user account.';
      case 'user-mismatch':
        return 'The supplied credentials do not correspond to the previous signed in user.';
      case 'account-exists-with-different-credential':
        return 'An account already exists with the same email but different sign-in credentials.';
      case 'operation-not-allowed':
        return 'This operation is not allowed. Contact support for assistance.';
      case 'expired-action-code':
        return 'The action code has expired. Please request a new action code.';
      case 'invalid-action-code':
        return 'The action code is invalid. Please check the code and try again.';
      case 'missing-action-code':
        return 'The action code is missing. Please provide a valid action code.';
      case 'user-token-expired':
        return 'The user\'s token has expired, and authentication is required. Please sign in again';
      case 'invalid-credential':
        return 'The supplied credential is malformed or has expired.';
      case 'invalid-message-payload':
        return 'The email template varification message payload is invalid.';
      case 'invalid-sender':
        return 'The email template sender is invalid. Please verify ther sender\'s email.';
      case 'invalid-recipient-email':
        return 'The recipient email address is invalid. Please provide a valid recipient email';
      case 'missing-iframe-start':
        return 'The email template is missing the iframe start tag.';
      case 'missing-iframe-end':
        return 'The email template is missing the iframe end tag';
      case 'missing-iframe-src':
        return 'The smail template is missing the iframe src attribute.';
      case 'auth-domain-config-required':
        return 'The authDomian configuration is required for the action code verification link';
      case 'missing-app-credential':
        return 'The app credential is missing. Please provide valid app credentials.';
      case 'invalid-app-credential':
        return 'The app credential is invalid. Please provide a valid app credentials.';
      case "session-cookie-expired":
        return 'The Firebase session cookie has expired. Please sign in agian';
      case 'uid-already-exists':
        return 'The provided user ID is already in use by another user';
      case 'invalid-cordove-configuration':
        return 'The provided Cordova configuration is invalid.';
      case 'app-deleted':
        return 'This instance of FirebaseApp has been deleted.';
      case 'user-token-mismatch':
        return 'The provided user\'s token has a mismatch with the authenticated user\'s user ID';
      case 'web-storage-unsupported':
        return 'Web storage is not supported or is disabled';
      case 'app-not-authorized':
        return 'The app is not authorized to use Firebase Authentication with the provided API key';
      case 'keychain-error':
      return 'A keychain error occurred. Please check the keychain and try again.';
      case 'internal-error':
      return 'An internal authentication error occurred. Please try again later.';
      case 'INVALID_LOGIN_CREDENTIALS':
      return 'invalid login credentials.';
      default: 
        return '$code Authentication Exceptions. Please try again';
    }
  }
}