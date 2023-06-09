import 'dart:io';
import 'package:fireapp/api.dart';
import 'package:fireapp/common_provider/other_provider.dart';
import 'package:fireapp/commons_widgets/snack_shows.dart';
import 'package:fireapp/models/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import '../constants/sizes.dart';
import '../providers/auth_provider.dart';
import '../providers/crud_provider.dart';


class UpdatePage extends ConsumerStatefulWidget {
  final Product product;
  UpdatePage(this.product);

  @override
  ConsumerState<UpdatePage> createState() => _UpdatePageState();
}

class _UpdatePageState extends ConsumerState<UpdatePage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController detailController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController brandController = TextEditingController();
  TextEditingController categoryController = TextEditingController();
  TextEditingController stockController = TextEditingController();
  final _form = GlobalKey<FormState>();

  @override
  void initState() {
    nameController.text = widget.product.product_name;
    detailController.text =  widget.product.product_detail;
    priceController.text =  widget.product.product_price.toString();
    brandController.text =  widget.product.brand;
    categoryController.text =  widget.product.category;
    stockController.text = widget.product.countInStock.toString();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {

    ref.listen(crudProvider, (previous, next) {
      if(next.isError){
        SnackShow.showError(next.errText);
      }else if (next.isSuccess){
        ref.invalidate(crudProvider);
        Get.back();
        SnackShow.showSuccess('success');
      }
    });

    final crud = ref.watch(crudProvider);
    final auth = ref.watch(authProvider);
    final mod = ref.watch(mode);
    final pass = ref.watch(passHide);
    final image = ref.watch(imageProvider);
    return WillPopScope(
      onWillPop: ()async{
        if(crud.isLoad){
          return false;
        }
        return true;
      },
      child: Scaffold(
        body: SafeArea(
          child: Form(
            autovalidateMode: mod,
            key: _form,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
              child: ListView(
                children: [
                  Text('Add Form'),
                  gapH32,
                  TextFormField(
                    keyboardType: TextInputType.text,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(10)
                    ],
                    decoration: InputDecoration(
                        hintText: 'Title'
                    ),
                    textInputAction: TextInputAction.next,
                    validator: (val){
                      if(val!.isEmpty){
                        return  'title is required';
                      }else if(val.length < 7){
                        return 'minimum 6 character required';
                      }
                      return null;
                    },
                    controller: nameController,
                  ),
                  gapH16,
                  TextFormField(
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        hintText: 'Detail'
                    ),
                    textInputAction: TextInputAction.done,
                    validator: (val){
                      if(val!.isEmpty){
                        return  'detail is required';
                      }
                      return null;
                    },
                    controller: detailController,
                  ),
                  gapH16,
                  TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        hintText: 'Price'
                    ),
                    textInputAction: TextInputAction.done,
                    validator: (val){
                      if(val!.isEmpty){
                        return  'price is required';
                      }
                      return null;
                    },
                    controller: priceController,
                  ),
                  gapH16,
                  TextFormField(
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        hintText: 'Brand'
                    ),
                    textInputAction: TextInputAction.done,
                    validator: (val){
                      if(val!.isEmpty){
                        return  'brand is required';
                      }
                      return null;
                    },
                    controller:brandController,
                  ),
                  gapH16,
                  TextFormField(
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        hintText: 'Category'
                    ),
                    textInputAction: TextInputAction.done,
                    validator: (val){
                      if(val!.isEmpty){
                        return  'category is required';
                      }
                      return null;
                    },
                    controller: categoryController,
                  ),
                  gapH16,
                  TextFormField(
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(2)
                    ],
                    decoration: InputDecoration(
                        hintText: 'Stock'
                    ),
                    textInputAction: TextInputAction.done,
                    validator: (val){
                      if(val!.isEmpty){
                        return  'stock is required';
                      }
                      return null;
                    },
                    controller: stockController,
                  ),

                  gapH24,
                  InkWell(
                      onTap: (){
                        Get.defaultDialog(
                            title: 'Choose From',
                            content: Column(
                              children: [
                                TextButton(onPressed: (){
                                  Navigator.of(context).pop();
                                  ref.read(imageProvider.notifier).pickImage(true);
                                }, child: Text('Camera')),
                                TextButton(onPressed: (){
                                  Navigator.of(context).pop();
                                  ref.read(imageProvider.notifier).pickImage(false);
                                }, child: Text('Gallery')),
                              ],
                            )
                        );

                      },
                      child: Container(
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.white)
                        ),
                        child: image == null ? Image.network('${Api.baseUrl}${widget.product.product_image}') : Image.file(File(image.path)),
                      )),
                  gapH16,

                  ElevatedButton(
                      onPressed:crud.isLoad ? null : (){
                        FocusScope.of(context).unfocus();
                        _form.currentState!.save();
                        if(_form.currentState!.validate()){

                          if(image == null){
                            ref.read(crudProvider.notifier).updateProduct(
                                token: auth.user.token,
                                product_name: nameController.text.trim(),
                                product_detail: detailController.text.trim(),
                                product_price: int.parse(priceController.text.trim()),
                                id: widget.product.id,
                                old_image: widget.product.product_image,
                                brand: brandController.text.trim(),
                                category: categoryController.text.trim(),
                                countInStock: int.parse(stockController.text.trim())
                            );
                          }else{
                            ref.read(crudProvider.notifier).updateProduct(
                              id: widget.product.id,
                                old_image: widget.product.product_image,
                                token: auth.user.token,
                                product_name: nameController.text.trim(),
                                product_detail: detailController.text.trim(),
                                product_price: int.parse(priceController.text.trim()),
                                image: image,
                                brand: brandController.text.trim(),
                                category: categoryController.text.trim(),
                                countInStock: int.parse(stockController.text.trim())
                            );

                          }

                        }else{
                          ref.read(mode.notifier).change();
                        }
                      },
                      child:crud.isLoad ? CircularProgressIndicator(): Text('Submit')),

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
