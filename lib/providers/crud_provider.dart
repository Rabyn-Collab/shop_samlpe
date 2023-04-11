

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/common_state.dart';
import '../service/crud_service.dart';

final crudProvider = StateNotifierProvider<CrudProvider, CommonState>((ref) => CrudProvider(CommonState.empty(),ref.watch(crudService)));

class CrudProvider extends StateNotifier<CommonState>{
  final CrudService service;
  CrudProvider(super.state, this.service){
    getProducts();
  }

  Future<void> getProducts() async{
    state = state.copyWith(isLoad: true, errText: '', isError: false, isSuccess: false);
    final response = await service.getData();
    response.fold(
            (l) {
          state = state.copyWith(isLoad: false, errText: l, isError: true, isSuccess: false);
        },
            (r) {
          state = state.copyWith(isLoad: false, errText: '',
            isError: false, isSuccess: true,
            products: r
          );
        }
    );
  }






  }
