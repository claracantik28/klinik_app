import 'package:flutter/material.dart';
import '../model/pegawai.dart';
// ignore: unused_import
import 'pegawai_detail.dart';

class PegawaiItem extends StatelessWidget {
  final Pegawai pegawai;

  const PegawaiItem({super.key, required this.pegawai});

  Widget build(BuildContext context) {
    return GestureDetector(
      child: Card(
        child: ListTile(
          title: Text("${pegawai.namaPegawai}"),
        ),
      ),
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => PegawaiDetail(pegawai: pegawai)));
      },
    );
  }
}