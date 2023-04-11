import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:fireapp/api.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';
import 'package:hive/hive.dart';

import '../models/user.dart';


final authService = Provider((ref) => AuthService());

class AuthService {

final dio = Dio();

   Future<Either<String, User>> userLogin({
    required String email,
     required String password
}) async{

     try {

       final response = await dio.post(Api.userLogin, data: {
         'email': email,
         'password': password
       });
       final bx = Hive.box<String?>('user');
       bx.put('user', jsonEncode(response.data['data']));
      return Right(User.fromJson(response.data['data']));

    }on DioError catch (err){
       print(err.response);
      return Left(err.toString());
    }on HiveError catch (err){
       return Left(err.toString());
     }
  }


Future<Either<String, bool>> userSignUp({
  required String email,
  required String password,
  required String fullname
}) async{

  try {

    final response = await dio.post(Api.userSignUp, data: {
      'email': email,
      'password': password,
      'fullname': fullname
    });

    return Right(true);
  }on DioError catch (err){
    print(err);
    return Left(err.toString());
  }
}





}
