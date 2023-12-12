import 'package:flutter/material.dart';
import '../model/pasien.dart';
import '../service/pasien_service.dart';
import 'pasien_detail.dart';

class PasienForm extends StatefulWidget {
  const PasienForm({Key? key}) : super(key: key);
  _PasienFormState createState() => _PasienFormState();
}

class _PasienFormState extends State<PasienForm> {
  final _formKey = GlobalKey<FormState>();
  final _namaPoliCtrl = TextEditingController();

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Tambah Pasien")),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextField(
                decoration: const InputDecoration(labelText: "Nama Pasien"),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {},
                child: const Text("Simpan"),
              ),
            ],
          ),
        ),
      ),
    );
  }

_fieldNamaPoli() {
  return TextField(
    decoration: const InputDecoration(labelText: "Nama Pasien"),
    controller: _namaPoliCtrl,
 );
 }

_tombolSimpan() {
    return ElevatedButton(
        onPressed: () async {
          Pasien pasien = new Pasien(namaPasien: _namaPoliCtrl.text);
          await PasienService().simpan(pasien).then((value) {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => PasienDetail(pasien: value)));
          });
        },
        child: const Text("Simpan"));
    }
  }