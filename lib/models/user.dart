



class User{
 final String id;
  final String fullname;
  final String  email;
  final  bool isAdmin;
  final String token;

  User({
   required this.token,
   required this.id,
   required this.email,
   required this.fullname,
   required this.isAdmin
});



  factory User.fromJson(Map<String, dynamic> json){
   return User(
       token: json['token'],
       id: json['id'],
       email: json['email'],
       fullname: json['fullname'],
       isAdmin: json['isAdmin']
   );
  }

}