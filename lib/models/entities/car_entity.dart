import 'package:equatable/equatable.dart';

class CarEntity extends Equatable{

  final String? carName;
  final String? description;
  final double? pricePerDay;
  final List<String>? images;
  final String sellerUid;
  // final String id;

  const CarEntity({
    required this.carName,
    // required this.id,
    required this.description,
    required this.images,
    required this.pricePerDay,
    required this.sellerUid
  });

  Map<String,dynamic> toJson(){
    return {
      "carName":carName,
      "description":description,
      "pricePerDay":pricePerDay,
      "images":images,
      "sellerUid":sellerUid
    };
  }

  factory CarEntity.fromJson(Map<String,dynamic> json){
    return CarEntity(carName: json["carName"],description: json["description"],
        images: json["images"],sellerUid: json["sellerUid"],pricePerDay: json["pricePerDay"]);
  }


  @override
  // TODO: implement props
  List<Object?> get props => [carName,description,pricePerDay,images,sellerUid];



}