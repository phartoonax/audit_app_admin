// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:backendless_sdk/backendless_sdk.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'Widget/isislider.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  final String title = "Main Menu";

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SliderDrawer(
        slider: SliderContent(selector: 1), // ISI SLIDER
        appBar: SliderAppBar(
          //BLUE APPBAR
          appBarColor: Colors.blue,
          isTitleCenter: true,
          appBarHeight: 50,
          appBarPadding: const EdgeInsets.all(5),
          title: Text(
            widget.title,
            style: const TextStyle(
                color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold),
          ),
        ),
        child: Container(
          //MAIN CONTENT
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(20),
                alignment: Alignment.centerLeft,
                child: Text(
                  'Halaman Utama: Rangkuman Proyek',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ),
              Container(
                padding: const EdgeInsets.all(10),
                margin: EdgeInsets.symmetric(horizontal: 4.w),
                alignment: Alignment.centerLeft,
                child: Text(
                  'Lihat Rangkuman Proyek dibawah ini:',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              Card(
                child: Theme(
                  data: Theme.of(context)
                      .copyWith(dividerColor: Colors.transparent),
                  child: ExpansionTile(
                      //WIDGET THIS
                      childrenPadding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                      title: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: const Text("Maranatha",
                            style: TextStyle(
                                fontSize: 22, fontWeight: FontWeight.bold)),
                      ),
                      subtitle: RichText(
                          text: TextSpan(children: <TextSpan>[
                        const TextSpan(
                            text: 'Penanggung jawab: ',
                            style: TextStyle(
                                fontWeight: FontWeight.normal,
                                fontSize: 16,
                                color: Color.fromARGB(255, 71, 68, 68))),
                        TextSpan(
                            text: 'Yulius',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: Color.fromARGB(255, 105, 105, 105))),
                      ])),
                      trailing: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          RichText(
                            text: TextSpan(
                              //WIDGET THIS
                              children: <TextSpan>[
                                const TextSpan(
                                    text: 'Alokasi Pendanaan: ',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black)),
                                TextSpan(
                                    text: 'Rp. 5.000.000/',
                                    style: TextStyle(
                                        fontWeight: FontWeight.normal,
                                        color: Colors.black)),
                                TextSpan(
                                    text: 'Rp. 20.000.000',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black)),
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(top: 4),
                            child: TextButton(
                                onPressed: () {}, child: Text("Detail Proyek")),
                          )
                        ],
                      ),
                      children: [
                        ExpansionTile(
                            // TANGGAL
                            title: Text("09/01/2023",
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold)),
                            subtitle: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                  child: Text("Pengeluaran Harian: "),
                                ),
                                Spacer(),
                                Container(
                                  margin: EdgeInsets.all(10),
                                  child: Text("Rp. 500.000"),
                                ),
                              ],
                            ),
                            children: [
                              Card(
                                child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Container(
                                          alignment: Alignment.centerLeft,
                                          padding: EdgeInsets.all(8),
                                          child: Text("Kegiatan",
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold)),
                                        ),
                                      ),
                                      Spacer(),
                                      Container(
                                        width: 80,
                                        alignment: Alignment.center,
                                        padding: EdgeInsets.all(8),
                                        child: Text("Waktu",
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold)),
                                      ),
                                      Spacer(),
                                      Expanded(
                                        child: Container(
                                          width: 200,
                                          alignment: Alignment.centerRight,
                                          padding: EdgeInsets.all(8),
                                          child: Text("Pengeluaran",
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold)),
                                        ),
                                      ),
                                    ]),
                              ),
                              Card(
                                child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Container(
                                          alignment: Alignment.centerLeft,
                                          padding: EdgeInsets.all(8),
                                          child: Text(
                                              "Duis exercitation pariatur exercitation ad amet adipisicing enim proident do."),
                                        ),
                                      ),
                                      Spacer(),
                                      Container(
                                        width: 80,
                                        alignment: Alignment.center,
                                        padding: EdgeInsets.all(8),
                                        child: Text("07.00"),
                                      ),
                                      Spacer(),
                                      Expanded(
                                        child: Container(
                                          width: 200,
                                          alignment: Alignment.centerRight,
                                          padding: EdgeInsets.all(8),
                                          child: Text("Rp. 90.000.000"),
                                        ),
                                      ),
                                    ]),
                              ),
                              Card(
                                child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Container(
                                          alignment: Alignment.centerLeft,
                                          padding: EdgeInsets.all(8),
                                          child: Text(
                                              "Irure sunt commodo reprehenderit "),
                                        ),
                                      ),
                                      Spacer(),
                                      Container(
                                        width: 80,
                                        alignment: Alignment.center,
                                        padding: EdgeInsets.all(8),
                                        child: Text("14.00"),
                                      ),
                                      Spacer(),
                                      Expanded(
                                        child: Container(
                                          width: 200,
                                          alignment: Alignment.centerRight,
                                          padding: EdgeInsets.all(8),
                                          child: Text("Rp. 200.000"),
                                        ),
                                      ),
                                    ]),
                              ),
                            ]),
                        ExpansionTile(
                            // TANGGAL
                            title: Text("09/01/2023",
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold)),
                            subtitle: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                  child: Text("Pengeluaran Harian: "),
                                ),
                                Spacer(),
                                Container(
                                  margin: EdgeInsets.all(10),
                                  child: Text("Rp. 500.000"),
                                ),
                              ],
                            ),
                            children: [
                              Card(
                                child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Container(
                                          alignment: Alignment.centerLeft,
                                          padding: EdgeInsets.all(8),
                                          child: Text("Kegiatan",
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold)),
                                        ),
                                      ),
                                      Spacer(),
                                      Container(
                                        width: 80,
                                        alignment: Alignment.center,
                                        padding: EdgeInsets.all(8),
                                        child: Text("Waktu",
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold)),
                                      ),
                                      Spacer(),
                                      Expanded(
                                        child: Container(
                                          width: 200,
                                          alignment: Alignment.centerRight,
                                          padding: EdgeInsets.all(8),
                                          child: Text("Pengeluaran",
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold)),
                                        ),
                                      ),
                                    ]),
                              ),
                              Card(
                                child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Container(
                                          alignment: Alignment.centerLeft,
                                          padding: EdgeInsets.all(8),
                                          child: Text(
                                              "Ex reprehenderit consequat aliqua ut labore incididunt ex do occaecat."),
                                        ),
                                      ),
                                      Spacer(),
                                      Container(
                                        width: 80,
                                        alignment: Alignment.center,
                                        padding: EdgeInsets.all(8),
                                        child: Text("07.00"),
                                      ),
                                      Spacer(),
                                      Expanded(
                                        child: Container(
                                          width: 200,
                                          alignment: Alignment.centerRight,
                                          padding: EdgeInsets.all(8),
                                          child: Text("Rp. 90.000.000"),
                                        ),
                                      ),
                                    ]),
                              ),
                              Card(
                                child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Container(
                                          alignment: Alignment.centerLeft,
                                          padding: EdgeInsets.all(8),
                                          child: Text(
                                              "Pariatur exercitation nostrud ex consectetur excepteur nisi aliquip ea adipisicing cupidatat."),
                                        ),
                                      ),
                                      Spacer(),
                                      Container(
                                        width: 80,
                                        alignment: Alignment.center,
                                        padding: EdgeInsets.all(8),
                                        child: Text("14.00"),
                                      ),
                                      Spacer(),
                                      Expanded(
                                        child: Container(
                                          width: 200,
                                          alignment: Alignment.centerRight,
                                          padding: EdgeInsets.all(8),
                                          child: Text("Rp. 200.000"),
                                        ),
                                      ),
                                    ]),
                              ),
                            ]),
                      ]),
                ),
              ),
              Card(
                child: Theme(
                  data: Theme.of(context)
                      .copyWith(dividerColor: Colors.transparent),
                  child: ExpansionTile(
                      //WIDGET THIS
                      childrenPadding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                      title: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: const Text("Perumahan",
                            style: TextStyle(
                                fontSize: 22, fontWeight: FontWeight.bold)),
                      ),
                      subtitle: RichText(
                          text: TextSpan(children: <TextSpan>[
                        const TextSpan(
                            text: 'Penanggung jawab: ',
                            style: TextStyle(
                                fontWeight: FontWeight.normal,
                                fontSize: 16,
                                color: Color.fromARGB(255, 71, 68, 68))),
                        TextSpan(
                            text: 'Yulius',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: Color.fromARGB(255, 105, 105, 105))),
                      ])),
                      trailing: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          RichText(
                            text: TextSpan(
                              //WIDGET THIS
                              children: <TextSpan>[
                                const TextSpan(
                                    text: 'Alokasi Pendanaan: ',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black)),
                                TextSpan(
                                    text: 'Rp. 5.000.000/',
                                    style: TextStyle(
                                        fontWeight: FontWeight.normal,
                                        color: Colors.black)),
                                TextSpan(
                                    text: 'Rp. 20.000.000',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black)),
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(top: 4),
                            child: TextButton(
                                onPressed: () {}, child: Text("Detail Proyek")),
                          )
                        ],
                      ),
                      children: [
                        ExpansionTile(
                            // TANGGAL
                            title: Text("09/01/2023",
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold)),
                            subtitle: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                  child: Text("Pengeluaran Harian: "),
                                ),
                                Spacer(),
                                Container(
                                  margin: EdgeInsets.all(10),
                                  child: Text("Rp. 500.000"),
                                ),
                              ],
                            ),
                            children: [
                              Card(
                                child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Container(
                                          alignment: Alignment.centerLeft,
                                          padding: EdgeInsets.all(8),
                                          child: Text("Kegiatan",
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold)),
                                        ),
                                      ),
                                      Spacer(),
                                      Container(
                                        width: 80,
                                        alignment: Alignment.center,
                                        padding: EdgeInsets.all(8),
                                        child: Text("Waktu",
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold)),
                                      ),
                                      Spacer(),
                                      Expanded(
                                        child: Container(
                                          width: 200,
                                          alignment: Alignment.centerRight,
                                          padding: EdgeInsets.all(8),
                                          child: Text("Pengeluaran",
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold)),
                                        ),
                                      ),
                                    ]),
                              ),
                              Card(
                                child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Container(
                                          alignment: Alignment.centerLeft,
                                          padding: EdgeInsets.all(8),
                                          child: Text(
                                              "Duis exercitation pariatur exercitation ad amet adipisicing enim proident do."),
                                        ),
                                      ),
                                      Spacer(),
                                      Container(
                                        width: 80,
                                        alignment: Alignment.center,
                                        padding: EdgeInsets.all(8),
                                        child: Text("07.00"),
                                      ),
                                      Spacer(),
                                      Expanded(
                                        child: Container(
                                          width: 200,
                                          alignment: Alignment.centerRight,
                                          padding: EdgeInsets.all(8),
                                          child: Text("Rp. 90.000.000"),
                                        ),
                                      ),
                                    ]),
                              ),
                              Card(
                                child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Container(
                                          alignment: Alignment.centerLeft,
                                          padding: EdgeInsets.all(8),
                                          child: Text(
                                              "Irure sunt commodo reprehenderit "),
                                        ),
                                      ),
                                      Spacer(),
                                      Container(
                                        width: 80,
                                        alignment: Alignment.center,
                                        padding: EdgeInsets.all(8),
                                        child: Text("14.00"),
                                      ),
                                      Spacer(),
                                      Expanded(
                                        child: Container(
                                          width: 200,
                                          alignment: Alignment.centerRight,
                                          padding: EdgeInsets.all(8),
                                          child: Text("Rp. 200.000"),
                                        ),
                                      ),
                                    ]),
                              ),
                            ]),
                        ExpansionTile(
                            // TANGGAL
                            title: Text("09/01/2023",
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold)),
                            subtitle: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                  child: Text("Pengeluaran Harian: "),
                                ),
                                Spacer(),
                                Container(
                                  margin: EdgeInsets.all(10),
                                  child: Text("Rp. 500.000"),
                                ),
                              ],
                            ),
                            children: [
                              Card(
                                child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Container(
                                          alignment: Alignment.centerLeft,
                                          padding: EdgeInsets.all(8),
                                          child: Text("Kegiatan",
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold)),
                                        ),
                                      ),
                                      Spacer(),
                                      Container(
                                        width: 80,
                                        alignment: Alignment.center,
                                        padding: EdgeInsets.all(8),
                                        child: Text("Waktu",
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold)),
                                      ),
                                      Spacer(),
                                      Expanded(
                                        child: Container(
                                          width: 200,
                                          alignment: Alignment.centerRight,
                                          padding: EdgeInsets.all(8),
                                          child: Text("Pengeluaran",
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold)),
                                        ),
                                      ),
                                    ]),
                              ),
                              Card(
                                child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Container(
                                          alignment: Alignment.centerLeft,
                                          padding: EdgeInsets.all(8),
                                          child: Text(
                                              "Ex reprehenderit consequat aliqua ut labore incididunt ex do occaecat."),
                                        ),
                                      ),
                                      Spacer(),
                                      Container(
                                        width: 80,
                                        alignment: Alignment.center,
                                        padding: EdgeInsets.all(8),
                                        child: Text("07.00"),
                                      ),
                                      Spacer(),
                                      Expanded(
                                        child: Container(
                                          width: 200,
                                          alignment: Alignment.centerRight,
                                          padding: EdgeInsets.all(8),
                                          child: Text("Rp. 90.000.000"),
                                        ),
                                      ),
                                    ]),
                              ),
                              Card(
                                child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Container(
                                          alignment: Alignment.centerLeft,
                                          padding: EdgeInsets.all(8),
                                          child: Text(
                                              "Pariatur exercitation nostrud ex consectetur excepteur nisi aliquip ea adipisicing cupidatat."),
                                        ),
                                      ),
                                      Spacer(),
                                      Container(
                                        width: 80,
                                        alignment: Alignment.center,
                                        padding: EdgeInsets.all(8),
                                        child: Text("14.00"),
                                      ),
                                      Spacer(),
                                      Expanded(
                                        child: Container(
                                          width: 200,
                                          alignment: Alignment.centerRight,
                                          padding: EdgeInsets.all(8),
                                          child: Text("Rp. 200.000"),
                                        ),
                                      ),
                                    ]),
                              ),
                            ]),
                      ]),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
