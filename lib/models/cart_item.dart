import 'package:hive/hive.dart';
part 'cart_item.g.dart';


@HiveType(typeId: 0)
class CartItem extends HiveObject{

  @HiveField(0)
  String product_name;

  @HiveField(1)
  int product_price;

  @HiveField(2)
  int quantity;

  @HiveField(3)
  String product_image;

  @HiveField(4)
  String product_id;


  CartItem({
    required this.product_price,
    required this.product_name,
    required this.product_image,
    required this.quantity,
    required this.product_id
});

  factory CartItem.fromJson(Map<String, dynamic> json){
    return CartItem(
        product_price: json['price'],
         product_name: json['name'],
        product_image: json['image'],
        quantity: json['qty'],
        product_id: json['product']
    );
  }

  Map<String, dynamic>  toJson (){
    return {
     'name': this.product_name,
    'price': this.product_price,
    'qty': this.quantity,
    'image': this.product_image,
    'product': this.product_id
    };
  }

}