import 'package:fireapp/main.dart';
import 'package:fireapp/models/cart_item.dart';
import 'package:fireapp/models/product.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';


final cartProvider = StateNotifierProvider<CartProvider, List<CartItem>>((ref) => CartProvider(ref.watch(boxB)));

class CartProvider extends StateNotifier<List<CartItem>>{
  CartProvider(super.state);

  String addToCart(Product product){
     if(state.isEmpty){
       final cart= CartItem(
           product_price: product.product_price,
           product_name: product.product_name,
           product_image: product.product_image,
           quantity: 1,
         product_id: product.id
       );
      Hive.box<CartItem>('carts').add(cart);
       state = [cart];
       return 'added';
     }else{
        final current = state.firstWhere((element) => element.product_id == product.id, orElse: (){
          return CartItem(product_price: 0, product_name: 'no-data', product_image: '', quantity: 0, product_id:'0');
        });

        if(current.product_name == 'no-data'){
          final cart= CartItem(
              product_price: product.product_price,
              product_name: product.product_name,
              product_image: product.product_image,
              quantity: 1,
              product_id: product.id
          );
          Hive.box<CartItem>('carts').add(cart);
          state = [...state, cart];
          return 'added';
        }else{
          return 'already added';
        }


     }

  }

  void addSingle(CartItem cartItem){
     cartItem.quantity = cartItem.quantity + 1;
     cartItem.save();
     state = [
       for(final c in state) if(c.product_id == cartItem.product_id) cartItem else c
     ];
  }

  void removeSingle(CartItem cartItem){
   if(cartItem.quantity > 1){
     cartItem.quantity = cartItem.quantity - 1;
     cartItem.save();
     state = [
       for(final c in state) if(c.product_id == cartItem.product_id) cartItem else c
     ];
   }
  }

  void remove(CartItem cartItem){
    cartItem.delete();
    state.remove(cartItem);
    state = [...state];
  }


  int get getTotal{
    int total = 0;
    state.forEach((element) {
      total += element.product_price * element.quantity ;
    });

    return total;
  }

  void clear(){
    Hive.box<CartItem>('carts').clear();
    state = [];
  }


}
