import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:rent_car/models/entities/car_entity.dart';
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
     "name":name,"email":email,"image":imagePath,"cars":[]
   });
   return imagePath;
 }

  Future<void> addNewUserDataGoogleSignIn(String id,String name,String email,String image)async{
    List<String> methods = await FirebaseAuth.instance.fetchSignInMethodsForEmail(FirebaseAuth.instance.currentUser!.email!);
    if(!methods.contains("password")) {
      await fireStore_instance.collection("users").doc(id).set({
        "name": name, "email": email, "image": image,"cars":[]
      });
    }

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
           cars: [],
           email: FirebaseAuth.instance.currentUser!.email!
           , name: FirebaseAuth.instance.currentUser!.displayName!
           , photo: FirebaseAuth.instance.currentUser!.photoURL);
     }

   }catch(e){
     return UserEntity.empty;
   }

 }

 Future<void> addCarOffer(String carName,String description,double price,List<Uint8List> images,String sellerId)async{

   List<String> imagesPath=[];
   int index=0;
   for(Uint8List image in images) {
     final res = await firebaseStorage.ref()
         .child("cars/$sellerId/$index")
         .putData(image);
     final String imagePath = await res.ref.getDownloadURL();
     imagesPath.add(imagePath);
     index +=1;
   }
   await fireStore_instance.collection("cars").doc().set({
     "carName": carName, "description": description,
     "price": price,"images":imagesPath,"sellerUid":sellerId
   });

 }


 Future<List<CarEntity>> getCars()async{

   List<CarEntity> cars =[];
   try {
     final snapShot = await fireStore_instance.collection("cars").get();

     for (var element in snapShot.docs) {
       cars.add(CarEntity.fromJson(element.data()));
     }

     return cars;

   }catch(e){
     print(e);
     return cars;
   }

 }
 
 Future<void> saveNameChanges(String name)async{
     await fireStore_instance
         .collection("users").doc(FirebaseAuth.instance.currentUser!.uid).update({"name":name});
     UserEntity user = (authenticationRepositoryImplementation.currentUser.copyWith(name: name));
     authenticationRepositoryImplementation.cacheChange(user);
 }

 Future<String> saveImageChanges(Uint8List imagePath1)async{
   final uId = FirebaseAuth.instance.currentUser!.uid;
   final res = await firebaseStorage.ref().child("$uId/image").putData(imagePath1);
   final String imagePath = await res.ref.getDownloadURL();
   await fireStore_instance
       .collection("users").doc(FirebaseAuth.instance.currentUser!.uid).update({
     "image": imagePath});
   UserEntity user = (authenticationRepositoryImplementation.currentUser.copyWith(photo: imagePath));
   authenticationRepositoryImplementation.cacheChange(user);
  return imagePath;
 }


}