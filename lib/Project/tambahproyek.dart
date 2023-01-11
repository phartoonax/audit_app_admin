import 'dart:developer';

import 'package:audit_app_admin/Widget/isislider.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:backendless_sdk/backendless_sdk.dart';
import 'package:flutter/services.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:multi_select_flutter/multi_select_flutter.dart';

class TambahProyek extends StatefulWidget {
  const TambahProyek({super.key});
  final String title = "Tambah User";
  @override
  State<TambahProyek> createState() => _TambahProyekState();
}

bool loaded = false;

List<Map> listuser = List.empty(growable: true);

class _TambahProyekState extends State<TambahProyek> {
  @override
  initState() {
    Backendless.data.of('Users').find().then((value) {
      setState(() {
        if (value != null) {
          listuser.clear();
          value.forEach((element) {
            listuser.add(element as Map);
            log(listuser.toString());
          });
          loaded = true;
        }
      });
    });
    super.initState();
  }

  late final TextEditingController proyeknamaController =
      TextEditingController();
  late final TextEditingController danaController = TextEditingController();
  int danaalok = 0;
  String? onerror;
  final _formKey = GlobalKey<FormState>();
  List dropdownuser = List.empty(growable: true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SliderDrawer(
        slider: const SliderContent(selector: 3), // ISI SLIDER
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
        child: loaded
            ? Container(
                //MAIN CONTENT
                color: Colors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.all(20),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Tambah Proyek',
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(10),
                      margin: EdgeInsets.symmetric(horizontal: 4.w),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Isi form dibawah ini:',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.all(8),
                      margin: const EdgeInsets.all(20),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 200.w,
                              // height: 30.h,
                              padding: const EdgeInsets.all(5),
                              margin: const EdgeInsets.all(20),
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: 50.w,
                                      padding: const EdgeInsets.all(5),
                                      child: const Text(
                                        "Nama Proyek : ",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    const Spacer(
                                      flex: 1,
                                    ),
                                    Container(
                                      alignment: Alignment.center,
                                      padding: const EdgeInsets.all(5),
                                      width: 100.w,
                                      child: TextFormField(
                                        decoration: const InputDecoration(
                                          border: OutlineInputBorder(),
                                          hintText: 'Masukan Nama Proyek',
                                        ),
                                        keyboardType: TextInputType.text,
                                        controller: proyeknamaController,
                                        validator: (val) {
                                          if (val!.isEmpty) {
                                            return 'Nama Tidak boleh Kosong';
                                          }
                                          return null;
                                        },
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 18,
                                            fontWeight: FontWeight.normal),
                                      ),
                                    ),
                                    const Spacer(
                                      flex: 4,
                                    ),
                                  ]),
                            ),
                            Container(
                              //next input
                              width: 200.w,

                              padding: const EdgeInsets.all(5),
                              margin: const EdgeInsets.all(20),

                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: 50.w,
                                      padding: const EdgeInsets.all(5),
                                      child: const Text(
                                        "Alokasi Dana : ",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    const Spacer(
                                      flex: 1,
                                    ),
                                    Container(
                                      alignment: Alignment.center,
                                      padding: const EdgeInsets.all(5),
                                      width: 100.w,
                                      child: TextFormField(
                                        keyboardType: TextInputType.number,
                                        controller: danaController,
                                        validator: (val) {
                                          if (val!.isEmpty) {
                                            return 'Dana Tidak boleh Kosong';
                                          }
                                          return null;
                                        },
                                        inputFormatters: [
                                          FilteringTextInputFormatter
                                              .digitsOnly,
                                          CurrencyTextInputFormatter(
                                              locale: 'id',
                                              symbol: 'Rp. ',
                                              decimalDigits: 0)
                                        ],
                                        decoration: const InputDecoration(
                                          border: OutlineInputBorder(),
                                          hintText: 'Masukan Alokasi Dana',
                                        ),
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 16,
                                            fontWeight: FontWeight.normal),
                                      ),
                                    ),
                                    const Spacer(
                                      flex: 4,
                                    ),
                                  ]),
                            ),
                            Container(
                              //next input
                              width: 200.w,
                              height: 70.h,
                              padding: const EdgeInsets.all(5),
                              margin: const EdgeInsets.all(20),
                              // color: Colors.blue,
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: 50.w,
                                      // color: Colors.amber,
                                      padding: const EdgeInsets.all(5),
                                      child: const Text(
                                        "Penanggung Jawab : ",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    const Spacer(
                                      flex: 1,
                                    ),
                                    Container(
                                      width: 100.w,
                                      height: 70.h,
                                      // color: Colors.red,
                                      child: MultiSelectDialogField(
                                        listType: MultiSelectListType.CHIP,
                                        items: listuser.map((Map item) {
                                          return MultiSelectItem(item,
                                              item["username"].toString());
                                        }).toList(),
                                        title: const Text("Penanggung Jawab"),
                                        selectedColor: Colors.blue,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color: Colors.grey,
                                            width: 1,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                        buttonText: const Text(
                                          "Pilih Supervisor",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 16,
                                              fontWeight: FontWeight.normal),
                                        ),
                                        onConfirm: (results) {
                                          dropdownuser = results;
                                        },
                                        chipDisplay: MultiSelectChipDisplay(
                                          onTap: (item) {
                                            setState(() {
                                              dropdownuser.remove(item);
                                            });
                                          },
                                        ),
                                      ),
                                    ),
                                    const Spacer(
                                      flex: 4,
                                    ),
                                  ]),
                            ),
                            Container(
                              //BUTTON
                              padding: const EdgeInsets.all(5),
                              margin: const EdgeInsets.all(20),
                              height: 40.h,
                              width: 30.w,
                              child: ElevatedButton(
                                  onPressed: () {
                                    danaalok = int.parse(danaController.text
                                        .replaceAll(new RegExp(r'[^0-9]'), ''));
                                    print("text | " + (danaController.text));
                                    print("val | $danaalok");
                                    if (_formKey.currentState!.validate()) {
                                      List<String> idsupervisor =
                                          List.empty(growable: true);
                                      List<String> namasupervisor =
                                          List.empty(growable: true);
                                      dropdownuser.forEach((element) {
                                        idsupervisor.add(element['objectId']);
                                        namasupervisor.add(element['username']);
                                      });
                                      Map projtemp = Map();
                                      projtemp = {
                                        "nama_proyek":
                                            proyeknamaController.text,
                                        "budget_proyek": danaalok,
                                      };
                                      Backendless.data
                                          .of("proyek")
                                          .save(projtemp)
                                          .then((proj) {
                                        Backendless.data
                                            .of("proyek")
                                            .setRelation(proj?['objectId'],
                                                "penanggung_jawab",
                                                childrenObjectIds: idsupervisor)
                                            .then((value) {
                                          final sbarnoticeabsen = SnackBar(
                                            behavior: SnackBarBehavior.floating,
                                            duration: Duration(seconds: 4),
                                            content: Text(
                                                "Tambah Proyek Berhasi! ${proj!["nama_proyek"]} berhasil ditambahkan dengan penanggung jawab $namasupervisor"),
                                            action: SnackBarAction(
                                              label: 'OK',
                                              onPressed: () =>
                                                  ScaffoldMessenger.of(context)
                                                      .hideCurrentSnackBar(),
                                            ),
                                          );
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(sbarnoticeabsen);
                                          _formKey.currentState!.reset();
                                        });
                                      }).catchError((onError, stackTrace) {
                                        print(
                                            "There has been an error outside: $onError");
                                        PlatformException platformException =
                                            onError;
                                        print(
                                            "Server reported an error outside.");
                                        print(
                                            "Exception code: ${platformException.code}");
                                        print(
                                            "Exception details: ${platformException.details}");
                                        print("Stacktrace: $stackTrace");
                                        onerror = platformException.details;
                                        final sbarnoticeabsen = SnackBar(
                                          duration: Duration(seconds: 10),
                                          content: Text(
                                              "telah terjadi sebuah error. ${platformException.details}"),
                                          action: SnackBarAction(
                                            label: 'OK',
                                            onPressed: () =>
                                                ScaffoldMessenger.of(context)
                                                    .hideCurrentSnackBar(),
                                          ),
                                        );
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(sbarnoticeabsen);
                                      }, test: (e) => e is PlatformException);
                                    }
                                  },
                                  child: const Text("Tambah Proyek",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold))),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              )
            : Column(
                children: const [
                  SizedBox(
                    width: 60,
                    height: 60,
                    child: CircularProgressIndicator(),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 16),
                    child: Text('Loading Options...'),
                  ),
                ],
              ),
      ),
    );
  }
}
