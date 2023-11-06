import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/detail_ongkir_controller.dart';
import '../../home/controllers/home_controller.dart';
// import '../../../data/models/ongkir_model.dart';

class DetailOngkirView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pilihan Ongkos Kirim'),
        centerTitle: true,
      ),
      body: FutureBuilder(
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }
          return ListView.builder(
            itemCount: controller.dataOngkir.length,
            itemBuilder: (context, index) => ListTile(
              title: Text("${controller.dataOngkir[index].service}"),
              subtitle:
                  Text("Rp ${controller.dataOngkir[index].cost?[0].value}"),
            ),
          );
        },
      ),
    );
  }
}
