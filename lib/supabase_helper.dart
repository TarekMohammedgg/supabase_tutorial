import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseHelper {
  static init ({required String publicUrl , required String  publicNanoKey})async {
     await Supabase.initialize(
    url: publicUrl,
    anonKey: publicNanoKey,
  );
  }
}