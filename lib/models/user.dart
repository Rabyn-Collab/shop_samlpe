


class Shipping{
 final String address;
 final String city;
 final bool isEmpty;
 Shipping({
  required this.address,
  required this.city,
  required this.isEmpty
});

 factory Shipping.fromJson(Map<String, dynamic> json){
  return Shipping(
      address: json['address'],
      city: json['city'],
      isEmpty: json['isEmpty']
  );
 }

}

class User{
 final String id;
  final String fullname;
  final String  email;
  final  bool isAdmin;
  final String token;
  final Shipping shipping;

  User({
   required this.token,
   required this.id,
   required this.email,
   required this.fullname,
   required this.isAdmin,
   required this.shipping
});



  factory User.fromJson(Map<String, dynamic> json){
   return User(
       token: json['token'],
       id: json['id'],
       email: json['email'],
       fullname: json['fullname'],
       isAdmin: json['isAdmin'],
    shipping: Shipping.fromJson(json['shippingAddress'])
   );
  }


 factory User.empty(){
  return User(
     email: '',
   fullname: '',
   id: '',
   token: 'no-data',
   isAdmin: false,
   shipping: Shipping(address: '', city: '', isEmpty: false)
  );
 }


}


class User2{
 final String id;
final String fullname;
final String email;
final bool isAdmin;

User2({
  required this.isAdmin,
 required this.fullname,
 required this.id,
 required this.email
});

 factory User2.fromJson(Map<String, dynamic> json){
  return User2(
      id: json['_id'],
      email: json['email'],
      fullname: json['fullname'],
      isAdmin: json['isAdmin'],
  );
 }


}