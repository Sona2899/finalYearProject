import 'package:auto_route/auto_route_annotations.dart';
import 'package:cctv_monitor2/screens/home/homeView.dart';
import 'package:cctv_monitor2/screens/login/loginView.dart';

@MaterialAutoRouter(
  routes: <AutoRoute>[
    MaterialRoute(page: LoginView, initial: true, name: 'loginViewRoute'),
    MaterialRoute(page: HomeView, name: 'homeViewRoute'),
  ],
)
class $Router {}
