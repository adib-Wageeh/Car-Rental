import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:rent_car/models/entities/user_entity.dart';

class CarEntity extends Equatable{

  final String? carName;
  final String? description;
  final String? pricePerDay;
  final List<dynamic>? images;
  final String sellerUid;
  final String addedDate;
  final String location;
  final String id;
  final UserEntity userEntity;

  const CarEntity({
    required this.location,
    this.userEntity=UserEntity.empty,
    required this.addedDate,
    required this.carName,
    required this.id,
    required this.description,
    required this.images,
    required this.pricePerDay,
    required this.sellerUid
  });

  Map<String,dynamic> toJson(){
    return {
      "carName":carName,
      "location":location,
      "description":description,
      "pricePerDay":pricePerDay,
      "images":images,
      "sellerUid":sellerUid,
      "addedDate":addedDate
    };
  }

  factory CarEntity.fromJson(Map<String,dynamic> json,String id,UserEntity userEntity){
    return CarEntity(
    addedDate: fromTimeStampToTime(json["addedDate"]),
    userEntity: userEntity,
    id: id,
    location: json["location"]
    ,carName: json["carName"],description: json["description"],
        images: json["images"],sellerUid: json["sellerUid"],pricePerDay: json["price"]);
  }

  static String fromTimeStampToTime(Timestamp timestamp) {
    final date = DateTime.now().difference(timestamp.toDate());

    print(date);
    if (date.inDays > 365) {
      return "${date.inDays~/365} year";
    } else if (date.inDays > 30) {
      return "${date.inDays~/30} month";
    } else if (date.inHours > 24) {
      return "${date.inHours~/24} day";
    } else if (date.inMinutes > 60) {
      return "${date.inMinutes~/60} hour";
    } else if(date.inMinutes == 0){
      return "1 min";
    }else{
      return "${date.inMinutes} min";
    }
  }

  @override
  // TODO: implement props
  List<Object?> get props => [id,carName,description,pricePerDay,images,sellerUid];



}