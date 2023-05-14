import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../../../../application/core/assets.dart';
import '../../../viewModel/signUp_cubit/sign_up_cubit.dart';
import '../../Crop_image_screen.dart';

class ProfilePictureWidget extends StatelessWidget {
  const ProfilePictureWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      builder: (context, state) {
        return Stack(
            children:[ CircleAvatar(backgroundImage: (state.imagePath!= null)?Image.memory(state.imagePath!,fit: BoxFit.fill).image:
            Image.asset(Assets.signUpImageIcon).image
              ,
              backgroundColor: Colors.blue,
              radius: 65,
            ),
              Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                  width: 35,
                  decoration: const BoxDecoration(color: Colors.blueAccent,
                      shape: BoxShape.circle
                  ),
                  child: IconButton(onPressed: ()async{
                    final Uint8List? pickedImage = await context.read<SignUpCubit>().getImage();
                    if(pickedImage != null) {
                     final Uint8List image= await Navigator.push(context, MaterialPageRoute(builder: (
                          context) => CropImagePage(imagePath: pickedImage)));
                     context.read<SignUpCubit>().setImage(image);

                    }
                  }, icon: const Icon(FontAwesomeIcons.add,size: 24,))))
            ]
        );
      },
    );
  }
}