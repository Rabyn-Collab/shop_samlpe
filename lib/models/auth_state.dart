

import 'package:fireapp/models/user.dart';

class AuthState{

    final bool isLoad;
    final bool isError;
    final  bool isSuccess;
    final String errText;
    final User user;


    AuthState({
      required this.user,
      required this.isLoad,
      required this.errText,
      required this.isSuccess,
      required this.isError
});



}