import 'package:flutter/material.dart';
import 'package:klinik_app/service/pegawai_service.dart';
import '../model/pegawai.dart';
// ignore: unused_import
import 'pegawai_detail.dart';

class PegawaiForm extends StatefulWidget {
  const PegawaiForm({Key? key}) : super(key: key);
  _PegawaiFormState createState() => _PegawaiFormState();
}

class _PegawaiFormState extends State<PegawaiForm> {
  final _formKey = GlobalKey<FormState>();
  final _namaPegawaiCtrl = TextEditingController();

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Tambah Pegawai")),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextField(
                decoration: const InputDecoration(labelText: "Nama Pegawai"),
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

_fieldNamaPegawai() {
  return TextField(
    decoration: const InputDecoration(labelText: "Nama Pegawai"),
    controller: _namaPegawaiCtrl,
 );
 }

_tombolSimpan() {
    return ElevatedButton(
        onPressed: () async {
          Pegawai poli = new Pegawai(namaPegawai: _namaPegawaiCtrl.text, nip: '', tanggal_lahir: '', nomor_telepon: '', email: '', password: '');
          await PegawaiService().simpan(poli).then((value) {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => PegawaiDetail(pegawai: value)));
          });
        },
        child: const Text("Simpan"));
    }
  }