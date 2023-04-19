import 'package:fireapp/export_widgets.dart';
import 'package:fireapp/providers/cart_provider.dart';
import 'package:fireapp/view/home_page.dart';
import 'package:fireapp/view/ship_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';

import '../api.dart';
import '../constants/sizes.dart';
import '../providers/crud_provider.dart';



class CartPage extends ConsumerWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    ref.listen(crudProvider, (previous, next) {
      if(next.isError){
        SnackShow.showError(next.errText);
      }else if (next.isSuccess){
        ref.invalidate(crudProvider);
        Get.offAll(()=> HomePage());
        SnackShow.showSuccess('success');
      }
    });
    final crud = ref.watch(crudProvider);
    final carData = ref.watch(cartProvider);
    final auth = ref.watch(authProvider);
    final total =ref.watch(cartProvider.notifier).getTotal;

    return Scaffold(
        body:  SafeArea(
                  child: carData.isEmpty ? Center(child: Text('Add Some Product To cart')): Column(
                    children: [
                    Expanded(
                        child: ListView.builder(
                          itemCount: carData.length,
                            itemBuilder: (context, index){
                            final cart = carData[index];
                              return Row(
                                children: [
                                  Expanded(child: Image.network('${Api.baseUrl}${cart.product_image}')),
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
                            ElevatedButton( onPressed: crud.isLoad ? null : (){
                              if(auth.user.shipping.isEmpty){
                                 Get.to(() => ShipPage(), transition:  Transition.leftToRight);
                              }else{
                                ref.read(crudProvider.notifier).orderCreate(
                                    orderItems: carData,
                                    totalPrice: total,
                                    token: auth.user.token
                                );
                              }

                            }, child : crud.isLoad ? Center(child: CircularProgressIndicator()): Text('Check Out'))

                          ],
                        ),
                      )
                    ],
                  )
              )


    );
  }
}
