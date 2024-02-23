import 'package:intl/intl.dart';

class SFormatter {
  static String formatData(DateTime? date){
    date ??= DateTime.now();
    return DateFormat('dd-MM-yyyy').format(date); 
  }

  static String formatCurrency(double amount){
    return NumberFormat.currency(locale: 'PAK',symbol: '\rs').format(amount);
  }

  static String formatPhoneNumber(String phoneNumber){
    // Assuming a 10-digiy Us phone number format: (123) 456-7890
    if(phoneNumber.length == 10){
      return '(${phoneNumber.substring(0,3)}) ${phoneNumber.substring(3,6)} ${phoneNumber.substring(6)}';
    }else if (phoneNumber.length == 11){
      return '(${phoneNumber.substring(0,4)}) ${phoneNumber.substring(4)}';
    }
    return phoneNumber;
  }
  
}