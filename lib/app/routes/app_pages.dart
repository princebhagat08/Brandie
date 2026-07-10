import 'package:get/get.dart';

import '../modules/chat/bindings/chat_binding.dart';
import '../modules/chat/views/chat_view.dart';
import '../modules/edit_post/bindings/edit_post_binding.dart';
import '../modules/edit_post/views/edit_post_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/media_preview/bindings/media_preview_binding.dart';
import '../modules/media_preview/views/media_preview_view.dart';
import '../modules/notification/bindings/notification_binding.dart';
import '../modules/notification/views/notification_view.dart';
import '../modules/profile/bindings/profile_binding.dart';
import '../modules/profile/views/profile_view.dart';
import '../modules/search/bindings/search_binding.dart';
import '../modules/search/views/search_view.dart';
import '../modules/smart_post_loading/bindings/smart_post_loading_binding.dart';
import '../modules/smart_post_loading/views/smart_post_loading_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.NOTIFICATION,
      page: () => const NotificationView(),
      binding: NotificationBinding(),
    ),
    GetPage(
      name: _Paths.SEARCH,
      page: () => const SearchView(),
      binding: SearchBinding(),
    ),
    GetPage(
      name: _Paths.CHAT,
      page: () => const ChatView(),
      binding: ChatBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => const ProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: _Paths.MEDIA_PREVIEW,
      page: () => const MediaPreviewView(),
      binding: MediaPreviewBinding(),
    ),
    GetPage(
      name: _Paths.SMART_POST_LOADING,
      page: () => const SmartPostLoadingView(),
      binding: SmartPostLoadingBinding(),
    ),
    GetPage(
      name: _Paths.EDIT_POST,
      page: () => const EditPostView(),
      binding: EditPostBinding(),
    ),
  ];
}
