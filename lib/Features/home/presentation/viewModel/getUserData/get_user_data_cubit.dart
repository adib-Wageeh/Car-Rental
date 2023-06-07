import 'dart:io';
import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rent_car/main.dart';
import 'package:rent_car/models/entities/user_entity.dart';
import 'package:rent_car/models/repository/repository_fireStore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../../models/repository/ImageStorage.dart';


class UserCubit extends Cubit<UserEntity> {
  UserCubit() : super(UserEntity.empty) {
    loadUserFromPrefs();
  }

  final CollectionReference usersCollection =
  FirebaseFirestore.instance.collection('users');

  Future<void> loadUserFromPrefs() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String uid = prefs.getString('uid')!;
    final String name = prefs.getString('name')!;
    final String email = prefs.getString('email')!;
    final String imagePath = prefs.getString('image')!;
      UserEntity user = UserEntity(
        id: uid,
        name: name,
        email: email,
        photo: imagePath,
      );
      emit(user);
  }

  Future<void> loadUserFromFireStore() async {
    final User currentUser = FirebaseAuth.instance.currentUser!;
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    bool isUidIn = await getIt<FireStoreRepositoryImplementation>().doesUidExist(currentUser.uid);

    if(isUidIn){

      DocumentSnapshot doc = await usersCollection.doc(currentUser.uid).get();
      Map<String, dynamic> data = doc.data() as Map<String,dynamic>;
      UserEntity user = UserEntity(
          id: currentUser.uid,
          name: data['name'],
          email: data['email'],
          photo: data['image']
      );
      prefs.setString('uid', user.id);
      prefs.setString('name', user.name!);
      prefs.setString('email', user.email);
      for (UserInfo userInfo in currentUser.providerData) {
        if (userInfo.providerId == 'google.com') {
          await ImageStorage.saveGoogleImage(user.photo!,user.id);
        } else if (userInfo.providerId == 'password') {
          await ImageStorage.saveImage(user.photo!,user.id);
        }
      }
    }else{
      await ImageStorage.saveGoogleImage(currentUser.photoURL!,currentUser.uid);
      prefs.setString('uid', currentUser.uid);
      prefs.setString('name', currentUser.displayName!);
      prefs.setString('email', currentUser.email!);
    }
    loadUserFromPrefs();
    }

  Future<void> updateUserInPrefs(String? name,Uint8List? image) async {

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if(name != null && name.isNotEmpty){
      prefs.setString('name', name ?? state.name!);
    }
    if(image != null){
      await ImageStorage.deleteImage();
      await ImageStorage.saveUintImage(image, FirebaseAuth.instance.currentUser!.uid);
    }

    await loadUserFromPrefs();
  }
}

