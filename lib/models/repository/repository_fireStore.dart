import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:rent_car/models/repository/repository_auth.dart';
import '../entities/user_entity.dart';

class FireStoreRepositoryImplementation {

  FireStoreRepositoryImplementation({
    FirebaseFirestore? fireStoreInstance,
    FirebaseStorage? firebaseStorage,
    required this.authenticationRepositoryImplementation
}):
    fireStore_instance = fireStoreInstance?? FirebaseFirestore.instance,
    firebaseStorage = firebaseStorage?? FirebaseStorage.instance;

  final FirebaseFirestore fireStore_instance;
  final FirebaseStorage firebaseStorage;
  final AuthenticationRepositoryImplementation authenticationRepositoryImplementation;

 Future<String> addNewUserData(String id,String name,String email,Uint8List image)async{
   final res = await firebaseStorage.ref().child("users/$id/image").putData(image);
   final String imagePath = await res.ref.getDownloadURL();
   await fireStore_instance.collection("users").doc(id).set({
     "name":name,"email":email,"image":imagePath
   });
   return imagePath;
 }

  Future<void> addNewUserDataGoogleSignIn(String id,String name,String email,String image)async{
    bool isInFireStore = await doesUidExist(id);
    if(!isInFireStore) {
      await fireStore_instance.collection("users").doc(id).set({
        "name": name, "email": email, "image": image
      });
    }

  }

  Future<bool> doesUidExist(String uid) async {
    final CollectionReference usersRef = FirebaseFirestore.instance.collection('users');
    final DocumentSnapshot snapshot = await usersRef.doc(uid).get();
    return snapshot.exists;
  }

 Future<UserEntity> getUser(String uuid)async{

   try {
     List<String> methods = await FirebaseAuth.instance.fetchSignInMethodsForEmail(FirebaseAuth.instance.currentUser!.email!);
     if(methods.contains("password")) {
       DocumentSnapshot<
           Map<String, dynamic>> snapShot = await fireStore_instance
           .collection("users").doc(uuid).get();
       if (snapShot.data() != null) {
         return UserEntity.fromJson(snapShot.data()!, uuid);
       } else {
         return UserEntity.empty;
       }
     }else{
       try{
         DocumentSnapshot<Map<String, dynamic>> snapShot = await fireStore_instance
             .collection("users").doc(uuid).get();
         if (snapShot.data() != null) {
           return UserEntity.fromJson(snapShot.data()!, uuid);
         } else {
           return UserEntity.empty;
         }
       }catch(e){
       }
       return UserEntity(id: uuid,
           email: FirebaseAuth.instance.currentUser!.email!
           , name: FirebaseAuth.instance.currentUser!.displayName!
           , photo: FirebaseAuth.instance.currentUser!.photoURL);
     }

   }catch(e){
     return UserEntity.empty;
   }

 }


 
 Future<void> saveNameChanges(String name)async{
     await fireStore_instance
         .collection("users").doc(FirebaseAuth.instance.currentUser!.uid).update({"name":name});
 }

 Future<String> saveImageChanges(Uint8List imagePath1)async{
   final uId = FirebaseAuth.instance.currentUser!.uid;
   final res = await firebaseStorage.ref().child("users/$uId/image").putData(imagePath1);
   final String imagePath = await res.ref.getDownloadURL();
   await fireStore_instance
       .collection("users").doc(FirebaseAuth.instance.currentUser!.uid).update({
     "image": imagePath});
  return imagePath;
 }

  Future<DocumentSnapshot<Map<String, dynamic>>> getUserById(String userUid)async{

    final snapShot = await fireStore_instance.collection("users").doc(userUid).get();
    return snapShot;
  }


}