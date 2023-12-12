// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:klinik_app/model/pasien.dart';
import '../service/pasien_service.dart';
import '../widget/sidebar.dart';
// ignore: unused_import
import 'pasien_item.dart';
import 'pegawai_form.dart';

class PasienPage extends StatefulWidget {
  const PasienPage({Key? key}) : super(key: key);
_PasienPageState createState() => _PasienPageState();
}

class _PasienPageState extends State<PasienPage> {
  Stream<List<Pasien>> getList() async* {
    List<Pasien> data = await PasienService().listData();
    yield data;
}
Future refreshData() async{
  await Future.delayed(Duration(seconds: 1));
  setState(() {
    getList();
  });
}


Widget build(BuildContext context) {
  return Scaffold(
  drawer: Sidebar(),
  appBar: AppBar(
    title: const Text("Data Pasien"),
    actions: [
      GestureDetector(
        child: const Icon(Icons.add),
        onTap: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) =>
PegawaiForm()));
            },
          )
        ],
      ),
      body: RefreshIndicator(
        onRefresh: refreshData,
        child: StreamBuilder(
          stream: getList(),
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
            return Text('Data Kosong');
          }
      
          return ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (context, index) {
              return PasienItem(pasien: snapshot.data[index]);
            },
          );
        },
          ),
      ),
  );
 }
}