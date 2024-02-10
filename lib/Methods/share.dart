import 'package:share_plus/share_plus.dart';

void shareApp() {
  // Define the text to share
  String text = 'Check out this awesome app!';

  // You can also include a URL to your app in the share message
  // String url = 'https://your-app-url.com';
  // String textWithUrl = '$text\n$url';

  // Share the app using the Share package
  Share.share(text);
}
