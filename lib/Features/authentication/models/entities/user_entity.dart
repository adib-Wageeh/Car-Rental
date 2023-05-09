import 'package:equatable/equatable.dart';

class UserEntity extends Equatable{

  const UserEntity({
  required this.id,
  this.email,
  this.name,
  this.photo,
  });

  final String? email;
  final String id;
  final String? name;
  final String? photo;
  static const empty = UserEntity(id: '');
  bool get isEmpty => this == UserEntity.empty;
  bool get isNotEmpty => this != UserEntity.empty;

  @override
  List<Object?> get props => [email, id, name, photo];

}