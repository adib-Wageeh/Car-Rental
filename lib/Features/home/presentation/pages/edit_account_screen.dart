import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rent_car/Features/home/presentation/viewModel/getUserData/get_user_data_cubit.dart';
import '../../../../main.dart';
import '../../../../models/repository/repository_fireStore.dart';
import '../../../authentication/presentation/pages/Crop_image_screen.dart';
import '../../../authentication/presentation/viewModel/signUp_cubit/sign_up_cubit.dart';
import '../viewModel/editProfile/edit_profile_cubit.dart';

class EditAccountScreenProvider extends StatelessWidget {
  const EditAccountScreenProvider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<EditProfileCubit>(create: (context)=>EditProfileCubit(
    fireStoreRepositoryImplementation: getIt<FireStoreRepositoryImplementation>()),
    child: const EditAccountScreen(),
    );
  }
}



class EditAccountScreen extends StatelessWidget {
  const EditAccountScreen({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true,title: const Text("Edit profile"),),
      body: BlocListener<EditProfileCubit, EditProfileState>(
          listener: (context, state) {
            if(state is EditProfileLoading){
              EasyLoading.show(status: 'Saving...');
            }else if(state is EditProfileDone){
              EasyLoading.dismiss();
              Navigator.pop(context);
            }else if(state is EditProfileError){
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Edit first")));
            }else{
              EasyLoading.dismiss();
            }
          },
      child: Column(
        children: [

          const Padding(
            padding: EdgeInsets.only(top: 56.0),
            child: ProfilePictureWidget(),
          ),
            const SizedBox(height: 28,),
            Padding(
                     padding: const EdgeInsets.symmetric(horizontal: 24.0),
                     child: Column(
                       children: [
                         TextField(
                         controller: context.read<EditProfileCubit>().nameEditingController
                         ,decoration: InputDecoration(
                           labelText: "Name",
                           border: OutlineInputBorder(borderRadius: BorderRadius.circular(24)),
                           hintText: context.read<UserCubit>().state.name
                         ),),
                       ],
                     ),
                   ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.only(bottom: 24.0),
            child: SizedBox(
              width: 120,
              child: ElevatedButton(onPressed: ()async{
                final result = await context.read<EditProfileCubit>().saveData();
                if(result == 1){
                  await context.read<UserCubit>().updateUserInPrefs(
                      context.read<EditProfileCubit>().nameEditingController.text,
                      context.read<EditProfileCubit>().image
                  );
                }

              },style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent
              ), child: const Text("Save",style: TextStyle(color: Colors.white)),),
            ),
          )
        ],
      ),
),
    );
  }

}


class ProfilePictureWidget extends StatelessWidget {
  const ProfilePictureWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditProfileCubit, EditProfileState>(
      builder: (context, state) {
        return Stack(
            children:[
              (context.read<EditProfileCubit>().image==null)?
              CircleAvatar(
                radius: 80,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(64),
                  child: Image.memory(
                    File(context.read<UserCubit>().state.photo!).readAsBytesSync(),
                  ),
                ),
              ):
              CircleAvatar(
                radius: 80,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(64),
                  child: Image.memory(
                    context.read<EditProfileCubit>().image!
                  ),
                ),
              )
              ,
              Positioned(
                  top: 0,
                  right: 0,
                  child: Container(
                      width: 50,
                      decoration: const BoxDecoration(color: Colors.blueAccent,
                          shape: BoxShape.circle
                      ),
                      child: IconButton(onPressed: ()async{
                        final Uint8List? pickedImage = await context.read<SignUpCubit>().getImage();
                        if(pickedImage != null) {
                          final Uint8List image= await Navigator.push(context, MaterialPageRoute(builder: (
                              context) => CropImagePage(imagePath: pickedImage)));
                          context.read<EditProfileCubit>().setImage(image);
                        }
                      }, icon: const Icon(FontAwesomeIcons.edit,size: 24,))))
            ]
        );
      },
    );
  }
}