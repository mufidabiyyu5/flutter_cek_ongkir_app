import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:ongkir_app/app/routes/app_pages.dart';

import '../../../data/models/ongkir_model.dart';

class HomeController extends GetxController {
  //TODO: Implement HomeController
  RxString provAsalId = "".obs;
  RxString cityAsalId = "".obs;
  RxString provTujuanId = "".obs;
  RxString cityTujuanId = "".obs;
  RxString kurirCode = "".obs;

  TextEditingController berat = TextEditingController();

  List<Ongkir> dataOngkir = [];

  void cekOngkir() async {
    if (provAsalId != "" &&
        cityAsalId != "" &&
        provTujuanId != "" &&
        cityTujuanId != "" &&
        kurirCode != "" &&
        berat != null) {
      try {
        var response = await http.post(
          Uri.parse("https://api.rajaongkir.com/starter/cost"),
          body: {
            "origin": cityAsalId.value,
            "destination": cityTujuanId.value,
            "weight": berat.text,
            "courier": kurirCode.value,
          },
          headers: {
            "key": "f27a4be08712d20c6f6867bc781018af",
            "content-type": "application/x-www-form-urlencoded",
          },
        );

        List ongkir = json.decode(response.body)["rajaongkir"]["results"][0]
            ["costs"] as List;
        dataOngkir = Ongkir.fromJsonList(ongkir);

        Get.toNamed(Routes.DETAIL_ONGKIR);
      } catch (e) {
        print(e);
        Get.defaultDialog(
          title: "Terjadi Kesalahan",
          middleText: "Tidak dapat mengecek ongkir",
        );
      }
    } else {
      Get.defaultDialog(
        title: "Terjadi Kesalahan",
        middleText: "Data belum lengkap, harap isi data dengan benar!",
      );
    }
  }
}
