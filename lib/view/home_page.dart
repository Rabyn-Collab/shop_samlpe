import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';

import '../providers/auth_provider.dart';
import '../providers/crud_provider.dart';
import 'cart_page.dart';
import 'crud/crud_page.dart';
import 'detail_page.dart';




class HomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final productData = ref.watch(crudProvider);
        final user = ref.watch(authProvider);

        return Scaffold(
            appBar: AppBar(
          title: Text('Sample Shop'),
              actions: [
                IconButton(onPressed: (){
                  Get.to(() => CartPage());
                }, icon: Icon(Icons.shopping_cart))
              ],
            ),
            drawer: Drawer(
              child: ListView(
                children: [
                  DrawerHeader(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(user.user.fullname),
                      Text(user.user.email)
                    ],
                  )),
                  if(user.user.isAdmin) ListTile(
                    onTap: (){
                      Get.to(() => CrudPage());
                    },
                    leading: Icon(Icons.settings),
                    title: Text('Crud'),
                  ),

                  ListTile(
                    onTap: (){
                      Navigator.of(context).pop();
                      ref.read(authProvider.notifier).userLogOut();
                    },
                    leading: Icon(Icons.exit_to_app),
                    title: Text('LogOut'),
                  )
                ],
              ),
            ),
            body: productData.isLoad ? Center(child: CircularProgressIndicator()):
                productData.isError ? Text(productData.errText) :
                    GridView.builder(
                      itemCount: productData.products.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                          childAspectRatio: 2/3,
                          crossAxisSpacing: 5,
                          mainAxisSpacing: 5
                        ),
                        itemBuilder: (context, index){
                        return Padding(
                          padding: const EdgeInsets.all(7.0),
                          child: InkWell(
                            onTap: (){
                              Get.to(() => DetailPage(productData.products[index]));
                            },
                            child: GridTile(
                                footer: Container(
                                  padding: EdgeInsets.all(5),
                                  color: Colors.black45,
                                  height: 50,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(productData.products[index].product_name),
                                      Text('Rs ${productData.products[index].product_price}')
                                    ],
                                  ),
                                ),
                                child: Hero(
                                    tag: productData.products[index].id,
                                    child: Image.network( productData.products[index].product_image, fit: BoxFit.cover,))),
                          ),
                        );
                        }
                    )
        );
      }
    );
  }
}
