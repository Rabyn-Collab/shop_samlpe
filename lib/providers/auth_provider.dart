import 'dart:async';
import 'package:fireapp/models/auth_state.dart';
import 'package:fireapp/service/auth_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/user.dart';



final authProvider = StateNotifierProvider<AuthProvider, AuthState>((ref) => AuthProvider(
    AuthState(user: User.empty(), isLoad: false, errText: '', isSuccess: false, isError: false),
    ref.watch(authService)
));


class AuthProvider extends StateNotifier<AuthState>{
  final AuthService service;
  AuthProvider(super.state, this.service);

  Future<void> userLogin({
    required String email,
    required String password
  }) async{

  }


  Future<void> userSignUp({
    required String email,
    required String password,
    required String fullname,
  }) async{

  }

  Future<void> userLogOut() async {

  }


}
