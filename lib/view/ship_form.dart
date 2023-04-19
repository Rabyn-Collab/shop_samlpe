import 'package:fireapp/common_provider/other_provider.dart';
import 'package:fireapp/export_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import '../../constants/sizes.dart';


class ShipPage extends ConsumerWidget {

  final addressController = TextEditingController();
  final cityController = TextEditingController();
  final _form = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context, ref) {

    ref.listen(authProvider, (previous, next) {
      if(next.isError){
        SnackShow.showError(next.errText);
      }else if (next.isSuccess){
        Get.back();
        SnackShow.showSuccess('success');
      }
    });

    final auth = ref.watch(authProvider);
    final mod = ref.watch(mode);
    return WillPopScope(
      onWillPop: ()async{
        if(auth.isLoad){
          return false;
        }
        return true;
      },
      child: Scaffold(
        body: SafeArea(
          child: Form(
            autovalidateMode: mod,
            key: _form,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
              child: ListView(
                children: [
                  Text('Shipping Form'),
                  gapH32,
                  TextFormField(
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        hintText: 'Address'
                    ),
                    textInputAction: TextInputAction.next,
                    validator: (val){
                      if(val!.isEmpty){
                        return  'address is required';
                      }else if(val.length < 7){
                        return 'minimum 6 character required';
                      }
                      return null;
                    },
                    controller: addressController,
                  ),
                  gapH16,
                  TextFormField(
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        hintText: 'city'
                    ),
                    textInputAction: TextInputAction.done,
                    validator: (val){
                      if(val!.isEmpty){
                        return  'city is required';
                      }
                      return null;
                    },
                    controller: cityController,
                  ),

                  gapH16,

                  ElevatedButton(
                      onPressed:auth.isLoad ? null : (){
                        FocusScope.of(context).unfocus();
                        _form.currentState!.save();
                        if(_form.currentState!.validate()){

                          ref.read(authProvider.notifier).userUpdate(
                              address: addressController.text.trim(),
                              city: cityController.text.trim(),
                              token: auth.user.token);

                        }else{
                          ref.read(mode.notifier).change();
                        }
                      },
                      child:auth.isLoad ? CircularProgressIndicator(): Text('Submit')),

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
