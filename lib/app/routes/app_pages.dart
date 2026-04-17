import 'package:get/get.dart';

import '../modules/edit_profile/bindings/edit_profile_binding.dart';
import '../modules/edit_profile/views/edit_profile_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/nearby/bindings/nearby_binding.dart';
import '../modules/nearby/views/nearby_view.dart';
import '../modules/preview/bindings/preview_binding.dart';
import '../modules/preview/views/preview_view.dart';
import '../modules/profile/bindings/profile_binding.dart';
import '../modules/profile/views/profile_view.dart';
import '../modules/qr_code/bindings/qr_code_binding.dart';
import '../modules/qr_code/views/qr_code_view.dart';
import '../modules/receive/bindings/receive_binding.dart';
import '../modules/receive/views/receive_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.EDIT_PROFILE,
      page: () => const EditProfileView(),
      binding: EditProfileBinding(),
    ),
    GetPage(
      name: _Paths.PREVIEW,
      page: () => const PreviewView(),
      binding: PreviewBinding(),
    ),
    GetPage(
      name: _Paths.NEARBY,
      page: () => const NearbyView(),
      binding: NearbyBinding(),
    ),
    GetPage(
      name: _Paths.QR_CODE,
      page: () => const QrCodeView(),
      binding: QrCodeBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => const ProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.RECEIVE,
      page: () => const ReceiveView(),
      binding: ReceiveBinding(),
    ),
  ];
}
