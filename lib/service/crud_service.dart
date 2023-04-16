import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:fireapp/api.dart';
import 'package:fireapp/models/product.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';


final crudService = Provider((ref) => CrudService());

class CrudService {

  final dio = Dio();



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

  Future<Either<String, bool>> updateProduct() async{
    try {
      final response = await dio.get(Api.baseUrl);
      final data = (response.data as List).map((e) => Product.fromJson(e)).toList();
      return Right(true);

    }on DioError catch (err){
      print(err.response);
      return Left(err.toString());
    }
  }


  Future<Either<String, bool>> removeProduct() async{
    try {
      final response = await dio.get(Api.baseUrl);
      final data = (response.data as List).map((e) => Product.fromJson(e)).toList();
      return Right(true);

    }on DioError catch (err){
      print(err.response);
      return Left(err.toString());
    }
  }


}
