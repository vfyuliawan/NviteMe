// ignore_for_file: public_member_api_docs, sort_constructors_first
class ModelUserResponse {
  final String username;
  final String name;
  final String email;
  final String alamat;
  final String photo;

  ModelUserResponse({
    required this.username,
    required this.name,
    required this.email,
    required this.alamat,
    required this.photo,
  });

  ModelUserResponse copyWith(
      {String? username,
      String? name,
      String? email,
      String? alamat,
      String? photo}) {
    return ModelUserResponse(
      username: username ?? this.username,
      name: name ?? this.name,
      email: email ?? this.email,
      alamat: alamat ?? this.alamat,
      photo: photo ?? this.photo,
    );
  }
}
