import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rent_car/models/entities/car_entity.dart';
import 'package:rent_car/models/entities/user_entity.dart';

class OfferEntity{

  final DocumentReference carRef;
  final DocumentReference renterRef;
  final String id;
  final Timestamp dateOfOffer;
  UserEntity? renterEntity;
  CarEntity? carEntity;

  OfferEntity({
    this.carEntity,
    this.renterEntity,
    required this.id,
    required this.dateOfOffer,
    required this.carRef,
    required this.renterRef
  });

  Map<String,dynamic> toJson(){
    return {
      "carRef":carRef,
      "dateOfOffer":dateOfOffer,
      "renterRef":renterRef
    };
  }

  factory OfferEntity.fromJson(DocumentSnapshot doc){
    final data = doc.data() as Map<String, dynamic>;
    return OfferEntity(
      id: doc.id,
      dateOfOffer: data["dateOfOffer"],
      carRef: data["carRef"],
      renterRef: data["renterRef"]
    );
  }

  Future<void> fetchRenter() async {
    DocumentSnapshot userSnapshot = await renterRef.get();
    renterEntity = UserEntity.fromFireStore(userSnapshot);
  }

  Future<void> fetchCar() async {
    DocumentSnapshot userSnapshot = await carRef.get();
    carEntity = CarEntity.fromJson(userSnapshot);
    carEntity!.fetchUser();
  }

}