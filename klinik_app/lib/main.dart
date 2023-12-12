import 'package:flutter/material.dart';
import 'package:klinik_app/helpers/user_info.dart';
import 'package:klinik_app/ui/beranda.dart';
import 'package:klinik_app/ui/login.dart';

Future<void> main() async {
    WidgetsFlutterBinding.ensureInitialized();
    var token = await UserInfo().getToken();
    print(token);
    runApp(MaterialApp(
      title: "Klinik APP",
      debugShowCheckedModeBanner: false,
      home: token == null ? Login() : Beranda(),
    ));
 }