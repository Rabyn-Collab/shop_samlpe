import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authService = Provider((ref) => AuthService());

class AuthService {


   Future<Either<String, bool>> userLogin({
    required String email,
     required String password
}) async{

     try {


      return Right(true);

    }catch (err){
      return Left(err.toString());
    }
  }





}
