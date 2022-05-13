
class User {

  String name;
  String id;
  //String email;
 // String password;

  User({required this.name,required this.id});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json['name'],
      id:  json['id_user']
    );
  }
}