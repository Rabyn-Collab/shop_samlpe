import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/auth_provider.dart';




class HomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        return Scaffold(
            appBar: AppBar(

            ),
            drawer: Drawer(
              child: ListView(
                children: [
                  ListTile(
                    onTap: (){
                      ref.read(authProvider.notifier).userLogOut();
                    },
                    leading: Icon(Icons.exit_to_app),
                    title: Text('LogOut'),
                  )
                ],
              ),
            ),
            body: const Placeholder()
        );
      }
    );
  }
}
