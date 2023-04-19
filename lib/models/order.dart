import 'cart_item.dart';






class Orders{
  final List<CartItem> carts;
  final int totalPrice;

  Orders({
    required this.totalPrice,
    required this.carts
});

  factory Orders.fromJson(Map<String, dynamic> json){
    return Orders(
        totalPrice: json['totalPrice'],
        carts: (json['carts'] as List).map((e) => CartItem.fromJson(e)).toList()
    );
  }


}