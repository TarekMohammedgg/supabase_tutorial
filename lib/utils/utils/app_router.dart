

import 'package:go_router/go_router.dart';
import 'package:supabase_tutorial/screens/authentication/login_screen.dart';
import 'package:supabase_tutorial/screens/authentication/register_screen.dart';
import 'package:supabase_tutorial/screens/home/home_screen.dart';

abstract class AppRouter {
  static const kLoginScreen = '/';
  static const kRegisterScreenn = '/RegisterScreen';
  static const kHomeScreen = "/HomeScreen"; 

  static final router = GoRouter(
    routes: [
      GoRoute(
        path: kLoginScreen,
        builder: (context, state) =>  LoginScreen(),
      ),
      GoRoute(
        path: kRegisterScreenn,
        builder: (context, state) =>  RegisterScreen(),
      ),  
      GoRoute(path: kHomeScreen , builder: (context , state) => HomeScreen()  )  ],
  );
}
