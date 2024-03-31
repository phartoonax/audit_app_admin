// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:audit_app_admin/Project/detailrpoyek.dart';
import 'package:collection/collection.dart';

import 'package:intl/intl.dart';

import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:backendless_sdk/backendless_sdk.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'Widget/isislider.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.userdata});

  final String title = "Main Menu";
  final BackendlessUser userdata;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

bool loaded = false;

List<Map> listproyek =
    List<Map>.empty(growable: true); //ISI: PROYEK DAN SUPERVISOR
List<Map> listitemharian = List<Map>.empty(
    growable: true); //ISI: TIAP ITEM HARIAN, JENIS TRANSAKSI, PROYEK

class _MyHomePageState extends State<MyHomePage> {
  @override
  initState() {
    listproyek.clear();
    listitemharian.clear();
    init();

    super.initState();
  }

  Future<void> init() async {
    //GET ALL DATA
    //START CARI PROYEK
    DataQueryBuilder queryBuilder = DataQueryBuilder()
      ..related = ["penanggung_jawab"]
      ..relationsDepth = 1
      ..sortBy = ["created ASC"];
    setState(() {
      Backendless.data.of('proyek').find(queryBuilder).then((value) {
        if (value != null) {
          value.forEach((element) {
            Map tolist = (element as Map);
            Backendless.data
                .of('item_rekap')
                .find(DataQueryBuilder()
                  ..properties = ["Sum(biaya) as Total"]
                  ..related = ["proyek_relasi"]
                  ..groupBy = ["proyek_relasi"]
                  ..relationsDepth = 1
                  ..whereClause =
                      "proyek_relasi.objectId='${element["objectId"]}'")
                .then((values) {
              if (values != null && values.isNotEmpty) {
                tolist.addAll(values.first as Map);
              }
              setState(() {
                listproyek.add(tolist);
              });
            });
          });
        }
      });
    });
    //END CARI PROYEK
    //START CARI ITEM HARIAN
    setState(() {
      Backendless.data
          .of('harian_rekap')
          .find(DataQueryBuilder()
            ..related = ["proyek_terkait", "item_terkait.nama.jenis"]
            ..sortBy = ["tanggal DESC"]
            ..relationsDepth = 3)
          .then((values) {
        if (values != null) {
          print(values);
          values.forEach((element) {
            listitemharian.add(element as Map);
          });
          loaded = true;
        }
      });

      print("Loadded | " + loaded.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SliderDrawer(
        slider:
            SliderContent(selector: 1, userdata: widget.userdata), // ISI SLIDER
        appBar: SliderAppBar(
          //BLUE APPBAR
          appBarColor: Colors.white,
          isTitleCenter: true,
          appBarHeight: 50,
          appBarPadding: const EdgeInsets.all(5),
          title: Text(
            widget.title,
            style: const TextStyle(
                color: Colors.blue, fontSize: 32, fontWeight: FontWeight.bold),
          ),
        ),
        child: loaded
            ? SingleChildScrollView(
                scrollDirection: Axis.vertical,
                physics: BouncingScrollPhysics(),
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
                      ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: listproyek.length,
                        padding: EdgeInsets.all(4),
                        itemBuilder: (context, index) {
                          List<String> nama_Super = List.empty(growable: true);
                          (listproyek[index]['penanggung_jawab'] as List)
                              .forEach((element) {
                            nama_Super.add(element['username']);
                          });

                          List<Map> filteredharian = List.empty(growable: true);
                          if (listproyek[index].length > 9) {
                            filteredharian = listitemharian
                                .where((element) =>
                                    element['proyek_terkait']['objectId'] ==
                                    listproyek[index]['proyek_relasi']
                                        ['objectId'])
                                .toList();
                          }

                          return Card(
                            child: Theme(
                              data: Theme.of(context)
                                  .copyWith(dividerColor: Colors.transparent),
                              child: ExpansionTile(
                                  // initiallyExpanded: true,
                                  childrenPadding: EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 5),
                                  title: Padding(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 8),
                                    child: Text(
                                        listproyek[index]['nama_proyek'],
                                        style: TextStyle(
                                            fontSize: 22,
                                            fontWeight: FontWeight.bold)),
                                  ),
                                  subtitle: RichText(
                                      text: TextSpan(children: <TextSpan>[
                                    const TextSpan(
                                        text: 'Penanggung jawab: ',
                                        style: TextStyle(
                                            fontWeight: FontWeight.normal,
                                            fontSize: 16,
                                            color: Color.fromARGB(
                                                255, 71, 68, 68))),
                                    TextSpan(
                                        text: (nama_Super.join(', ')),
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                            color: Color.fromARGB(
                                                255, 105, 105, 105))),
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
                                                text:
                                                    '${CurrencyTextInputFormatter(locale: 'id', symbol: 'Rp. ', decimalDigits: 0).format(listproyek[index]['Total'].toString())} / ',
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    color: Colors.black)),
                                            TextSpan(
                                                text:
                                                    CurrencyTextInputFormatter(
                                                            locale: 'id',
                                                            symbol: 'Rp. ',
                                                            decimalDigits: 0)
                                                        .format(listproyek[
                                                                    index][
                                                                'budget_proyek']
                                                            .toString()),
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black)),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.only(top: 4),
                                        child: TextButton(
                                            onPressed: () {
                                              Navigator.pushReplacement(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          DetailProyek(
                                                            proyek: listproyek[
                                                                index],
                                                            userdata:
                                                                widget.userdata,
                                                          )));
                                            },
                                            child: Text("Detail Proyek")),
                                      )
                                    ],
                                  ),
                                  children: [
                                    Divider(
                                      endIndent: 5,
                                      indent: 5,
                                      color: Color.fromARGB(255, 99, 120, 136),
                                    ),
                                    ListView.builder(
                                      scrollDirection: Axis.vertical,
                                      shrinkWrap: true,
                                      itemCount: filteredharian.length,
                                      padding: EdgeInsets.all(4),
                                      itemBuilder: (context, indexes) {
                                        var now =
                                            filteredharian[indexes]['tanggal'];

                                        var formatter =
                                            new DateFormat('dd MMM yy');
                                        var formattedDate = formatter.format(
                                            DateTime.fromMillisecondsSinceEpoch(
                                                now));

                                        List<int> totalharian =
                                            List.empty(growable: true);

                                        (filteredharian[indexes]
                                                ['item_terkait'])
                                            .forEach((element) {
                                          totalharian.add(int.parse(
                                              element['biaya'].toString()));
                                        });
                                        (filteredharian[indexes]['item_terkait']
                                                as List)
                                            .sort((a, b) {
                                          var adate = a['waktu'];
                                          var bdate = b['waktu'];
                                          return -adate.compareTo(bdate);
                                        });

                                        return ExpansionTile(
                                            initiallyExpanded: true,
                                            title: Text(
                                                formattedDate.toString(),
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            subtitle: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Container(
                                                  child: Text(
                                                      "Pengeluaran Harian: "),
                                                ),
                                                Spacer(),
                                                Container(
                                                  margin: EdgeInsets.all(10),
                                                  child: Text(
                                                    CurrencyTextInputFormatter(
                                                            locale: 'id',
                                                            symbol: 'Rp. ',
                                                            decimalDigits: 0)
                                                        .format(totalharian.sum
                                                            .toString()),
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            children: [
                                              Card(
                                                child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Expanded(
                                                        child: Container(
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          padding:
                                                              EdgeInsets.all(8),
                                                          child: Text(
                                                              "Kegiatan",
                                                              style: TextStyle(
                                                                  fontSize: 15,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold)),
                                                        ),
                                                      ),
                                                      Container(
                                                        width: 120.w,
                                                        alignment:
                                                            Alignment.center,
                                                        padding:
                                                            EdgeInsets.all(8),
                                                        child: Text(
                                                            "Jenis Kegiatan",
                                                            style: TextStyle(
                                                                fontSize: 15,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold)),
                                                      ),
                                                      Spacer(),
                                                      Container(
                                                        width: 80,
                                                        alignment:
                                                            Alignment.center,
                                                        padding:
                                                            EdgeInsets.all(8),
                                                        child: Text("Waktu",
                                                            style: TextStyle(
                                                                fontSize: 15,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold)),
                                                      ),
                                                      Spacer(),
                                                      Expanded(
                                                        child: Container(
                                                          width: 200,
                                                          alignment: Alignment
                                                              .centerRight,
                                                          padding:
                                                              EdgeInsets.all(8),
                                                          child: Text(
                                                              "Pengeluaran",
                                                              style: TextStyle(
                                                                  fontSize: 15,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold)),
                                                        ),
                                                      ),
                                                    ]),
                                              ),
                                              ListView.builder(
                                                scrollDirection: Axis.vertical,
                                                shrinkWrap: true,
                                                itemCount:
                                                    filteredharian[indexes]
                                                            ['item_terkait']
                                                        .length,
                                                padding: EdgeInsets.all(4),
                                                itemBuilder: (context, idx) {
                                                  var nows =
                                                      filteredharian[indexes]
                                                              ['item_terkait']
                                                          [idx]['waktu'];

                                                  var formatters =
                                                      new DateFormat('h:mm a');
                                                  var formattedDates =
                                                      formatters.format(DateTime
                                                          .fromMillisecondsSinceEpoch(
                                                              nows));
                                                  return Card(
                                                    child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Expanded(
                                                            child: Container(
                                                              alignment: Alignment
                                                                  .centerLeft,
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(8),
                                                              child: Text(filteredharian[
                                                                              indexes]
                                                                          [
                                                                          'item_terkait']
                                                                      [
                                                                      idx]['nama']
                                                                  [
                                                                  'nama_transaksi']),
                                                            ),
                                                          ),
                                                          Container(
                                                            width: 120.w,
                                                            alignment: Alignment
                                                                .center,
                                                            padding:
                                                                EdgeInsets.all(
                                                                    8),
                                                            child: Text((filteredharian[
                                                                            indexes]
                                                                        [
                                                                        'item_terkait'][idx]
                                                                    [
                                                                    'nama']['jenis']
                                                                [
                                                                'nama_transaksi'])),
                                                          ),
                                                          Spacer(),
                                                          Container(
                                                            width: 80,
                                                            alignment: Alignment
                                                                .center,
                                                            padding:
                                                                EdgeInsets.all(
                                                                    8),
                                                            child: Text(
                                                                formattedDates
                                                                    .toString()),
                                                          ),
                                                          Spacer(),
                                                          Expanded(
                                                            child: Container(
                                                              width: 200,
                                                              alignment: Alignment
                                                                  .centerRight,
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(8),
                                                              child: Text(CurrencyTextInputFormatter(
                                                                      locale:
                                                                          'id',
                                                                      symbol:
                                                                          'Rp. ',
                                                                      decimalDigits:
                                                                          0)
                                                                  .format(filteredharian[indexes]['item_terkait']
                                                                              [
                                                                              idx]
                                                                          [
                                                                          'biaya']
                                                                      .toString())),
                                                            ),
                                                          ),
                                                        ]),
                                                  );
                                                },
                                              ),
                                            ]);
                                      },
                                    ),
                                  ]),
                            ),
                          );
                        },
                      )
                    ],
                  ),
                ),
              )
            : Center(
                child: SizedBox(
                  width: 100,
                  height: 100,
                  child: CircularProgressIndicator(),
                ),
              ),
      ),
    );
  }
}
