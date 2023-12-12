// ignore_for_file: prefer_const_constructors, deprecated_member_use, unused_import

import 'package:flutter/material.dart';
import '../model/pegawai.dart';
import '../service/pasien_service.dart';
import '../service/pegawai_service.dart';
import 'pasien_page.dart'; 
import 'pasien_update_form.dart';
import '../model/pasien.dart';


class PasienDetail extends StatefulWidget {
  final Pasien pasien;

  const PasienDetail({Key? key, required this.pasien}) : super(key: key);
  _PasienDetailState createState() => _PasienDetailState();
}

class _PasienDetailState extends State<PasienDetail> {
  Stream<Pasien> getData() async* {
    Pasien data = await PasienService().getById(widget.pasien.id.toString());
    yield data;
  }


  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Detail Pasien")),
      body: StreamBuilder(
        stream: getData(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }
          if (snapshot.connectionState != ConnectionState.done) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (!snapshot.hasData &&
              snapshot.connectionState == ConnectionState.done) {
            return Text('Data Tidak Ditemukan');
          }
          return Column(
            children: [
              SizedBox(height: 20),
              Text(
                "Nama Pasien : ${snapshot.data.namaPoli}",
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [_tombolUbah(), _tombolHapus()],
              )
            ],
          );
        },
      ),
    );
  }

_tombolUbah() {
    return StreamBuilder(
      stream: getData(),
      builder: (context, AsyncSnapshot snapshot) => ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PasienUpdateForm(pasien: snapshot.data),
            ),
          );
        },
        style: ElevatedButton.styleFrom(primary: Colors.green),
        child: const Text("Ubah"),
      ),
    );
  }

 _tombolHapus() {
    return ElevatedButton(
      onPressed: () {
        AlertDialog alertDialog = AlertDialog(
          content: const Text("Yakin ingin menghapus data ini?"),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PasienPage(),
                  ),
                );
              },
              child: const Text("YA"),
              style: ElevatedButton.styleFrom(primary: Colors.red),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Tidak"),
              style: ElevatedButton.styleFrom(primary: Colors.green),
            )
          ],
        );
        showDialog(context: context, builder: (context) => alertDialog);
      },
      style: ElevatedButton.styleFrom(primary: Colors.red),
      child: const Text("Hapus"),
    );
  }
}
