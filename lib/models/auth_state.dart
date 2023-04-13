

import 'package:fireapp/models/user.dart';

class AuthState{

    final bool isLoad;
    final bool isError;
    final  bool isSuccess;
    final String errText;
     User? user;


    AuthState({
      required this.isLoad,
      required this.errText,
      required this.isSuccess,
      required this.isError,
      this.user
});


    AuthState copyWith(
    {
      bool? isLoad,
      bool? isError,
       bool? isSuccess,
      String? errText,
      User? user,

    }
        ){
      return AuthState(
          user: user ?? this.user,
          isLoad: isLoad ?? this.isLoad,
          errText: errText ?? this.errText,
          isSuccess: isSuccess ?? this.isSuccess,
          isError: isError ?? this.isError
      );
    }


}