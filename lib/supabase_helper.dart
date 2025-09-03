import 'dart:developer';
import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:supabase_tutorial/constants.dart';

class SupabaseHelper {
  static init({
    required String publicUrl,
    required String publicNanoKey,
  }) async {
    await Supabase.initialize(url: publicUrl, anonKey: publicNanoKey);
  }

  static Future<void> login({
    required String email,
    required String password,
  }) async {
    try {
      await Supabase.instance.client.auth.signInWithPassword(
        email: email,
        password: password,
      );
      log("the Login is success");
    } catch (e) {
      log("the error is $e");
    }
  }

  static Future<void> register({
    required String email,
    required String password,
  }) async {
    try {
      await Supabase.instance.client.auth.signUp(
        email: email,
        password: password,
      );
      log("the Register is success");
    } catch (e) {
      log("the error is $e");
    }
  }

  static Future selectAllData(List<Map<String, dynamic>> todos) async {
    todos = await Supabase.instance.client
        .from(Consts.kDatabaseName)
        .select()
        .order("created_at", ascending: false);
  }

  static Future insertData(String title, bool isDone, dynamic todos) async {
    await Supabase.instance.client.from(Consts.kDatabaseName).insert({
      "title": title,
      "isDone": isDone,
    });
    selectAllData(todos);
  }

  static Future updateData(int id, bool isDone, dynamic todos) async {
    await Supabase.instance.client
        .from(Consts.kDatabaseName)
        .update({"isDone": isDone})
        .eq('id', id);
    selectAllData(todos);
  }

  static Future deleteItem(int id, dynamic todos) async {
    await Supabase.instance.client
        .from(Consts.kDatabaseName)
        .delete()
        .eq('id', id);
    selectAllData(todos);
  }

  static Future selectAllDataRealTime(dynamic todos) async {
    Supabase.instance.client
        .from(Consts.kDatabaseName)
        .stream(primaryKey: ['id'])
        .listen((event) {
          log("the event values is : ${event.toString()}");
          todos = event;
        });
  }

  static String? imageUrl;
  static Future<File?> pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.camera);
    if (image == null) return null;
    final File imageFile = File(image.path);
    return imageFile;
  }

  static Future uploadImage() async {
    final imageFile = await pickImage();
    if (imageFile == null) return;
    final String timeStamp = DateTime.now().microsecondsSinceEpoch.toString();
    final String uniqueImagePath =
        "${timeStamp}_${imageFile.path.split('/').last}";
    await Supabase.instance.client.storage
        .from(Consts.kStorageBucket)
        .upload(uniqueImagePath, imageFile);
    imageUrl = Supabase.instance.client.storage
        .from(Consts.kStorageBucket)
        .getPublicUrl(uniqueImagePath);
    // setState(() {

    // });
  }

  static Future deleteImgae() async {
    if (imageUrl == null) return null;
    await Supabase.instance.client.storage.from(Consts.kStorageBucket).remove([
      imageUrl!.split('/').last,
    ]);
    // setState(() {
    //   imageUrl = null ;
    // });
  }
}
