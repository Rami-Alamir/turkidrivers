class User {
  Data data;
  bool success;

  User({
    required this.data,
    required this.success,
  });

  factory User.fromJson(Map<String, dynamic> json) =>
      User(data: Data.fromJson(json["data"]), success: json['success']);
}

class Data {
  Data(
      {required this.id,
      required this.integrateId,
      required this.name,
      required this.email});
  int id;
  int integrateId;
  String name;
  String email;
  factory Data.fromJson(Map<String, dynamic> json) => Data(
      id: json["id"],
      integrateId: json["integrate_id"],
      name: json["name"],
      email: json["email"]);
}
