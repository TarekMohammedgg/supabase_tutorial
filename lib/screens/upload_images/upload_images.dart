import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:supabase_tutorial/constants.dart';

class UploadImages extends StatefulWidget {
  const UploadImages({super.key});

  @override
  State<UploadImages> createState() => _UploadImagesState();
}

class _UploadImagesState extends State<UploadImages> {
  String? imageUrl;
  Future<File?> pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.camera);
    if (image == null) return null;
    final File imageFile = File(image.path);
    return imageFile;
  }

  Future uploadImage() async {
    final imageFile = await pickImage();
    if (imageFile == null) return ;
    final String timeStamp = DateTime.now().microsecondsSinceEpoch.toString();
    final String uniqueImagePath = "${timeStamp}_${imageFile.path.split('/').last}";
    await Supabase.instance.client.storage
        .from(Consts.kStorageBucket)
        .upload(uniqueImagePath, imageFile);
    imageUrl = Supabase.instance.client.storage
        .from(Consts.kStorageBucket)
        .getPublicUrl(uniqueImagePath);
    setState(() {
      
    });
  }

  Future deleteImgae() async {
    if (imageUrl == null) return null;
    await Supabase.instance.client.storage.from(Consts.kStorageBucket).remove([
      imageUrl!.split('/').last,
    ]);
    setState(() {
      imageUrl = null ; 
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            imageUrl == null
                ? Text("no images uploaded")
                : Image.network(imageUrl!, height: 200),
            SizedBox(height: 20),
            ElevatedButton(onPressed: uploadImage, child: const Text("Upload Image")),
            ElevatedButton(onPressed: deleteImgae, child: const Text("Delete Image")),
          ],
        ),
      ),
    );
  }
}
