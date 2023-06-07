import 'package:cloud_firestore/cloud_firestore.dart';
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

  factory UserEntity.fromFireStore(DocumentSnapshot snapshot){
    final data = snapshot.data() as Map<String,dynamic>;
    return UserEntity(id: snapshot.id, email: data["email"], name: data["name"], photo: data["image"]);
  }

  UserEntity copyWith({
     String? email,
     String? id,
     String? name,
     String? photo,
  }) {
    return UserEntity(
      name: name??this.name,
      photo: photo??this.photo,
      email: email?? this.email,
      id: id??this.id
    );
  }



}