import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rent_car/models/entities/offer_entity.dart';
import 'package:rent_car/models/repository/repository_auth.dart';
import 'package:rent_car/models/repository/repository_fireStore.dart';

import 'CarRepository.dart';

class OffersRepository{

  final CollectionReference _offersCollection = FirebaseFirestore.instance.collection('offers');
  final FirebaseAuth firebaseAuthInstance;
  final CarRepository carRepository;
  final FireStoreRepositoryImplementation fireStoreRepositoryImplementation;

  OffersRepository():firebaseAuthInstance = FirebaseAuth.instance,
  carRepository = CarRepository(),
  fireStoreRepositoryImplementation=FireStoreRepositoryImplementation(authenticationRepositoryImplementation: AuthenticationRepositoryImplementation());

  Future<List<OfferEntity>> getOffers() async {

    final userRef = fireStoreRepositoryImplementation.fireStore_instance.collection("users").doc(firebaseAuthInstance.currentUser!.uid);
    List<OfferEntity> offers =[];
    final QuerySnapshot snapshot2 = await _offersCollection.orderBy('dateOfOffer',descending: true)
        .where('renterRef', isEqualTo: userRef)
        .get();

    final QuerySnapshot snapshot1 = await _offersCollection.orderBy('dateOfOffer',descending: true).get();
    List<Object> snapshots=[];
    for (var element in snapshot1.docs) {
      DocumentReference carRef = (element.data() as Map<String,dynamic>)["carRef"];
      DocumentSnapshot car = await carRef.get();
      if( (car.data() as Map<String,dynamic>)["userRef"] == userRef ){
      snapshots.add(element);
      }
    }

    final List<DocumentSnapshot> mergedList =
    List.from(snapshots)..addAll(snapshot2.docs);
    for (var element in mergedList) {
      OfferEntity offerEntity = OfferEntity.fromJson(element);
      await offerEntity.carEntity?.fetchUser();
      await offerEntity.fetchCar();
      await offerEntity.fetchRenter();
      offers.add(offerEntity);
    }

    return offers;
  }


  Future<void> addOffer(String carUid,String sellerUid)async{

    DocumentSnapshot carSnapShot = await carRepository.getCarById(carUid);
    DocumentReference carRef = carSnapShot.reference;

    DocumentSnapshot userSnapShot = await fireStoreRepositoryImplementation.getUserById(firebaseAuthInstance.currentUser!.uid);
    DocumentReference userRef = userSnapShot.reference;

    await _offersCollection.add(
        {"carRef": carRef,
          "renterRef": userRef,
          "dateOfOffer":Timestamp.now()
        });

  }

  Future<DocumentSnapshot<Object?>> getOfferById(String offerUid)async{

    final snapShot = await _offersCollection.doc(offerUid).get();
    return snapShot;
  }

}