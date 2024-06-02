class User {
  String? username;
  String? token;
  String? email, first_name, last_name;
  int? id;

  User({
    this.username,
    this.first_name,
    this.last_name,
    this.email,
    this.id,
  });

  factory User.fromJson(json) {
    return User(
      email: json["email"],
      first_name: json["first_name"],
      last_name: json["last_name"],
      username: json["username"],
      id: json["id"],
    );
  }
}
