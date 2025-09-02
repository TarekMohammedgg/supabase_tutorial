import 'dart:developer';

import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:supabase_tutorial/constants.dart';

class SupabaseHelper {
  static init ({required String publicUrl , required String  publicNanoKey})async {
     await Supabase.initialize(
    url: publicUrl,
    anonKey: publicNanoKey,
  );
  }
    static Future<void> login({required String email , required String password }) async {
    try {
      await Supabase.instance.client.auth.signInWithPassword(
        email: email,
        password: password,

      );
      log("the Login is success") ; 
      
    } catch (e) {
      log("the error is $e");
    }
  }

  static     Future<void> register({required String email , required String password}) async {
    try {
      await Supabase.instance.client.auth.signUp(
        email: email,
        password: password,

      );
      log("the Register is success") ; 
    } catch (e) {
      log("the error is $e");
    }
  }


static  Future selectAllData (List<Map<String,dynamic>> todos) async {
   
    todos = await Supabase.instance.client.from(Consts.kDatabaseName).select().order("created_at" ,ascending: false  ) ; 
   
  }
static Future insertData (String title , bool isDone , dynamic todos) async {
    await Supabase.instance.client.from(Consts.kDatabaseName).insert({"title" : title , "isDone" : isDone}) ; 
    selectAllData( todos) ; 

  }
  static  Future updateData (int id  , bool isDone , dynamic todos ) async {
    await Supabase.instance.client.from(Consts.kDatabaseName).update({ "isDone" : isDone}).eq('id', id) ; 
    selectAllData(todos) ; 

  }
  static    Future deleteItem (int id , dynamic todos ) async {
    await Supabase.instance.client.from(Consts.kDatabaseName).delete().eq('id', id) ; 
    selectAllData( todos) ; 

  }
}