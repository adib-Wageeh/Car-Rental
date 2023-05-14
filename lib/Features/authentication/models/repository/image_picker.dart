
import 'dart:typed_data';

import 'package:image_picker/image_picker.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';

class RepositoryImagePicker{

  Future<Uint8List?> pickImageFunction()async{

    XFile? pickedImage;
    try {
      final ImagePicker picker = ImagePicker();
      pickedImage =
      await picker.pickImage(source: ImageSource.gallery,);

      if (pickedImage != null) {
       final compressed = await FlutterImageCompress.compressWithFile(pickedImage.path,quality: 50);
       if(compressed != null){
         return compressed;
       }
    }

    }catch (e) {
      rethrow;
    }
    return null;

  }

}