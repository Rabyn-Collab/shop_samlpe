import 'package:hive/hive.dart';
part 'cart_item.g.dart';


@HiveType(typeId: 0)
class CartItem extends HiveObject{

  @HiveField(0)
  String product_name;

  @HiveField(1)
  int product_price;

  @HiveField(2)
  String quantity;

  @HiveField(3)
  String product_image;

  @HiveField(4)
  int total;

  CartItem({
    required this.product_price,
    required this.product_name,
    required this.product_image,
    required this.total,
    required this.quantity
})

}