import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:rent_car/models/entities/user_entity.dart';

class CarEntity extends Equatable{

  final String? carName;
  final String? description;
  final String? pricePerDay;
  final List<dynamic>? images;
  final String addedDate;
  final String location;
  final String id;
  final DocumentReference userRef;
  UserEntity? userEntity;

  CarEntity({
    this.userEntity,
    required this.location,
    required this.userRef,
    required this.addedDate,
    required this.carName,
    required this.id,
    required this.description,
    required this.images,
    required this.pricePerDay
  });

  Map<String,dynamic> toJson(){
    return {
      "carName":carName,
      "location":location,
      "description":description,
      "pricePerDay":pricePerDay,
      "images":images,
      "addedDate":addedDate
    };
  }

  factory CarEntity.fromJson(DocumentSnapshot snapshot){
    final data = snapshot.data() as Map<String,dynamic>;
    return CarEntity(
    addedDate: fromTimeStampToTime(data["addedDate"]),
        userRef: data["userRef"],
    id: snapshot.id,
    location: data["location"]
    ,carName: data["carName"],description: data["description"],
        images: data["images"],pricePerDay: data["price"].toString());
  }

  static String fromTimeStampToTime(Timestamp timestamp) {
    final date = DateTime.now().difference(timestamp.toDate());

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

  Future<void> fetchUser() async {
    DocumentSnapshot userSnapshot = await userRef.get();
    userEntity = UserEntity.fromFireStore(userSnapshot);
  }

  @override
  // TODO: implement props
  List<Object?> get props => [userRef,id,carName,description,pricePerDay,images];



}