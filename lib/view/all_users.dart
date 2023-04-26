import 'package:fireapp/export_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';



class AllUser extends ConsumerWidget {

  @override
  Widget build(BuildContext context, ref) {
    final auth = ref.watch(authProvider);
    final userData = ref.watch(users(auth.user.token));
    return Scaffold(
        body: SafeArea(
          child: userData.when(data: (data){
          return  ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index){
                  return ListTile(
                   leading: Icon(Icons.person),
                   title: Text(data[index].fullname),
                   trailing: Text(data[index].isAdmin ? 'Admin': 'User'),
                  );
                });
          }, error: (err, stack) => Text('$err'), loading: () => CircularProgressIndicator()),
        )
    );
  }
}
