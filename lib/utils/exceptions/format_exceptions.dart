/// Custom exception class to handle various Formate-related errors.
class SFormatException implements Exception {
  /// The error code associated with the exception,
  final String code;

  /// Constructor that takes an error code.
  SFormatException([this.code = "An unexpected format error occured. Please check your input." ]);
  /// Create a format exception from a specific erro message.
  factory SFormatException.fromMessage(String message){
    return SFormatException(message);
  }

  /// Get the corresponding error meassage.
  String get formattedMessage => code;
  /// Get the corresponding error message based on the error code.
  factory SFormatException.formCode(String code) {
    switch (code) {
      case 'invalid-email-format':
        return SFormatException('the email address format is invalid. Please enter a valid email.');
      case 'invalid-phone-number-format':
        return SFormatException('The provided phone number format is invalid. Please enter a valid phone number');
      case 'invalid-date-format':
        return SFormatException('The date format is invalid. Please enter a valid date.');
      case 'invalid-url-format':
        return SFormatException('The URL format is invalid. Please enter a valid URL');
      case 'invalid-credit-card-format':
        return SFormatException('The Credit card format is invalid. Please enter a valid credit card number');
      default :
        return SFormatException('formate: $code Please try agian');

    }
  }
}