import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:fireapp/api.dart';
import 'package:fireapp/models/product.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


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





}
