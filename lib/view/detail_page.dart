import 'package:fireapp/api.dart';
import 'package:fireapp/commons_widgets/snack_shows.dart';
import 'package:fireapp/export_widgets.dart';
import 'package:fireapp/models/product.dart';
import 'package:fireapp/providers/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../constants/sizes.dart';


class DetailPage extends StatelessWidget {
final Product product;
DetailPage(this.product);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Stack(
              children: [
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                    topRight: Radius.circular(20)
                    )
                  ),
                  margin: EdgeInsets.only(top: 190),
                  child: Container(
                    margin: EdgeInsets.only(top: 100),
                    padding: EdgeInsets.all(15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(product.product_detail, style: TextStyle(color: Colors.black),),
                          ],
                        )),
                        Consumer(
                          builder: (context, ref, child) {
                            final auth = ref.watch(authProvider);
                            return ElevatedButton(
                                onPressed: auth.user.isAdmin ? null: () {
                                  final response = ref.read(cartProvider.notifier).addToCart(product);
                                  if(response == 'added'){
                                    SnackShow.showBar(context, true);
                                  }else{
                                    SnackShow.showBar(context, false);
                                  }
                                },
                                child: Text('Add To Cart')
                            );
                          }
                        )
                      ],
                    ),
                  ),
                ),
               Container(
                 height: 260,
                 child: Row(
                   children: [
                     Expanded(
                       child: Padding(
                         padding: const EdgeInsets.only(left: 15),
                         child: Column(
                           mainAxisAlignment: MainAxisAlignment.center,
                           crossAxisAlignment: CrossAxisAlignment.start,
                           children: [
                             Text(product.product_name),
                             gapH6,
                             Text('Rs.'+product.product_price.toString())
                           ],
                         ),
                       ),
                     ),
                     Expanded(
                         flex: 2,
                         child: ClipRRect(
                             borderRadius: BorderRadius.circular(10), 
                             child: Hero(
                                 tag: product.id,
                                 child: Image.network('${Api.baseUrl}${product.product_image}')))),
                   ],
                 ),
               ),

              ],
            )
        )
    );
  }
}
