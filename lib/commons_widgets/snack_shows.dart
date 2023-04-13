import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../view/cart_page.dart';


class SnackShow{

static showError(String message){
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0
  );
}



static showSuccess(String message){
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.green,
      textColor: Colors.white,
      fontSize: 16.0
  );
}


static showBar (BuildContext context, bool isAdd){
  ScaffoldMessenger.of(context).hideCurrentSnackBar();
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    duration: Duration(seconds: 1),
      content: Text(isAdd ? 'successfully added to cart': 'already added to cart'),
     action: SnackBarAction(label: 'Go To Cart', onPressed: (){
       Get.to(() => CartPage());
     }),
      ));
}


}