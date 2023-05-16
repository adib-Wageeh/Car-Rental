part of 'get_user_data_cubit.dart';

class GetUserDataState extends Equatable {
  const GetUserDataState({
    this.email= "",
    this.name= "",
    this.imagePath= ""
  });

  final String email;
  final String name;
  final String imagePath;

  @override
  List<Object?> get props => [name,email,imagePath];

  GetUserDataState copyWith({
    String? email,
    String? name,
    String? imagePath,
  }) {
    return GetUserDataState(
      name: name ?? this.name,
      email: email ?? this.email,
      imagePath: imagePath ?? this.imagePath
    );
  }
}
