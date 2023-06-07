import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../entities/car_entity.dart';

class CarRepository{

  CarRepository():fireStoreInstance = FirebaseFirestore.instance
  ,firebaseStorageInstance = FirebaseStorage.instance
  ,firebaseAuthInstance = FirebaseAuth.instance;

  final FirebaseFirestore fireStoreInstance;
  final FirebaseStorage firebaseStorageInstance;
  final FirebaseAuth firebaseAuthInstance;

  Future<void> addCarOffer(String carName,String description,double price,List<Uint8List?>? images,String location)async{

    List<String> imagesPath=[];
    int index=0;

    DocumentSnapshot userSnapShot = await getCarSeller(firebaseAuthInstance.currentUser!.uid);
    DocumentReference userRef = userSnapShot.reference;
    final docId = await fireStoreInstance.collection("cars").add({
      "carName": carName, "description": description,
      "price": price,"images":imagesPath,"userRef":userRef,
      "addedDate":DateTime.now(),
      "location":location
    });
    for(int x=0;x<images!.length;x++) {
      final res = await firebaseStorageInstance.ref()
          .child("cars/${firebaseAuthInstance.currentUser!.uid}/${docId.id}/$index")
          .putData(images[x]!);
      final String imagePath = await res.ref.getDownloadURL();
      imagesPath.add(imagePath);
      index +=1;
    }

    await fireStoreInstance.collection("cars").doc(docId.id).update({
      "images":imagesPath
    });


  }

  Future<QuerySnapshot<Map<String, dynamic>>> getFirstCarsDocuments()async{

    try {

      final data = await fireStoreInstance.collection("cars").
      orderBy("addedDate",descending: true).limit(5).get();
      print(data.size);
      return data;
    }catch(e){
      rethrow;
    }
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getSortedFirstCarsDocuments(int type)async{

    try {
      final data = await fireStoreInstance.collection("cars").
      orderBy("price",descending: (type==1)?true:false).limit(5).get();
      return data;
    }catch(e){
      rethrow;
    }
  }

  Future<List<CarEntity>> searchForCars(String text)async{

    try {
      List<CarEntity> cars =[];

      QuerySnapshot querySnapshot = await fireStoreInstance.collection("cars").where('carName',isGreaterThanOrEqualTo: text)
          .where("carName",isLessThan: "${text}z")
          .get();

      final List<QueryDocumentSnapshot> sortedDocs = querySnapshot.docs;
      sortedDocs.sort((doc1, doc2) {
        final dynamic data1 = (doc1.data() as Map<String,dynamic>)["carName"];
        final dynamic data2 = (doc2.data() as Map<String,dynamic>)["carName"];

        return data1.compareTo(data2); //Sort in descending order
      });

      for (var doc in sortedDocs) {
        final dynamic data = (doc.data() as Map<String,dynamic>);
        if (data != null) {
          CarEntity car = CarEntity.fromJson(doc);
          await car.fetchUser();
          cars.add(car);
        }
      }
      return cars;
    }catch(e){
      rethrow;
    }
  }


  Future<List<CarEntity>> getFirstCars(QuerySnapshot<Map<String,dynamic>> data)async{

    List<CarEntity> cars =[];
    try {
      for (var element in data.docs) {
        CarEntity car = CarEntity.fromJson(element);
        await car.fetchUser();
        cars.add(car);
      }
      return cars;
    }catch(e){
      return cars;
    }
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getNextSortedCarsDocs(int type,QuerySnapshot<Map<String,dynamic>> oldData)async{

    try {
      final data = await fireStoreInstance.collection("cars").orderBy("price",descending: (type==1)?true:false)
          .startAfter([oldData.docs[oldData.size-1].data()["price"]])
          .limit(5).get();

      return data;
    }catch(e){
      rethrow;
    }
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getNextCarsDocs(QuerySnapshot<Map<String,dynamic>> oldData)async{

    try {
      final data = await fireStoreInstance.collection("cars").orderBy("addedDate",descending: true)
          .startAfter([oldData.docs[oldData.size-1].data()["addedDate"]])
          .limit(5).get();
      return data;
    }catch(e){
      rethrow;
    }
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getCarSeller(String sellerUid)async{

      final snapShot = await fireStoreInstance.collection("users").doc(sellerUid).get();
      return snapShot;
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getCarById(String carUid)async{

    final snapShot = await fireStoreInstance.collection("cars").doc(carUid).get();
    return snapShot;
  }

}