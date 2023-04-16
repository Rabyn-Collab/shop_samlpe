

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
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

  Future<void> addProduct({
    required String product_name,
    required String product_detail,
    required int product_price,
    required XFile product_image,
    required String brand,
    required String category,
    required int countInStock,
    required String token
  }) async{
    state = state.copyWith(isSuccess: false, isError: false, errText: '',isLoad: true);
    final response = await service.addProduct(
        product_name: product_name,
        product_detail: product_detail, product_price: product_price,
        product_image: product_image, brand: brand, category: category, countInStock: countInStock, token: token);
    response.fold((l) {
      state = state.copyWith(isSuccess: false, isError: true, errText: l, isLoad: false);
    }, (r) {
      state = state.copyWith(isSuccess: true, isError: false, errText: '',isLoad: false, );
    });
  }





  }
