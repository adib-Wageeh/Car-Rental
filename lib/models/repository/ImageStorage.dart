import 'dart:typed_data';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';

class ImageStorage {

  static Future<String> getImagePath() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("image") ?? '';
  }

  static Future<void> saveImage(String image,String uId) async {

    final Reference ref = FirebaseStorage.instance.refFromURL(image);
    final String imageUrl = await ref.getDownloadURL();
    final Uri imageUri = Uri.parse(imageUrl);
    final http.Response response = await http.get(imageUri);

    final Directory appDir = await getApplicationDocumentsDirectory();
    final String imagePath = '${appDir.path}/$uId.png';
    final File file = File(imagePath);
    await file.writeAsBytes(response.bodyBytes);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("image", file.path);
  }

  static Future<void> saveGoogleImage(String image,String uId) async {
    final FirebaseStorage storage = FirebaseStorage.instance;
    final Reference storageRef = storage.ref().child("users");
    final ListResult listResult = await storageRef.listAll();
    bool found=false;
    for (final item in listResult.items) {
      if (item.name == uId) {
        found = true;
        break;
      }
    }
    if(found == true){
      await saveImage(image,uId);
    }else {
      final http.Response response = await http.get(Uri.parse(image));
      final Directory appDir = await getApplicationDocumentsDirectory();
      final String imagePath = '${appDir.path}/$uId.png';
      final File file = File(imagePath);
      await file.writeAsBytes(response.bodyBytes);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString("image", file.path);
    }

  }

  static Future<void> saveUintImage(Uint8List image,String uId) async {

    final Directory appDir = await getApplicationDocumentsDirectory();
    final String imagePath = '${appDir.path}/$uId.png';
    final File file = File(imagePath);
    await file.writeAsBytes(image);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("image", file.path);
  }

  static Future<void> deleteImage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String imagePath = prefs.getString("image")!;

    final File imageFile = File(imagePath);
    if (imageFile.existsSync()) {
      await imageFile.delete();
    }

    await prefs.remove("image");
  }
}