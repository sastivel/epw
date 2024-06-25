import 'package:EPW_mobile/screens/home/screens/home_screen.dart';

import '../../screens/login/view/login_screen.dart';
import '../../screens/register/view/register_screen.dart';
import '../../utils/common_imports.dart';
import 'app_routes.dart';

class AppPages {
  static final GoRouter router = GoRouter(
      initialLocation:
        // "/${AppRoutes.homeScreen}",
        "/",
    errorBuilder: (context, state) => LoginScreen(),
    routes: <GoRoute>[
      GoRoute(
        path: "/",
        name: AppRoutes.loginScreen,
        builder: (BuildContext context, GoRouterState state) {
          //if (AppUtils.isLoggedIn) {
          // return HomeScreen();
          //} else {
          return LoginScreen();
          // }
        },
      ),
       GoRoute(
        path: "/register",
        name: AppRoutes.registerScreen,
        builder: (BuildContext context, GoRouterState state) {
          //if (AppUtils.isLoggedIn) {
          // return HomeScreen();
          //} else {
          return RegisterScreen();
          // }
        },
      ),
        GoRoute(
        path: "/home",
        name: AppRoutes.homeScreen,
        builder: (BuildContext context, GoRouterState state) {
          //if (AppUtils.isLoggedIn) {
          // return HomeScreen();
          //} else {
          return HomeScreen();
          // }
        },
      ),
      
  ]);
  
  //     GoRoute(
  //       path: "/home",
  //       name: AppRoutes.homeScreen,
  //       builder: (BuildContext context, GoRouterState state) {
  //         // if (AppUtils.isLoggedIn) {
  //         return HomeScreen();
  //         // } else {
  //         //   return LoginScreen();
  //         // }
  //       },
  //     ),

  //   ],
  // );
}
