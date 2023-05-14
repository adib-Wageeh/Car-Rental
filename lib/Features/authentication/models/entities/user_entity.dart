import 'dart:typed_data';

import 'package:equatable/equatable.dart';

class UserEntity extends Equatable{

  const UserEntity({
  required this.id,
  required this.email,
  required this.name,
   required this.photo,
  });

  final String email;
  final String id;
  final String? name;
  final String? photo;
  static const empty = UserEntity(id: '',email: "",name: "",photo: "");
  bool get isEmpty => this == UserEntity.empty;
  bool get isNotEmpty => this != UserEntity.empty;

  @override
  List<Object?> get props => [email, id, name, photo];

  Map<String,dynamic> toJson(){
    return {
      "name":name,
      "email":email,
      "photo":photo,
    };
  }

  factory UserEntity.fromJson(Map<String,dynamic> json,String uuid){
    return UserEntity(id: uuid, email: json["email"], name: json["name"], photo: json["image"]);
  }

}