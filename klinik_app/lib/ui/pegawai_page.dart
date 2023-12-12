import 'package:flutter/material.dart';
import 'package:klinik_app/service/pegawai_service.dart';
import '../model/pegawai.dart';
import '../widget/sidebar.dart';
import 'pegawai_item.dart';
import 'pegawai_form.dart';

class PegawaiPage extends StatefulWidget {
  const PegawaiPage({Key? key}) : super(key: key);
_PoliPageState createState() => _PoliPageState();
}

class _PoliPageState extends State<PegawaiPage> {
  Stream<List<Pegawai>> getList() async* {
    List<Pegawai> data = await PegawaiService().listData();
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
    title: const Text("Data Pegawai"),
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
              return PegawaiItem(pegawai: snapshot.data[index]);
            },
          );
        },
          ),
      ),
  );
 }
}