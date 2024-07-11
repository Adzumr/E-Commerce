class UserModel {
  String? id;
  final String? name;
  final String? email;

  UserModel({
    this.id,
    this.name,
    this.email,
  });

  UserModel.fromJson(Map<String, dynamic> json)
      : id = json['id'] as String?,
        name = json['name'] as String?,
        email = json['email'] as String?;

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'email': email,
      };
}
