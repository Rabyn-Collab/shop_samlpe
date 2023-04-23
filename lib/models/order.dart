import 'cart_item.dart';






class Orders{
  final List<CartItem> carts;
  final int totalPrice;
  final String  dateTime;

  Orders({
    required this.totalPrice,
    required this.carts,
    required this.dateTime
});

  factory Orders.fromJson(Map<String, dynamic> json){
    return Orders(
        totalPrice: json['totalPrice'],
        dateTime: json['createdAt'],
        carts: (json['orderItems'] as List).map((e) => CartItem.fromJson(e)).toList()
    );
  }


}