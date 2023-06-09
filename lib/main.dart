import 'dart:convert';

import 'package:fireapp/firebase_options.dart';
import 'package:fireapp/view/status_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'location/location_check.dart';
import 'models/cart_item.dart';
import 'models/user.dart';




final boxA = Provider<User>((ref) => User.empty());
final boxB = Provider<List<CartItem>>((ref) => []);
void main() async {

WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await Hive.initFlutter();
  Hive.registerAdapter(CartItemAdapter());
  final box = await Hive.openBox<String?>('user');
  final cartBox = await Hive.openBox<CartItem>('carts');
final bx = Hive.box<String?>('user');
  final getBox = bx.get('user');
  runApp(ProviderScope(
    overrides: [
      boxA.overrideWithValue(getBox == null ?User.empty():  User.fromJson(jsonDecode(getBox))),
      boxB.overrideWithValue(cartBox.values.toList())
    ],
      child: const Home()
  )
  );
}


class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
        home: LocationCheck()
        // StatusPage()
    );
  }
}



