import 'dart:typed_data';
import 'package:cropperx/cropperx.dart';
import 'package:flutter/material.dart';

final _cropperKey = GlobalKey(debugLabel: 'cropperKey');
class CropImagePage extends StatelessWidget {
  final Uint8List imagePath;
  const CropImagePage({required this.imagePath,Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Cropper(
              image: Image.memory(imagePath),
              cropperKey: _cropperKey,
              overlayType: OverlayType.circle,
              aspectRatio: 1,
              gridLineThickness: 0,
            ),
            const SizedBox(height: 12,),
            SizedBox(
                width: 200,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.blueAccent)
                    ,onPressed: ()async{
                  final Uint8List? imageBytes = await Cropper.crop(
                    cropperKey: _cropperKey,
                  );
                  if(imageBytes != null) {
                    Navigator.pop(context,imageBytes);
                  }
                },
                    child: const Text("SAVE",style: TextStyle(color: Colors.white),)))
          ],
        ),
      ),
    );
  }
}
