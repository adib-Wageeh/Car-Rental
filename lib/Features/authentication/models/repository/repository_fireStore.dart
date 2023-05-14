import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:rent_car/Features/authentication/models/entities/user_entity.dart';
import '../../../../application/app/cache.dart';

class FireStoreRepositoryImplementation {

  FireStoreRepositoryImplementation({
    CacheClient? cache,
    FirebaseFirestore? fireStoreInstance,
    FirebaseStorage? firebaseStorage,
}): _cache = cache ?? CacheClient(),
    fireStore_instance = fireStoreInstance?? FirebaseFirestore.instance,
    firebaseStorage = firebaseStorage?? FirebaseStorage.instance;

  final FirebaseFirestore fireStore_instance;
  final FirebaseStorage firebaseStorage;
  final CacheClient _cache;

 Future<String> addNewUserData(String id,String name,String email,Uint8List image)async{
   final res = await firebaseStorage.ref().child("$id/image").putData(image);
   final String imagePath = await res.ref.getDownloadURL();
   await fireStore_instance.collection("users").doc(id).set({
     "name":name,"email":email,"image":imagePath
   });
   return imagePath;
 }

 Future<UserEntity> getUser(String uuid)async{

   try {
     DocumentSnapshot<Map<String, dynamic>> snapShot = await fireStore_instance
         .collection("users").doc(uuid).get();
     if (snapShot.data() != null) {
       return UserEntity.fromJson(snapShot.data()!, uuid);
     } else {
       return UserEntity.empty;
     }
   }catch(e){
     return UserEntity.empty;
   }

 }

 // void saveToCache(String uuid)async{
 //   final res = await getUser(uuid);
 //   _cache.write<UserEntity>(key: "000", value:res);
 // }


  UserEntity get currentUser {
    return _cache.read<UserEntity>(key: "000") ?? UserEntity.empty;
  }

}