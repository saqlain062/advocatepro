
import 'package:advocatepro_f/features/bottom/profile_screen.dart';
import 'package:advocatepro_f/features/client/screens/favourite/favourite.dart';
import 'package:advocatepro_f/features/client/screens/home/home.dart';
import 'package:advocatepro_f/features/client/screens/lawyer/lawyer.dart';
import 'package:advocatepro_f/routes/routes.dart';
import 'package:get/get.dart';

class AppRoutes {
  static final pages = [
    GetPage(name: SRoutes.home, page: () => const HomeScreenClient()),
    GetPage(name: SRoutes.lawyer, page: () => const LawyerScreen()),
    GetPage(name: SRoutes.favourites, page: () => const FavouriteScreen()),
    GetPage(name: SRoutes.userProfile, page: () => const ProfileScreen()),
  ];
}