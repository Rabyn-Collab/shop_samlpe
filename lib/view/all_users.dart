import 'package:fireapp/export_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';



class AllUser extends ConsumerWidget {

  @override
  Widget build(BuildContext context, ref) {
    final auth = ref.watch(authProvider);
    final userData = ref.watch(users(auth.user.token));
    return Scaffold(
        body:ListView.builder(
          itemCount: userData.length,
            itemBuilder: (context, index){
            return ListTile(
              title: Text[index].,
            );
            })
    );
  }
}
