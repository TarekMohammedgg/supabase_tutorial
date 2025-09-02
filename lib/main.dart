import 'package:flutter/material.dart';
import 'package:supabase_tutorial/constants.dart';
import 'package:supabase_tutorial/supabase_helper.dart';
import 'package:supabase_tutorial/utils/utils/app_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SupabaseHelper.init(publicUrl: Consts.kSUPABASE_URL , publicNanoKey: Consts.kSUPABASE_ANON_KEY) ; 

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: AppRouter.router,
     
    );
  }
}

