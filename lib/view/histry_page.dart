import 'package:fireapp/api.dart';
import 'package:fireapp/constants/sizes.dart';
import 'package:fireapp/export_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../service/crud_service.dart';



class HistoryPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Consumer(
            builder: (context, ref, child) {
              final auth = ref.watch(authProvider);
              final orderData = ref.watch(orderFetch(auth.user.token));
              return SafeArea(
                child: orderData.when(
                    data: (data){
                      return Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: ListView.builder(
                            itemCount: data.length,
                            itemBuilder: (context, index){

                              DateTime now = DateTime.parse(data[index].dateTime);
                              String formattedDate = DateFormat('yyyy-MM-dd – kk:mm').format(now);

                              return  ExpansionTile(
                                  title: Row(
                                    children: [
                                      Text('Total Rs.${data[index].totalPrice}'),

                                    ],
                                  ),
                                children: data[index].carts.map((e){
                                  return Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Image.network('${Api.baseUrl}${e.product_image}'),
                                     Text(e.product_name),
                                      gapH12,
                                      Text('${e.quantity} x Rs.${e.product_price}')
                                    ],
                                  );
                                }).toList(),

                              );

                            }),
                      );
                    },
                    error: (err, stack) => Text('$err'),
                    loading: () => Center(child: CircularProgressIndicator())
                ),
              );
            }
    )
    );
  }
}
