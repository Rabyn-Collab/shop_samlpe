import 'dart:async';
import 'package:fireapp/models/auth_state.dart';
import 'package:fireapp/service/auth_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../main.dart';




final authProvider = StateNotifierProvider<AuthProvider, AuthState>((ref) => AuthProvider(
    AuthState(user: ref.watch(boxA), isLoad: false, errText: '', isSuccess: false, isError: false),
    ref.watch(authService)
));


class AuthProvider extends StateNotifier<AuthState>{
  final AuthService service;
  AuthProvider(super.state, this.service);

  Future<void> userLogin({
    required String email,
    required String password
  }) async{
    state = state.copyWith(isSuccess: false, isError: false, errText: '',isLoad: true, user: null);
    final response = await service.userLogin(email: email, password: password);
    response.fold((l) {
      state = state.copyWith(isSuccess: false, isError: true, errText: l, isLoad: false, user: null);
    }, (r) {
      state = state.copyWith(isSuccess: true, isError: false, errText: '',isLoad: false, user: r);
    });
  }


  Future<void> userSignUp({
    required String email,
    required String password,
    required String fullname,
  }) async{
    state = state.copyWith(isSuccess: false, isError: false, errText: '',isLoad: true, user: null);
    final response = await service.userSignUp(email: email, password: password, fullname: fullname);
    response.fold((l) {
      state = state.copyWith(isSuccess: false, isError: true, errText: l, isLoad: false, user: null);
    }, (r) {
      state = state.copyWith(isSuccess: true, isError: false, errText: '',isLoad: false, user: null);
    });

  }






  void userLogOut() async {
    final bx = Hive.box<String?>('user');
    bx.clear();
    state = state.copyWith(user: null);
  }


}
