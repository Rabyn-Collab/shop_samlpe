import 'package:fireapp/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'auth/login_page.dart';
import 'home_page.dart';


class StatusPage extends ConsumerWidget {

  @override
  Widget build(BuildContext context, ref) {
    final data = ref.watch(authProvider);
    return Scaffold(
        body: data.user.token == 'no-data' ? LoginPage(): HomePage()
    );
  }
}
