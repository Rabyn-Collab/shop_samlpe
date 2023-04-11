import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/auth_provider.dart';
import '../providers/crud_provider.dart';




class HomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final productData = ref.watch(crudProvider);
        return Scaffold(
            appBar: AppBar(
          title: Text('Sample Shop'),
              actions: [
                IconButton(onPressed: (){}, icon: Icon(Icons.shopping_cart))
              ],
            ),
            drawer: Drawer(
              child: ListView(
                children: [
                  ListTile(
                    onTap: (){
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
                              child: Image.network( productData.products[index].product_image, fit: BoxFit.cover,)),
                        );
                        }
                    )
        );
      }
    );
  }
}
