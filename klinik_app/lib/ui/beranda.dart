 import 'package:flutter/material.dart';
import 'package:klinik_app/widget/sidebar.dart';
 
 class Beranda extends StatelessWidget { 
  const Beranda({super.key}); 

 
 Widget build(BuildContext context) { 
  return Scaffold( 
    drawer: Sidebar(),
    appBar: AppBar(title: Text("Beranda")), 
    body: Center( 
      child: Text("Selamat Datang"), 
     ), 
    ); 
  } 
 }