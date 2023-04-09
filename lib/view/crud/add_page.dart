// import 'dart:io';
// import 'package:fireapp/common_provider/other_provider.dart';
// import 'package:fireapp/commons_widgets/snack_shows.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:get/get.dart';
// import '../../constants/sizes.dart';
// import '../../providers/crud_provider.dart';
//
//
// class AddPage extends ConsumerWidget {
//
//   final titleController = TextEditingController();
//   final detailController = TextEditingController();
//   final _form = GlobalKey<FormState>();
//
//
//   @override
//   Widget build(BuildContext context, ref) {
//
//     ref.listen(crudProvider, (previous, next) {
//       if(next.isError){
//         SnackShow.showError(next.errText);
//       }else if (next.isSuccess){
//         Get.back();
//         SnackShow.showSuccess('success');
//       }
//     });
//
//     final auth = ref.watch(crudProvider);
//     final mod = ref.watch(mode);
//     final pass = ref.watch(passHide);
//     final image = ref.watch(imageProvider);
//     return WillPopScope(
//       onWillPop: ()async{
//         if(auth.isLoad){
//           return false;
//         }
//         return true;
//       },
//       child: Scaffold(
//         body: SafeArea(
//           child: Form(
//             autovalidateMode: mod,
//             key: _form,
//             child: Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
//               child: ListView(
//                 children: [
//                   Text('Add Form'),
//                   gapH32,
//                 TextFormField(
//                     keyboardType: TextInputType.text,
//                     inputFormatters: [
//                       LengthLimitingTextInputFormatter(10)
//                     ],
//                     decoration: InputDecoration(
//                         hintText: 'Title'
//                     ),
//                     textInputAction: TextInputAction.next,
//                     validator: (val){
//                       if(val!.isEmpty){
//                         return  'title is required';
//                       }else if(val.length < 7){
//                         return 'minimum 6 character required';
//                       }
//                       return null;
//                     },
//                     controller: titleController,
//                   ),
//                   gapH16,
//                   TextFormField(
//                     keyboardType: TextInputType.text,
//                     decoration: InputDecoration(
//                         hintText: 'Detail'
//                     ),
//                     textInputAction: TextInputAction.done,
//                     validator: (val){
//                       if(val!.isEmpty){
//                         return  'detail is required';
//                       }
//                       return null;
//                     },
//                     controller: detailController,
//                   ),
//
//                   gapH24,
//                    InkWell(
//                       onTap: (){
//                         Get.defaultDialog(
//                             title: 'Choose From',
//                             content: Column(
//                               children: [
//                                 TextButton(onPressed: (){
//                                   Navigator.of(context).pop();
//                                   ref.read(imageProvider.notifier).pickImage(true);
//                                 }, child: Text('Camera')),
//                                 TextButton(onPressed: (){
//                                   Navigator.of(context).pop();
//                                   ref.read(imageProvider.notifier).pickImage(false);
//                                 }, child: Text('Gallery')),
//                               ],
//                             )
//                         );
//
//                       },
//                       child: Container(
//                         height: 100,
//                         width: 100,
//                         decoration: BoxDecoration(
//                             border: Border.all(color: Colors.white)
//                         ),
//                         child: image == null ? Center(child: Text('please select an image')) : Image.file(File(image.path)),
//                       )),
//                   gapH16,
//
//                   ElevatedButton(
//                       onPressed:auth.isLoad ? null : (){
//                         FocusScope.of(context).unfocus();
//                         _form.currentState!.save();
//                         if(_form.currentState!.validate()){
//
//                             if(image == null){
//                               SnackShow.showError('please select an image');
//                             }else{
//                               ref.read(crudProvider.notifier).createPost(
//                                  title: titleController.text.trim(),
//                                   detail: detailController.text.trim(),
//                                   userId: FirebaseAuth.instance.currentUser!.uid,
//                                   image: image
//                               );
//                             }
//
//                         }else{
//                           ref.read(mode.notifier).change();
//                         }
//                       },
//                       child:auth.isLoad ? CircularProgressIndicator(): Text('Submit')),
//
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
