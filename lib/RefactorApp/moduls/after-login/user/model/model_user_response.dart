// ignore_for_file: public_member_api_docs, sort_constructors_first
class ModelUserResponse {
  final String username;
  final String name;
  final String email;
  final String alamat;

  ModelUserResponse(
      {required this.username,
      required this.name,
      required this.email,
      required this.alamat});

  ModelUserResponse copyWith({
    String? username,
    String? name,
    String? email,
    String? alamat,
  }) {
    return ModelUserResponse(
      username: username ?? this.username,
      name: name ?? this.name,
      email: email ?? this.email,
      alamat: alamat ?? this.alamat,
    );
  }
}
