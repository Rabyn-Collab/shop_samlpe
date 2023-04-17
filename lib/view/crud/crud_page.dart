import 'package:fireapp/export_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';

import '../../api.dart';
import '../../providers/crud_provider.dart';


class CrudPage extends ConsumerWidget {

  @override
  Widget build(BuildContext context, ref) {
    final productData = ref.watch(crudProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text('Product Crud'),
        actions: [
          TextButton(
              onPressed: (){
                Get.to(() => AddPage());

              },
              child: Text('Add Product')
          )
        ],
      ),
        body:  SafeArea(
          child: productData.isLoad ? Center(child: CircularProgressIndicator()):
          productData.isError ? Text(productData.errText) :
          ListView.builder(
              itemCount: productData.products.length,
              itemBuilder: (context, index){
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                  child: ListTile(
                    leading: Image.network('${Api.baseUrl}${productData.products[index].product_image}', fit: BoxFit.cover,),
                      title:     Text(productData.products[index].product_name),
                    trailing: Container(
                      width: 100,
                      child: Row(
                        children: [
                       IconButton(
                           onPressed: (){

                             Get.to(() => UpdatePage( productData.products[index]));
                           }, icon: Icon(Icons.edit)),
                       IconButton(
                           onPressed: (){

                           }, icon: Icon(Icons.delete)),
                        ],
                      ),
                    ),
                  ),
                );
              }
          ),
        )
    );
  }
}
