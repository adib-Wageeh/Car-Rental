import 'package:equatable/equatable.dart';

class UserEntity extends Equatable{

  const UserEntity({
  required this.id,
  required this.email,
  required this.name,
   required this.photo,
    required this.cars
  });

  final String email;
  final String id;
  final String? name;
  final String? photo;
  final List<String>? cars;
  static const empty = UserEntity(id: '',email: "",name: "",photo: "",cars: []);
  bool get isEmpty => this == UserEntity.empty;
  bool get isNotEmpty => this != UserEntity.empty;

  @override
  List<Object?> get props => [cars,email, id, name, photo];

  Map<String,dynamic> toJson(){
    return {
      "name":name,
      "cars":cars,
      "email":email,
      "photo":photo,
    };
  }

  factory UserEntity.fromJson(Map<String,dynamic> json,String uuid){
    return UserEntity(cars: json["cars"],id: uuid, email: json["email"], name: json["name"], photo: json["image"]);
  }

  UserEntity copyWith({
     String? email,
     String? id,
     String? name,
     String? photo,
     List<String>? cars
  }) {
    return UserEntity(
      cars: cars??this.cars,
      name: name??this.name,
      photo: photo??this.photo,
      email: email?? this.email,
      id: id??this.id
    );
  }



}