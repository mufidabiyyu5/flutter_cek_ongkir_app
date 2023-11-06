import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:dio/dio.dart';

import '../controllers/home_controller.dart';
import '../../../data/models/province_model.dart';
import '../../../data/models/city_model.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CEK ONGKOS KIRIM'),
        centerTitle: true,
      ),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          Text(
            "Lokasi Asal",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          DropdownSearch<Province>(
            dropdownDecoratorProps: const DropDownDecoratorProps(
              dropdownSearchDecoration: InputDecoration(
                labelText: "Provinsi Asal",
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 16,
                ),
              ),
            ),
            asyncItems: (text) async {
              var response = await Dio().get(
                "https://api.rajaongkir.com/starter/province",
                queryParameters: {"key": "f27a4be08712d20c6f6867bc781018af"},
              );
              var models =
                  Province.fromJsonList(response.data["rajaongkir"]["results"]);
              return models;
            },
            itemAsString: (item) => item.province!,
            popupProps: PopupProps.menu(
              showSearchBox: true,
            ),
            onChanged: (value) =>
                controller.provAsalId.value = value?.provinceId ?? "",
          ),
          SizedBox(
            height: 16,
          ),
          DropdownSearch<City>(
            dropdownDecoratorProps: const DropDownDecoratorProps(
              dropdownSearchDecoration: InputDecoration(
                labelText: "Kota/Kabupaten Asal",
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 16,
                ),
              ),
            ),
            asyncItems: (text) async {
              String prov_id = controller.provAsalId.value;
              var response = await Dio().get(
                "https://api.rajaongkir.com/starter/city?province=$prov_id",
                queryParameters: {"key": "f27a4be08712d20c6f6867bc781018af"},
              );
              var models =
                  City.fromJsonList(response.data["rajaongkir"]["results"]);
              return models;
            },
            itemAsString: (item) => "${item.type} ${item.cityName}",
            popupProps: PopupProps.menu(
              showSearchBox: true,
            ),
            onChanged: (value) =>
                controller.cityAsalId.value = value?.cityId ?? "",
          ),
          SizedBox(
            height: 32,
          ),
          Text(
            "Lokasi Tujuan",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          DropdownSearch<Province>(
            dropdownDecoratorProps: const DropDownDecoratorProps(
              dropdownSearchDecoration: InputDecoration(
                labelText: "Provinsi Tujuan",
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 16,
                ),
              ),
            ),
            asyncItems: (text) async {
              var response = await Dio().get(
                "https://api.rajaongkir.com/starter/province",
                queryParameters: {"key": "f27a4be08712d20c6f6867bc781018af"},
              );
              var models =
                  Province.fromJsonList(response.data["rajaongkir"]["results"]);
              return models;
            },
            itemAsString: (item) => item.province!,
            popupProps: PopupProps.menu(
              showSearchBox: true,
            ),
            onChanged: (value) =>
                controller.provTujuanId.value = value?.provinceId ?? "",
          ),
          SizedBox(
            height: 16,
          ),
          DropdownSearch<City>(
            dropdownDecoratorProps: const DropDownDecoratorProps(
              dropdownSearchDecoration: InputDecoration(
                labelText: "Kota/Kabupaten Tujuan",
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 16,
                ),
              ),
            ),
            asyncItems: (text) async {
              String prov_id = controller.provTujuanId.value;
              var response = await Dio().get(
                "https://api.rajaongkir.com/starter/city?province=$prov_id",
                queryParameters: {"key": "f27a4be08712d20c6f6867bc781018af"},
              );
              var models =
                  City.fromJsonList(response.data["rajaongkir"]["results"]);
              return models;
            },
            itemAsString: (item) => "${item.type} ${item.cityName}",
            popupProps: PopupProps.menu(
              showSearchBox: true,
            ),
            onChanged: (value) =>
                controller.cityTujuanId.value = value?.cityId ?? "",
          ),
          SizedBox(
            height: 32,
          ),
          Text(
            "Berat Paket (Gram)",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          TextField(
            controller: controller.berat,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(
                horizontal: 8,
                vertical: 16,
              ),
            ),
          ),
          SizedBox(
            height: 32,
          ),
          Text(
            "Pilih Kurir",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          DropdownSearch(
            dropdownDecoratorProps: const DropDownDecoratorProps(
              dropdownSearchDecoration: InputDecoration(
                labelText: "Pilih Kurir",
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 16,
                ),
              ),
            ),
            items: [
              {
                "code": "jne",
                "name": "Jalur Nugraha Ekakurir (JNE)",
              },
              {
                "code": "tiki",
                "name": "TIKI",
              },
              {
                "code": "pos",
                "name": "POS Indonesia",
              },
            ],
            itemAsString: (item) => item["name"],
            popupProps: PopupProps.menu(
              showSearchBox: true,
            ),
            onChanged: (value) =>
                controller.kurirCode.value = value?["code"] ?? "",
          ),
          SizedBox(
            height: 16,
          ),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                controller.cekOngkir();
              },
              style: ButtonStyle(
                padding: MaterialStatePropertyAll(
                  EdgeInsets.all(16),
                ),
              ),
              child: Text("CEK ONGKIR"),
            ),
          ),
        ],
      ),
    );
  }
}
