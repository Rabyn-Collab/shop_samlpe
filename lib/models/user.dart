



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

  factory User.empty(){
   return User(
       token: '',
       id: '',
       email: '',
       fullname: '',
       isAdmin: false
   );
  }

}