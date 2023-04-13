import 'package:fireapp/providers/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../constants/sizes.dart';



class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Consumer(
            builder: (context, ref, child) {
              final carData = ref.watch(cartProvider);
              final total =ref.watch(cartProvider.notifier).getTotal;
              return SafeArea(
                  child: carData.isEmpty ? Center(child: Text('Add Some Product To cart')): Column(
                    children: [
                    Expanded(
                        child: ListView.builder(
                          itemCount: carData.length,
                            itemBuilder: (context, index){
                            final cart = carData[index];
                              return Row(
                                children: [
                                  Expanded(child: Image.network(cart.product_image)),
                                  Expanded( 
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        IconButton(onPressed: (){
                                          ref.read(cartProvider.notifier).remove(cart);
                                        }, icon: Icon((Icons.close))),
                                        Text(cart.product_name),
                                        gapH16,
                                        Text('Rs.${cart.product_price}'),
                                           gapH16,
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: [
                                            OutlinedButton(onPressed: (){
                                              ref.read(cartProvider.notifier).addSingle(cart);
                                            }, child: Icon(Icons.add)),
                                            Padding(
                                              padding: const EdgeInsets.symmetric(horizontal: 10),
                                              child: Text('${cart.quantity}'),
                                            ),
                                            OutlinedButton(onPressed: (){
                                              ref.read(cartProvider.notifier).removeSingle(cart);
                                            }, child: Icon(Icons.remove)),
                                          ],
                                        )

                                      ],
                                    ),
                                  ),
                                  gapW16,
                                ],
                              );
                            }
                        )
                    ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Total'),
                                Text('Rs.$total')
                              ],
                            ),
                            gapH12,
                            ElevatedButton(onPressed: (){}, child: Text('Check Out'))

                          ],
                        ),
                      )
                    ],
                  )
              );
            }
             )
    );
  }
}
