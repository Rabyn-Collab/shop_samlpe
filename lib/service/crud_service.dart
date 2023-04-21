import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:fireapp/api.dart';
import 'package:fireapp/models/cart_item.dart';
import 'package:fireapp/models/product.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../models/order.dart';


final crudService = Provider((ref) => CrudService());
final orderFetch = FutureProvider.family.autoDispose((ref, String token) => CrudService.getOrder(token: token));
class CrudService {

static  final dio = Dio();

static  Future<List<Orders>> getOrder({
    required String token,
  }) async{
    try {
      final response = await dio.get(Api.orderHistory, options: Options(
          headers: {
            'Authorization': token
          }
      ));
      print(response.data);
      final data = (response.data as List).map((e) => Orders.fromJson(e)).toList();
      return data;

    }on DioError catch (err){
      throw err.toString();
    }
  }



  Future<Either<String, List<Product>>> getData() async{
    try {
      final response = await dio.get(Api.baseUrl);
      final data = (response.data as List).map((e) => Product.fromJson(e)).toList();
      return Right(data);

    }on DioError catch (err){
      print(err.response);
      return Left(err.toString());
    }
  }


  Future<Either<String, bool>> addProduct({
 required String product_name,
 required String product_detail,
 required int product_price,
 required XFile product_image,
 required String brand,
 required String category,
 required int countInStock,
 required String token
}) async{
    try {
      final formData = FormData.fromMap({
        'product_name': product_name,
        'product_detail': product_detail,
        'product_price': product_price,
        'brand': brand,
         'category': category,
        'countInStock': countInStock,
        'product_image': await MultipartFile.fromFile(product_image.path, filename: product_image.name),
      });

      final response = await dio.post(Api.productAdd, data: formData,
       options: Options(
         headers: {
           'Authorization': token
         }
       )
      );
      return Right(true);

    }on DioError catch (err){
      print(err.response);
      return Left(err.toString());
    }
  }

  Future<Either<String, bool>> updateProduct({
    required String product_name,
    required String product_detail,
    required int product_price,
    required String old_image,
    XFile? image,
    required String brand,
    required String category,
    required int countInStock,
    required String token,
    required String id
   }) async{
    try {
   if(image == null){
   final response = await dio.patch('${Api.productUpdate}/$id', data: {
     'product_name': product_name,
     'product_detail': product_detail,
     'product_price': product_price,
     'brand': brand,
     'category': category,
     'countInStock': countInStock,
     'product_image': old_image
   }, options: Options(
       headers: {
         'Authorization': token
       }
   ));
   }else{
     final formData = FormData.fromMap({
       'product_name': product_name,
       'product_detail': product_detail,
       'product_price': product_price,
       'brand': brand,
       'category': category,
       'countInStock': countInStock,
       'product_image': await MultipartFile.fromFile(image.path, filename: image.name),
     });

     final response = await dio.patch('${Api.productUpdate}/$id', data: formData,
         queryParameters: {
       'imagePath': old_image
         },
         options: Options(
             headers: {
               'Authorization': token
             }
         )
     );
   }

   return Right(true);


    }on DioError catch (err){
      print(err.response);
      return Left(err.toString());
    }
  }


  Future<Either<String, bool>> removeProduct({
    required String token,
    required String id,
    required String old_image,
}) async{
    try {
      final response = await dio.get(Api.productRemove, );
      final data = (response.data as List).map((e) => Product.fromJson(e)).toList();
      return Right(true);

    }on DioError catch (err){
      print(err.response);
      return Left(err.toString());
    }
  }






  Future<Either<String, bool>> orderCreate({
   required List<CartItem> orderItems,
   required int totalPrice,
    required String token,
  }) async{
    try {
    final  response = await dio.post(Api.createOrder, data: {
      'orderItems': orderItems.map((e) => e.toJson()).toList(),
      'shippingAddress': {
        'address': "swargadwari nagar",
        'city': "lalitpur nepal",
        'isEmpty': false
      },
      'totalPrice': totalPrice
    }, options: Options(
        headers: {
          'Authorization': token
        }
    ));
      return Right(true);

    }on DioError catch (err){
      print(err.response);
      return Left(err.toString());
    }
  }

  // Future<Either<String, bool>> getOrder({
  //   required String token,
  // }) async{
  //   try {
  //     final  response = await dio.post(Api.createOrder, data: {
  //       'orderItems': orderItems.map((e) => e.toJson()).toList(),
  //       'shippingAddress': {
  //         'address': "swargadwari nagar",
  //         'city': "lalitpur nepal",
  //         'isEmpty': false
  //       },
  //       'totalPrice': totalPrice
  //     }, options: Options(
  //         headers: {
  //           'Authorization': token
  //         }
  //     ));
  //     return Right(true);
  //
  //   }on DioError catch (err){
  //     print(err.response);
  //     return Left(err.toString());
  //   }
  // }



}
